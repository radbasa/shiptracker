inputUI <- function(id, label = "Inputs") {
    ns <- NS(id)
    
    tagList(
        selectInput(ns("shiptype_select"), "Select Ship Type", choices = c()),
        selectInput(ns("ship_select"), "Select Ship", choices = c())
    )
}