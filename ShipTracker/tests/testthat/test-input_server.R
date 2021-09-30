setwd("../..")

source("global.R")

test_that("Input Server returns selected ship legs and info", {
    testServer(inputServer, {
        session$setInputs(shiptype_select = 0, ship_select = 316100)
        
        result <- session$getReturned()
        
        expect_type(result, "list")
        expect_named(result, c("ship_legs", "ship_info"))
        
        expect_true(is.reactive(result$ship_legs))
        expect_type(result$ship_legs(), "list")
        expect_s3_class(result$ship_legs(), "data.frame")
        expect_named(result$ship_legs(), c("leg", "LAT", "LON", "DATETIME", "LAT2", "LON2", "DATETIME2", "dist"))
        expect_equal(nrow(result$ship_legs()), 9)
        
        expect_true(is.reactive(result$ship_info))
        expect_type(result$ship_info(), "list")
        expect_s3_class(result$ship_info(), "data.frame")
        expect_named(result$ship_info(), c("SHIP_ID", "SHIPNAME", "FLAG", "LENGTH", "WIDTH", "DWT", "observations", "fromdate", "todate"))
        expect_equal(nrow(result$ship_info()), 1)
    })
})