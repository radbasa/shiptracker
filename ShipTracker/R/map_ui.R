mapOutput <- function(id, label = "Map Output") {
    ns <- NS(id)
    
    tagList(
        card(
            DT::dataTableOutput(ns("table"))
        )
    )
}