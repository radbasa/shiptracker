grid_charts <- grid_template(
    default = list(areas = rbind(c("chart1", "chart2")),
                   rows_height = c("100%"),
                   cols_width = c("50%", "50%"))
)

layout_template = grid_template(
    default = list(
        areas = rbind(
            c("userinput", "map"),
            c("shipinfo", "map")
        ),
        cols_width = c("400px", "600px"),
        rows_height = c("100px", "auto")
    ),
    mobile = list(
        areas = rbind(
            "userinput",
            "map",
            "shipinfo"
        ),
        cols_width = c("100%"),
        rows_height = c("200px", "auto", "400px")
    )
)

semanticPage(
    grid(
        layout_template,
        userinput = inputUI("dropdown_inputs"),
        map = mapOutput("map_output"),
        shipinfo = div(
                tabset(
                    tabs = list(
                        list(menu = "Ship Info", content = infoUI("info_card")),
                        list(menu = "Distance Histogram", content = chartUI("chart_card"))
                    )
                )
            )
    )
)