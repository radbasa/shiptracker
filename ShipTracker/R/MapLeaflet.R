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
                    maxZoom = 18,
                    accessToken = private$mapbox_creds$token
                )) %>%
                setView(lng = 23.3833318, lat = 48.499998, zoom = 10)
        },
        
        data_render = function(leg_data) {
            req(leg_data())
            legs <- leg_data()
            if (nrow(legs) == 0)
                return()
            
            data_bounds <- private$get_data_bounds(legs)

            longest_leg <- private$get_longest_leg(legs)
            
            point_labels <- private$create_point_labels(longest_leg)
            
            leafletProxy(private$name, data = longest_leg$points) %>%
                clearMarkers() %>%
                clearShapes() %>%
                addPolylines(
                    lng = ~lng,
                    lat = ~lat,
                    label = c(sprintf("%0.2f meters", longest_leg$distance)),
                    labelOptions = labelOptions(noHide = TRUE)
                ) %>%
                addCircleMarkers(
                    lng = ~lng,
                    lat = ~lat,
                    radius = 5,
                    label = point_labels
                ) %>%
                flyToBounds(
                    lng1 = data_bounds$lng1,
                    lat1 = data_bounds$lat1,
                    lng2 = data_bounds$lng2,
                    lat2 = data_bounds$lat2,
                )
        }
    ),
    private = list(
        
        #' @field name Leaflet Shiny identifier
        name = NULL,
        
        #' @field mapbox_creds Mapbox parameters (url, style, token)
        mapbox_creds = NULL,
        
        #' @description 
        #' Determines the minimum and maximum bounds of a ship's observations.
        #' 
        #' @param legs Data frame of ship's leg observations
        #' 
        #' @return List of lng, lat boundaries
        get_data_bounds = function(legs) {
            return(
                list(
                    lat1 = min(legs$LAT, legs$LAT2),
                    lng1 = min(legs$LON, legs$LON2),
                    lng2 = max(legs$LON, legs$LON2),
                    lat2 = max(legs$LAT, legs$LAT2)
                )
            )
        },
        
        #' @description 
        #' Gets the ship's longest leg.
        #' 
        #' @param legs Data frame of ship's leg observations
        #' 
        #' @return List of points in data frame format and distance in meters
        get_longest_leg = function(legs) {
            longest_leg <- legs %>% first()
            points <- data.frame(
                lng = c(longest_leg$LON, longest_leg$LON2),
                lat = c(longest_leg$LAT, longest_leg$LAT2),
                timestamp = c(longest_leg$DATETIME, longest_leg$DATETIME2)
            )
            
            distance <- longest_leg$dist
            
            return(
                list(
                    points = points,
                    distance = distance
                )
            )
        },
        
        #' @description 
        #' Create labels for longest leg points
        #' 
        #' @param longest_leg
        #' 
        #' @return List of labels
        create_point_labels = function(longest_leg) {
            sprintf(
                "<table class='table table-condensed'>
                    <tr>
                        <td>Date Time</td><td>%s</td>
                    </tr>
                    <tr>
                        <td>Long</td><td>%s</td>
                    </tr>
                    <tr>
                        <td>Lat</td><td>%s</td>
                    </tr>
                </table>",
                longest_leg$points$timestamp,
                longest_leg$points$lng,
                longest_leg$points$lat) %>%
                lapply(htmltools::HTML)
        }
    )
)