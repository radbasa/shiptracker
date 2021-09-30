grid_charts <- grid_template(
    default = list(areas = rbind(c("chart1", "chart2")),
                   rows_height = c("100%"),
                   cols_width = c("50%", "50%"))
)

layout_template = grid_template(
    default = list(
        areas = rbind(
            c("userinput"),
            c("map"),
            c("shipinfo")
        ),
        cols_width = c("auto"),
        rows_height = c("120px", "auto", "auto")
    ),
    mobile = list(
        areas = rbind(
            "userinput",
            "map",
            "shipinfo"
        ),
        cols_width = c("100%"),
        rows_height = c("120px", "auto", "400px")
    )
)

semanticPage(
    grid(
        layout_template,
        userinput = inputUI("dropdown_inputs"),
        map = mapOutput("map_output"),
        shipinfo = segment(
                tabset(
                    tabs = list(
                        list(menu = "Ship Info", content = infoUI("info_card")),
                        list(menu = "Distance Travelled Histogram", content = chartUI("chart_card"))
                    )
                )
            )
    )
)