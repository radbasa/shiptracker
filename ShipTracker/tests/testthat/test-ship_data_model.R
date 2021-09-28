library(readr)

context("Ship Data Model")

setwd("../..")
source("R/ShipData.R")

file_path <- "data/ships.csv"

row_test <- function(ship_data, file_path) {
    raw_data <- read.csv(file_path)
    
    expect_equal(nrow(ship_data$get_data()), nrow(raw_data))
}

test_that("Ship Data Mode", {
    ship_data <- ShipData$new(file_path)
    
    row_test(ship_data, file_path)
})