inputUI <- function(id, label = "Inputs") {
    ns <- NS(id)
    
    tagList(
        segment(
            div(class = "ui stackable width grid",
                div(class = "two column row",
                    div(
                        class = "column",
                        p("Ship Type"),
                        dropdown_input(ns("shiptype_select"), c(), default_text = "Select Ship Type"),
                    ),
                    div(
                        class = "column",
                        p("Ship Name"),
                        dropdown_input(ns("ship_select"), c(), default_text = "Select Ship")
                    )
    
                )
            )
        )
    )
}