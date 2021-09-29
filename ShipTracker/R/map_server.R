mapServer <- function(id, selected_ship) {
    stopifnot(is.reactive(selected_ship$ship_legs))
    
    moduleServer(
        id,
        function(input, output, session) {
            output$table <- DT::renderDataTable(
                req(selected_ship$ship_legs())
            )
        }
    )
    
}