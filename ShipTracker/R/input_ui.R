inputUI <- function(id, label = "Input") {
    ns <- NS(id)
    
    tagList(
        card(
            dropdown_input("shiptype_select", c("A", "B", "C")),
            dropdown_input("shipid_select", c("E", "F", "G"))
        )
    )
}