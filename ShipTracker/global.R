library(shiny)
library(shiny.semantic)
library(readr)
library(dplyr)
library(geosphere)
library(leaflet)
library(ggplot2)
library(waiter)
# library(DT)

global <- list(
    data_file_path = file.path("data", "ships.rds"),
    mapbox = list(
        url = '//api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}/?access_token={accessToken}',
        style = 'mapbox/light-v10',
        token = Sys.getenv('mapbox_token')
    )
)