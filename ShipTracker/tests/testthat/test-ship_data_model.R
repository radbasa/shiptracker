library(readr)
library(dplyr)

context("Ship Data Model")

setwd("../..")
source("R/ShipData.R")

file_path <- "data/ships.csv"



row_test <- function(ship_data, file_path) {
    context("Ship Data Model - read test")
    raw_data <- read.csv(file_path)
    
    expect_equal(nrow(ship_data$get_data()), nrow(raw_data))
}

ship_type_test <- function(ship_data) {
    context("Ship Data Model - ship types test")
    
    expected <- c("Unspecified", "Navigation", "Fishing", "Tug", "High Special", "Passenger", "Cargo", "Tanker", "Pleasure")
    ship_types <- ship_data$get_ship_types()
    
    expect_type(ship_types, "integer")
    expect_named(ship_types, expected)
}

test_that("Ship Data Model", {
    ship_data <- ShipData$new(file_path)
    
    row_test(ship_data, file_path)
    ship_type_test(ship_data)
})