# grid_charts <- grid_template(
#     default = list(areas = rbind(c("chart1", "chart2")),
#                    rows_height = c("100%"),
#                    cols_width = c("50%", "50%"))
# )
# 
# semanticPage(
#     title = "My first page",
#     h1("My page"),
#     segment(
#         class = "basic",
#         cards(
#             class = "two",
#             inputUI("dropdown_inputs"),
#             mapOutput("map_output")
#         )
#     ),
#     segment(
#         class = "basic",
#         cards(
#             class = "two",
#             infoUI("info_card"),
#             chartUI("chart_card")
#         )
#     )
# )

ui <- fluidPage(
    inputUI("dropdown_inputs"),
    mapOutput("map_output"),
    infoUI("info_card"),
    chartUI("chart_card")
)