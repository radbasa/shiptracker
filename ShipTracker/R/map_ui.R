mapOutput <- function(id, label = "Map Output") {
    ns <- NS(id)
    
    tagList(
        segment(
            div(
                leafletOutput(ns("ship_map"), height = "600px")
            )
        )
    )
}