infoServer <- function(id, selected_ship) {
    stopifnot(is.reactive(selected_ship$ship_info))
    
    moduleServer(
        id,
        function(input, output, session) {
            output$ship_info_table <- renderDataTable({
                req(selected_ship$ship_info())
                
                selected_ship$ship_info()
            })
        }
    )
    
}