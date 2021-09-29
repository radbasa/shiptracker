mapOutput <- function(id, label = "Map Output") {
    ns <- NS(id)
    
    tagList(
        card(
            leafletOutput(ns("ship_map"))
        )
    )
}