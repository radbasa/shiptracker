shinyServer(function(input, output, session) {
    selected <- inputServer("dropdown_inputs")
    
    mapServer("map_output", selected_ship = selected)
    
    infoServer("info_card", selected_ship = selected)
    
    chartServer("chart_card", selected_ship = selected)
})