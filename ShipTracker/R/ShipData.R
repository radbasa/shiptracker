#' R6 Class Data Model for Ship Data
#' 
#' @description
#' Container for ship data
#' 
#' @details
#' Performs business logic on ship data such as filtering

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
        #' @param ship_type A number representing ship type ID
        #' @return Named vector of ships filtered by ship type
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
        #' Retrieve all of a ship's legs from point 1 (long, lat) to point 2 (long, lat) with timestamps
        #' 
        #' @param ship_id A number representing the ship ID
        #' @return Data frame of the ship's legs from point to point with distance in meters sorted by distance descending
        get_ship_legs = function(ship_id) {
            ship_legs <- private$data %>%
                filter(
                    SHIP_ID == ship_id
                ) %>%
                select(leg, LAT, LON, DATETIME) %>%
                arrange(leg) %>%
                mutate(
                    LAT2 = lead(LAT),
                    LON2 = lead(LON),
                    DATETIME2 = lead(DATETIME),
                ) %>%
                filter(
                    complete.cases(.)
                )
            
            distance <- function(leg, output) {
                return(distm(as.numeric(c(leg[3], leg[2])),
                             as.numeric(c(leg[6], leg[5])),
                             fun = distHaversine))
            }
            ship_legs$dist <- apply(ship_legs, 1, distance)

            ship_legs %>%
                arrange(
                    desc(dist), desc(DATETIME2)
                )
        },
        
        #' @description 
        #' Retrieve a ship's physical information (name, flag, length, width, deadweight)
        #' 
        #' @param ship_id A number representing the ship ID
        #' @return A data frame of the ship's information containing the physical information and the timeframe they were recorded.
        get_ship_info = function(ship_id) {
            private$data %>%
                filter(
                    SHIP_ID == ship_id
                ) %>%
                select(SHIP_ID, SHIPNAME, FLAG, LENGTH, WIDTH, DWT, date) %>%
                group_by(SHIP_ID, SHIPNAME, FLAG, LENGTH, WIDTH, DWT) %>%
                summarise(
                    observations = n(),
                    fromdate = min(date),
                    todate = max(date)
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
            raw_data <- readRDS(private$data_file_path)

            private$data <- raw_data %>%
                group_by(SHIP_ID) %>%
                arrange(DATETIME) %>%
                mutate(leg = row_number()) %>%
                ungroup()
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