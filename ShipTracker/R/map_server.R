mapServer <- function(id, selected_ship) {
    stopifnot(is.reactive(selected_ship$ship_legs))
    
    moduleServer(
        id,
        function(input, output, session) {
            flog.debug("mapserver start", name = "mapserver")
            map_leaflet <- MapLeaflet$new("ship_map", global$mapbox)
            flog.debug(mem_used(), name = "mapserver")
            
            output$ship_map <- renderLeaflet({
                map_leaflet$make_leaflet()
            })
            
            observeEvent(selected_ship$ship_legs(), {
                map_leaflet$data_render(selected_ship$ship_legs())
            })
        }
    )
    
}