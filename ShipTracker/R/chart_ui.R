chartUI <- function(id, label = "Chart UI") {
    ns <- NS(id)
    
    tagList(
        div(
            class = "ui grid",
            h1("Distance Traveled Distribution"),
            plotOutput(ns("distance_hist"))
        )
    )
}