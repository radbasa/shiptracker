inputUI <- function(id, label = "Inputs") {
    ns <- NS(id)
    
    tagList(
        card(
            dropdown_input(ns("shiptype_select"), c(), default_text = "Select Ship Type"),
            dropdown_input(ns("ship_select"), c(), default_text = "Select Ship")
        )
    )
}