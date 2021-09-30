mapOutput <- function(id, label = "Map Output") {
    ns <- NS(id)
    
    tagList(
        div(
            class = "ui grid",
            # tags$style(type = "text/css",
            #            "#map_output-ship_map {height: calc(100vh - 80px};"),
            leafletOutput(ns("ship_map"))
        )
    )
}