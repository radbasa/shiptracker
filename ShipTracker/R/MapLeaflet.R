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
                    zoomOffset = -1,
                    tileSize = 512,
                    minZoom = 2,
                    maxZoom = 14,
                    accessToken = private$mapbox_creds$token
                )) %>%
                setView(lng = 23.3833318, lat = 48.499998, zoom = 10)
        },
        
        data_render = function(leg_data) {
            req(leg_data())
            legs <- leg_data()
            if (nrow(legs) == 0)
                return()

            lat1 = min(legs$LAT, legs$LAT2)
            lng1 = min(legs$LON, legs$LON2)
            lng2 = max(legs$LON, legs$LON2)
            lat2 = max(legs$LAT, legs$LAT2)
            
            longest_leg <- legs %>% first()
            longest <- data.frame(
                lng = c(longest_leg$LON, longest_leg$LON2),
                lat = c(longest_leg$LAT, longest_leg$LAT2)
            )
            
            distance <- longest_leg$dist
            
            leafletProxy(private$name, data = longest) %>%
                clearMarkers() %>%
                clearShapes() %>%
                addPolylines(
                    lng = ~lng,
                    lat = ~lat,
                    label = c(sprintf("%0.2fm", distance)),
                    labelOptions = labelOptions(noHide = TRUE)
                ) %>%
                flyToBounds(
                    lng1 = lng1,
                    lat1 = lat1,
                    lng2 = lng2,
                    lat2 = lat2,
                )
        }
    ),
    private = list(
        
        #' @field name Leaflet Shiny identifier
        name = NULL,
        
        #' @field mapbox_creds Mapbox parameters (url, style, token)
        mapbox_creds = NULL
    )
)