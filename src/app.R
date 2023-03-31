library(shiny)
library(leaflet)

ui <- fillPage(
  # UI code here
  leafletOutput("mapa", width = "100%", height = "100%")
)

server <- function(input, output, session) {
  # Server code here
  output$mapa <- renderLeaflet({
    # Create the map and add a base map layer and a marker for Lima
    leaflet() |>
      addTiles() |>
      setView(lng = -77.0428, lat = -12.0464, zoom = 6) |>
      addMarkers(lng = -77.0428, lat = -12.0464, popup = "Lima")
  })
}

shinyApp(ui, server)
