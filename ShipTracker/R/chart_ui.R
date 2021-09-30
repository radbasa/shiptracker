chartUI <- function(id, label = "Chart UI") {
    ns <- NS(id)
    
    tagList(
        # card(
            h1("Distance Traveled Distribution"),
            plotOutput(ns("distance_hist"))
        # )
    )
}