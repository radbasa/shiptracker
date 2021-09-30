library(readr)
library(dplyr)

raw <- read_csv("raw_data/ships.csv",
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

saveRDS(raw, 'ShipTracker/data/ships.rds')