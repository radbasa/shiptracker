inputServer <- function(id) {
    moduleServer(
        id,
        function(input, output, session) {
            ship_data <- ShipData$new(global$data_file_path)
            
            observe({
                ship_types <- ship_data$get_ship_types()
                update_dropdown_input(session, "shiptype_select", choices = names(ship_types), choices_value = ship_types, value = NULL)
            })
            
            observeEvent(input$shiptype_select, {
                ship_list <- ship_data$get_ships_of_type(input$shiptype_select)
                update_dropdown_input(session, "ship_select", choices = names(ship_list), choices_value = ship_list, value = NULL)
            }, ignoreNULL = TRUE, ignoreInit = TRUE)
            
            session$onSessionEnded(function() {
                stopApp()
            })
        }
    )
}