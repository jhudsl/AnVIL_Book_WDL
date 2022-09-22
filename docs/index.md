---
title: "WDL Workflows"
date: "September 22, 2022"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: "Description about Course/Book."
favicon: assets/AnVIL_style/anvil_favicon.ico
output:
    bookdown::word_document2:
      toc: true
---

# Overview {-}

This book introduces WDL Workflows on AnVIL.  After introducing several concepts, including basic WDL syntax, we present hands-on exercises to run a workflow, write a WDL, localize a file, customize a Docker image, and join the Discourse.  No local software installation is required as each exercise leverages web-based resources.

![](index_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g1397c25e58c_0_2.png)<!-- -->

## Skills Level {-}

::: {.notice}
_Genetics_  
**Novice**: No genetics knowledge needed

_Programming skills_  
**Novice**: No programming experience needed
:::

## Learning Objectives {-}

- Understand when WDL Workflows are the right tool
- Run a Workflow on AnVIL
- Write a WDL using Broad Methods Repository
- Bring your own data to analyze
- Customize your Docker environment
- Join the conversation

## AnVIL Collection {-}

Please check out our full collection of AnVIL resources below!

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Book Name </th>
   <th style="text-align:left;"> Description </th>
   <th style="text-align:left;"> Topics </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> [AnVIL Phylogenetic-Techniques](https://jhudatascience.org/AnVIL_Phylogenetic-Techniques/) ([github](https://github.com/jhudsl/AnVIL_Phylogenetic-Techniques)) </td>
   <td style="text-align:left;"> A semester-long course on the basics of molecular phylogenetic techniques </td>
   <td style="text-align:left;"> anvil </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [AnVIL: Getting Started](https://jhudatascience.org/AnVIL_Book_Getting_Started) ([github](https://github.com/jhudsl/AnVIL_Book_Getting_Started)) </td>
   <td style="text-align:left;"> A guide for getting started using AnVIL </td>
   <td style="text-align:left;"> anvil, cloud-computing </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [AnVIL: Instructor Guide](https://jhudatascience.org/AnVIL_Book_Instructor_Guide) ([github](https://github.com/jhudsl/AnVIL_Book_Instructor_Guide)) </td>
   <td style="text-align:left;"> A guide for instructors using AnVIL for workshops, lessons, or courses. </td>
   <td style="text-align:left;"> anvil, education </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: SARS Galaxy on AnVIL](https://jhudatascience.org/GDSCN_Book_SARS_Galaxy_on_AnVIL/) ([github](https://github.com/jhudsl/GDSCN_Book_SARS_Galaxy_on_AnVIL)) </td>
   <td style="text-align:left;"> Lab module and lectures for variant detection in SARS-CoV-2 using Galaxy </td>
   <td style="text-align:left;"> anvil, genomics, module </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: Statistics for Genomics Differential Expression](https://jhudatascience.org/GDSCN_Book_Statistics_for_Genomics_Differential_Expression/) ([github](https://github.com/jhudsl/GDSCN_Book_Statistics_for_Genomics_Differential_Expression)) </td>
   <td style="text-align:left;"> A set of lab modules for an introduction to differential gene expression </td>
   <td style="text-align:left;"> anvil, cloud-computing, gene-expression </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: Statistics for Genomics PCA](https://jhudatascience.org/GDSCN_Book_Statistics_for_Genomics_PCA/) ([github](https://github.com/jhudsl/GDSCN_Book_Statistics_for_Genomics_PCA)) </td>
   <td style="text-align:left;"> A set of lab modules for PCA analysis </td>
   <td style="text-align:left;"> anvil </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: Statistics for Genomics RNA-seq](https://jhudatascience.org/GDSCN_Book_Statistics_for_Genomics_RNA-seq/) ([github](https://github.com/jhudsl/GDSCN_Book_Statistics_for_Genomics_RNA-seq)) </td>
   <td style="text-align:left;"> A set of lab modules for RNA-seq analysis </td>
   <td style="text-align:left;"> anvil </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: Statistics for Genomics scRNA-seq](http://jhudatascience.org/GDSCN_Book_Statistics_for_Genomics_scRNA-seq/) ([github](https://github.com/jhudsl/GDSCN_Book_Statistics_for_Genomics_scRNA-seq)) </td>
   <td style="text-align:left;"> A set of lab modules for single cell RNA-seq analysis </td>
   <td style="text-align:left;"> anvil </td>
  </tr>
</tbody>
</table>
