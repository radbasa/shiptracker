inputUI <- function(id, label = "Input") {
    ns <- NS(id)
    
    tagList(
        card(
            dropdown_input(ns("shiptype_select"), c("A", "B", "C")),
            dropdown_input(ns("ship_select"), c("E", "F", "G"))
        )
    )
}