setwd("../..")

source("global.R")

sdm <- ShipData$new(global$data_file_path)

test_that("Chart Server outputs a ggplot", {
    selected_ship <- list(
        ship_legs = reactive({sdm$get_ship_legs(316100)}),
        ship_info = reactive({sdm$get_ship_info(316100)})
    )
    
    testServer(chartServer, args = list(selected_ship = selected_ship), {
        expect_type(output$distance_hist, "list")
        expect_equal(output$distance_hist$alt, "Plot object")
    }) 
})
