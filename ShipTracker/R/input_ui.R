inputUI <- function(id, label = "Inputs") {
    ns <- NS(id)
    
    tagList(
        div(
            class = "ui grid",
            p("Ship Type"),
            dropdown_input(ns("shiptype_select"), c(), default_text = "Select Ship Type"),
            p("Ship Name"),
            dropdown_input(ns("ship_select"), c(), default_text = "Select Ship")
        )
    )
}