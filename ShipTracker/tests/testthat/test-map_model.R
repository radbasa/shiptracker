library(leaflet)
library(dplyr)

context("Leaflet Map Model")

setwd("../..")
source("R/ShipData.R")
source("R/MapLeaflet.R")

file_path <- "data/ships.rds"


TestMapLeaflet <- R6::R6Class(
    inherit = MapLeaflet,
    public = list(
        get_data_bounds = function(legs) {
            private$get_data_bounds(legs)
        },

        get_longest_leg = function(legs) {
            private$get_longest_leg(legs)
        },

        create_point_labels = function(longest_leg) {
            private$create_point_labels(longest_leg)
        }
    )
)

test_that("Leaflet Map Model", {
    ship_data <- ShipData$new(file_path)
    sl <- ship_data$get_ship_legs(316100)

    map_leaflet <- TestMapLeaflet$new("testmap", list(url = "", style = "", token = ""))

    expect_s3_class(map_leaflet, "R6")

    expect_s3_class(map_leaflet$make_leaflet(), "leaflet")

    expect_type(map_leaflet$get_data_bounds(sl), "list")

    longest_leg <- map_leaflet$get_longest_leg(sl)
    expect_type(longest_leg, "list")
    expect_length(longest_leg, 2)
    expect_named(longest_leg, c("points", "distance"))

    expect_type(longest_leg$points, "list")
    expect_s3_class(longest_leg$points, "data.frame")
    expect_length(longest_leg$points, 3)
    expect_equal(nrow(longest_leg$points), 2)

    expect_type(longest_leg$distance, "double")
    expect_length(longest_leg$distance, 1)

    expect_type(map_leaflet$create_point_labels(longest_leg), "list")
})