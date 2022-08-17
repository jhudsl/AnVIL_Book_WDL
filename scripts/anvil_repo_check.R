#!/usr/bin/env Rscript

library(optparse)
library(httr)
library(jsonlite)
library(dplyr)
library(readr)

option_list <- list(
  optparse::make_option(
    c("--git_pat"),
    type = "character",
    default = NULL,
    help = "GitHub personal access token",
  )
)

# Read the GH_PAT argument
opt_parser <- optparse::OptionParser(option_list = option_list)
opt <- optparse::parse_args(opt_parser)
git_pat <- opt$git_pat

message(paste("Querying Github API..."))

# Request search results specific to AnVIL within the jhudsl organization
# and provide the appropriate GH token
req <- httr::GET(
  "https://api.github.com/search/repositories?q=user:jhudsl&per_page=500",
  httr::add_headers(Authorization = paste("token", git_pat))
)

if (!(httr::http_error(req))) {
  message(paste("API request successful!"))

  # Read in and save data
  repo_dat <-
    jsonlite::fromJSON(httr::content(req, as = "text"), flatten = TRUE)
  
  message(paste("...", repo_dat$total_count, "organization repositories detected."))
  
  # Modify the request results to get what we need
  repo_df <-
    dplyr::tibble(repo_dat$items) %>%
    dplyr::select(name, homepage, html_url, description) %>%
    # Search for AnVIL in topics
    dplyr::bind_cols(tibble(anvil = unlist(
      lapply(repo_dat$items$topics, function(x) {
        "anvil" %in% x
      })
    ))) %>% 
    # Collapse topics so they can be printed
    dplyr::bind_cols(tibble(topics = unlist(
      lapply(repo_dat$items$topics, paste, collapse = ", ")
    ))) %>% 
    # Filter for anvil tag
    dplyr::filter(anvil) %>% 
    dplyr::relocate(description, .before = topics)
  
  message(paste("...", nrow(repo_df), "repositories with AnVIL topic tagged."))
  
  # Ensure no missing homepage / description
  repo_df <- 
    repo_df %>% filter(!(is.na(homepage)), homepage != "", !(is.na(description)))
  
  message(paste("...", nrow(repo_df), "repositories with homepage & description."))
  
  # Create an artifact file containing the AnVIL repos, else write an empty file
  if (!dir.exists("resources")) {
    dir.create("resources")
  }
  if (nrow(repo_df) > 0) {
    readr::write_tsv(repo_df, file.path('resources', 'AnVIL_repos.tsv'))
  } else {
    readr::write_tsv(tibble(), file.path('resources', 'AnVIL_repos.tsv'))
  }
  
} else {
  message(paste("API request failed!"))
  if (!dir.exists("resources")) {
    dir.create("resources")
  }
  readr::write_tsv(tibble(), file.path('resources', 'AnVIL_repos.tsv'))
}
