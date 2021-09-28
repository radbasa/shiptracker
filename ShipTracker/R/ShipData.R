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
            private$data_file_path <- data_file_path
            private$read_data()
        },
        
        #' @description 
        #' Retrieve entire ship data frame
        get_data = function() {
            private$data
        }
    ),
    private = list(
        
        #' @field data_file_path File path of ship data in CSV format
        data_file_path = NULL,
        
        #' @field data Loaded ship data
        data = NULL,
        
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
                                        SHIPNAME = col_factor(),
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
        }
    )
)