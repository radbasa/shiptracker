library(shiny)
# library(shiny.semantic)
library(readr)
library(dplyr)
library(geosphere)
library(leaflet)
library(ggplot2)
library(DT)
library(pryr)
library(futile.logger)

flog.threshold(DEBUG, name = "shipdata")
flog.threshold(DEBUG, name = "mapleaflet")
flog.threshold(DEBUG, name = "inputserver")
flog.threshold(DEBUG, name = "mapserver")

global <- list(
    data_file_path = file.path("data", "ships.rds"),
    mapbox = list(
        url = '//api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}/?access_token={accessToken}',
        style = 'mapbox/light-v10',
        token = Sys.getenv('mapbox_token')
    )
)