library(shiny)
library(shiny.semantic)
library(readr)
library(dplyr)
library(geosphere)
library(DT)

global <- list(
    data_file_path = file.path("data", "ships.csv")
)