library(dplyr)
library(stringr)

make_anvil_repo_table <- function(exclude = NULL) {
  # Read in AnVIL repos found by GHA
  df <- tryCatch(
    # Check for the file created by GHA
    expr = {
      df <-
        readr::read_tsv("resources/AnVIL_repos.tsv")
      
      # Filter out any user specified repos (could be some that are in progress,
      # templates, etc)
      df <-
        df %>%
        filter(!(name %in% exclude)) 
      
      # Do some cleaning of strings
      df$name <-
        df$name %>%
        stringr::str_replace_all("_Book_", ": ") %>%
        stringr::str_replace_all("_", " ")
      
      # Concatenate columns to create links
      df <-
        df %>% 
        mutate(`Book Name` = paste0("[", name, "](", homepage, ") ([github](", html_url, "))")) %>% 
        arrange(`Book Name`) %>%
        rename(Description = description, Topics = topics) %>% 
        select(`Book Name`, Description, Topics)
      
      message("Colnames are: \n", paste(colnames(df), collapse='\n'))
      
      return(df)
    },
    # Will error out if file doesn't exist - provides a blank tibble instead
    error = function(e) {
      df <- tibble(name = "none", html_url = "none")
      
      message("Rendering table of AnVIL collection failed. Please try rerunning the workflow or if needed, create an issue in the AnVIL_Template repository at https://github.com/jhudsl/AnVIL_Template.")
      
      return(df)
    }
  )
}