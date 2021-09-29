chartServer <- function(id, selected_ship) {
    stopifnot(is.reactive(selected_ship$ship_legs))
    
    moduleServer(
        id,
        function(input, output, session) {
            output$distance_hist <- renderPlot({
                req(selected_ship$ship_legs)
                
                ggplot(selected_ship$ship_legs(), aes(dist)) +
                    geom_histogram() +
                    scale_x_continuous(name = "Distance (meters)") +
                    scale_y_continuous(name = "Observations") +
                    theme_minimal()
            })
        }
    )
}