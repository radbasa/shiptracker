#' R6 Class Data Model for Ship Data
#' 
#' @description
#' 
ShipData <- R6::R6Class(
    'ShipData',
    public = list(
        
        #' @description
        #' Create a ship data model object
        #' @param data_file_path Ship data CSV file path
        initialize = function(data_file_path) {
            stopifnot(file.exists(data_file_path))
            private$data_file_path <- data_file_path
            private$read_data()
            private$parse_ships()
            private$parse_ship_types()
        },
        
        #' @description 
        #' Retrieve entire ship data frame
        #' 
        #' @return 
        #' Data frame
        get_data = function() {
            private$data
        },
        
        #' @description
        #' Retrieve available ship types
        #' 
        #' @return 
        #' Named vector of ship types sorted by numerical ship type value
        get_ship_types = function() {
            setNames(private$ship_types$SHIPTYPE, private$ship_types$ship_type)
        },
        
        #' @description 
        #' Retrieve ships of ship type
        #' 
        #' @param 
        #' ship_type A number representing ship type ID
        #' @return 
        #' Named vector of ships filtered by ship type
        get_ships_of_type = function(ship_type_id) {
            stopifnot(!is.na(ship_type_id), !is.null(ship_type_id), ship_type_id != "")
            # browser()
            ships <- private$ships %>%
                filter(
                    SHIPTYPE == ship_type_id
                ) %>%
                select(SHIP_ID, SHIPNAME) %>%
                arrange(SHIPNAME)
            setNames(ships$SHIP_ID, ships$SHIPNAME)
        },
        
        #' @description
        #' 
        #' @param
        #' ship_id A number representing the ship ID
        #' @return
        #' Data frame of the ship's legs from point to point with distance in meters sorted by distance descending
        get_ship_legs = function(ship_id) {
            ship_legs <- private$data %>%
                filter(
                    SHIP_ID == ship_id
                ) %>%
                select(LAT, LON, DATETIME) %>%
                arrange(DATETIME) %>%
                mutate(
                    LAT2 = lead(LAT),
                    LON2 = lead(LON),
                    DATETIME2 = lead(DATETIME),
                    leg = row_number()
                ) %>%
                filter(
                    complete.cases(.)
                )
            
            distance <- function(leg, output) {
                return(distm(as.numeric(c(leg[2], leg[1])),
                             as.numeric(c(leg[5], leg[4])),
                             fun = distHaversine))
            }
            ship_legs$dist <- apply(ship_legs, 1, distance)
            
            ship_legs %>%
                arrange(
                    desc(dist), desc(DATETIME2)
                )
        }
    ),
    private = list(
        
        #' @field data_file_path File path of ship data in CSV format
        data_file_path = NULL,
        
        #' @field data Loaded ship data
        data = NULL,
        
        #' @field data frame of ships
        ships = NULL,
        
        #' @field data frame of ship types
        ship_types = NULL,
        
        #' @description
        #' Read ship data CSV file
        read_data = function() {
            private$data <- read_csv(private$data_file_path,
                                     col_types = cols(
                                        LAT = col_double(),
                                        LON = col_double(),
                                        SPEED = col_integer(),
                                        COURSE = col_integer(),
                                        HEADING = col_integer(),
                                        DESTINATION = col_factor(),
                                        FLAG = col_factor(),
                                        LENGTH = col_integer(),
                                        SHIPNAME = col_character(),
                                        SHIPTYPE = col_integer(),
                                        SHIP_ID = col_character(),
                                        WIDTH = col_integer(),
                                        DWT = col_integer(),
                                        DATETIME = col_datetime(format = ""),
                                        PORT = col_factor(),
                                        date = col_date(format = ""),
                                        week_nb = col_integer(),
                                        ship_type = col_factor(),
                                        port = col_factor(),
                                        is_parked = col_integer()
                                    ))
        },
        
        #' @description 
        #' Extract unique ships
        parse_ships = function() {
            private$ships <- private$data %>%
                select(SHIP_ID, SHIPNAME, SHIPTYPE, ship_type) %>%
                distinct()
        },
        
        #' @description 
        #' Extract ship types
        parse_ship_types = function() {
            private$ship_types <- private$ships %>%
                select(SHIPTYPE, ship_type) %>%
                distinct() %>%
                arrange(SHIPTYPE)
        }
    )
)