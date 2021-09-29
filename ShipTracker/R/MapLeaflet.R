MapLeaflet <- R6::R6Class(
    'MapLeaflet',
    public = list(
        
        #' @description 
        #' Initialize Leaflet object
        #' 
        #' @param name Leaflet Shiny identifier
        #' @param mapbox_creds List of mapbox parameters (url, style, token)
        initialize = function(name, mapbox_creds) {
            stopifnot(is.character(name))
            stopifnot(is.list(mapbox_creds))
            
            private$name <- name
            private$mapbox_creds <- mapbox_creds
            invisible(self)
        },
        
        #' @description 
        #' Create Leaflet instance
        make_leaflet = function() {
            leaflet() %>%
                addTiles(urlTemplate = private$mapbox_creds$url, group = 'MapBox', options = tileOptions(
                    id = private$mapbox_creds$style,
                    zoomOffset = 0,
                    tileSize = 512,
                    maxZoom = 18,
                    accessToken = private$mapbox_creds$token
                ))
        }
    ),
    private = list(
        
        #' @field name Leaflet Shiny identifier
        name = NULL,
        
        #' @field mapbox_creds Mapbox parameters (url, style, token)
        mapbox_creds = NULL
    )
)