
# ShipTracker

<!-- badges: start -->
<!-- badges: end -->

I worked on function (classes, logic, shiny) first, leaving form (shiny.semantic) for last. Reviewing my source code and commit history will show that I spent more time on the backend source code and the source code structure. It will also be apparent that this is my first time to use `shiny.semantic`.

The map view does not center on the longest leg. I used all of the ship's observations as the map view bounds. The original plan was to have the histogram interactive, where brushing along its x-axis selects the ship's legs and displays these on the map, in addition to the longest leg. I did not have time to implement this.

## Data Cleaning

I encountered some definite, and some possible, data anomalies during the data sanity check.

* Ships identified by SHIP_ID with two names
* Ships with different SHIP_ID with the same SHIPNAME
* One ship that has a different SHIPTYPE for a certain period of time
* Ships with changes in LENGTH, WIDTH, and DWT
* Ships with heading > 360º

There could be more.

Normally, I would refer to the data source owners for clarification and correction, but due to lack of access to the owners and due to time-constraints, the data set is left as is. For now, the ships are identified by their SHIP_ID. Some of the data anomalies will be seen in the Ship Info table.

### Compress Ship Data Using RDS

ShinyApps.io was timing out loading the >400MB CSV file. Rather than change the ShinyApps.io worker settings, the ships data file is pre-converted into an RDS file for shorter load times. The script to convert is `helpers/compress_data_file.R`. It expects `raw_data/ships.csv`.

### No Pre-processing Done

At the moment, there is no pre-processing performed. The app is fairly responsive without pre-processing.

Candidates for pre-processing optimization:

* Leg numbers - From `ShipData$read_data()`
* Distance calculations - From `ShipData$get_ship_legs()`
* Longest distance - From `MapLeaflet$get_longest_leg()`
* Ship info - From `ShipData$get_ship_info()`

## Application and Development Structure

### Git Branches
I used git branches as much as possible to separate development tasks. I follow a style similar to Gitflow.

### Environment

#### .Renviron
Private information is stored in .Renviron. Because this app uses Mapbox, it needs a Mapbox access token in .Renviron.

```
mapbox_token = ""
```

#### Renv
I used Renv for package control. `renv::restore()` to install packages.

### Shiny ui and server
I kept all Shiny `ui.R` and `server.R` files clean. I effectively used `ui.R` as the "View" and `server.R` as the "Controller" of the MVC (Model-View-Controller) design pattern. It is not an exact application of MVC, but it is workable within a Shiny app. All `ui.R` and `server.R` files only contain Shiny code and function calls to the R6 class models. Although, I was working on this alone, this separation allows simultaneous work to be done on the Shiny application and the business logic.

### R6 Class Models
I put all the business logic inside R6 classes to keep the namespace tidy. By doing so, all relevant data and functions are grouped together in a cohesive unit. The R6 classes effectively serve as the "Model" of MVC.

### Tests
`testthat` test cases are available for the R6 model classes and the server modules. I need to add more assertions for better test coverage. 

### Documentation
I placed as much documentation for the business logic classes as possible. The documentation, definitely, needs more work. The documentation has not yet been tested with roxygen2.

## Known Limitation

The app is deployed on a 2GB (xlarge) ShinyApps instance.

On a 1GB (large) instance size, the app would experience a `shinyapps[system] Out of Memory!` crash with a browser refresh/reload page soon after the first/initial page load. I attempted to investigate the cause by tracking the app's activities and memory usage as detailed in the `debug/memoryleak` branch. I do not yet have a definite answer to this.

A possible solution might be to reduce the memory footprint by pre-processing the data file as described above. For now, to mitigate the issue, the app is deployed on a 2GB instance.
