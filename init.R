library(shiny)
library(odbc)
library(DBI)
library(stringr)
library(dplyr)
library(shinyjs)

source_directory <- function(dirpath, exclude = c()){
  if(length(exclude) == 0){
    files <- list.files(dirpath, pattern = ".R")
  } else {
    files <- list.files(dirpath, pattern = ".R")[
      !grepl(x = list.files(dirpath, pattern = ".R"),
             pattern = paste(exclude, collapse = "|"))
    ]
  } 
  
  if(length(files) != 0){
    for(i in seq_along(files)) {
      cat(paste0("Sourcing: ", files[i], "\n"))
      source(file = paste0(dirpath, "/", files[i]), encoding = "utf-8", local = globalenv())
    } #for
  }
} #source_directory

source_directory(dirpath = "R/utils/")
source_directory(dirpath = "R/functions/")
source_directory(dirpath = "R/modules/")
source_directory(dirpath = "R/templates/")