chartUI <- function(id, label = "Chart UI") {
    ns <- NS(id)
    
    tagList(
        div(
            plotOutput(ns("distance_hist"))
        )
    )
}