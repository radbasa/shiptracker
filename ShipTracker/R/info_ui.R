infoUI <- function(id, label = "Info UI") {
    ns <- NS(id)
    
    tagList(
        card(
            h1("Ship Info"),
            dataTableOutput(ns("ship_info_table"))
        )
    )
}