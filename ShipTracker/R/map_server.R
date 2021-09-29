mapServer <- function(id, selected_ship) {
    stopifnot(is.reactive(selected_ship$ship_legs))
    
    moduleServer(
        id,
        function(input, output, session) {
            map_leaflet <- MapLeaflet$new("shipMap", global$mapbox)
            
            output$ship_map <- renderLeaflet({
                map_leaflet$make_leaflet()
            })
        }
    )
    
}