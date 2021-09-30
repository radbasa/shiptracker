setwd("../..")

source("global.R")

sdm <- ShipData$new(global$data_file_path)

test_that("Map Server outputs a leaflet map", {
    testthat::local_edition(3)
    selected_ship <- list(
        ship_legs = reactive({sdm$get_ship_legs(316100)}),
        ship_info = reactive({sdm$get_ship_info(316100)})
    )
    
    testServer(mapServer, args = list(selected_ship = selected_ship), {
        expect_s3_class(output$ship_map, "json")
        
        # This saves the Mapbox access token in the snapshot. Gitignore this.
        expect_snapshot(output$ship_map)
    })
})