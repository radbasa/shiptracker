mapServer <- function(id, selected_ship) {
    stopifnot(is.reactive(selected_ship$ship_legs))
    
    moduleServer(
        id,
        function(input, output, session) {
            map_leaflet <- MapLeaflet$new("ship_map", global$mapbox)
            
            output$ship_map <- renderLeaflet({
                map_leaflet$make_leaflet()
            })
            
            observeEvent(selected_ship$ship_legs(), {
                map_leaflet$data_render(selected_ship$ship_legs)
            })
        }
    )
    
}