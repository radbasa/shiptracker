shinyServer(function(input, output, session) {
    selected <- inputServer("dropdown_inputs")
    
    mapServer("map_output", selected_ship = selected)
})