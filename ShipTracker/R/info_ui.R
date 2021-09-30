infoUI <- function(id, label = "Info UI") {
    ns <- NS(id)
    
    tagList(
        div(
            dataTableOutput(ns("ship_info_table"))
        )
    )
}