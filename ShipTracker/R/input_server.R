inputServer <- function(id) {
    moduleServer(
        id,
        function(input, output, session) {
            flog.debug("inputserver start", name = "inputserver")
            ship_data <- ShipData$new(global$data_file_path)
            flog.debug(mem_used(), name = "inputserver")
            
            observe({
                ship_types <- ship_data$get_ship_types()
                # update_dropdown_input(session, "shiptype_select", choices = names(ship_types), choices_value = ship_types, value = NULL)
                
                updateSelectInput(session, "shiptype_select", choices = ship_types)
            })
            
            observeEvent(input$shiptype_select, {
                ship_list <- ship_data$get_ships_of_type(input$shiptype_select)
                # update_dropdown_input(session, "ship_select", choices = names(ship_list), choices_value = ship_list, value = NULL)
                
                updateSelectInput(session, "ship_select", choices = ship_list)
            }, ignoreNULL = TRUE, ignoreInit = TRUE)
            
            return(
                list(
                    ship_legs = reactive({
                        ship_data$get_ship_legs(input$ship_select)
                    }),
                    ship_info = reactive({
                        ship_data$get_ship_info(input$ship_select)
                    })
                )
            )
        }
    )
}