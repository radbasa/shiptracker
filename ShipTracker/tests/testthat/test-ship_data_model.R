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

ships_of_type_test <- function(ship_data) {
    context("Ship Data Model - ships of type test")
    
    expect_error(ship_data$get_ships_of_type())
    expect_error(ship_data$get_ships_of_type(NA))
    expect_error(ship_data$get_ships_of_type(NULL))
    expect_error(ship_data$get_ships_of_type(""))
    
    
    expect_length(ship_data$get_ships_of_type(1), 7)
    expect_length(ship_data$get_ships_of_type("4"), 3)
}

test_that("Ship Data Model", {
    expect_error(ShipData$new('xxxxxxx.csv'))       
    
    ship_data <- ShipData$new(file_path)
    
    row_test(ship_data, file_path)
    ship_type_test(ship_data)
    ships_of_type_test(ship_data)
})