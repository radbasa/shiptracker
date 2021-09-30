semanticPage(
    vertical_layout(
        adjusted_to_page = FALSE,
        header(title = "Longest Distance Travelled by Ships", description = "Data from ship AIS"),
        inputUI("dropdown_inputs"),
        mapOutput("map_output"),
        segment(
            tabset(
                tabs = list(
                    list(menu = "Ship Info", content = infoUI("info_card")),
                    list(menu = "Distance Travelled Histogram", content = chartUI("chart_card"))
                )
            )
        )
    )
)