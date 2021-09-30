setwd("../..")

source("global.R")

sdm <- ShipData$new(global$data_file_path)

test_that("Info Server outputs info", {
    testthat::local_edition(3)
    selected_ship <- list(
        ship_legs = reactive({sdm$get_ship_legs(316100)}),
        ship_info = reactive({sdm$get_ship_info(316100)})
    )
    
    testServer(infoServer, args = list(selected_ship = selected_ship), {
        expect_s3_class(output$ship_info_table, "json")
        expect_snapshot(output$ship_info_table)
        
    })
})