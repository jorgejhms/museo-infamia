library(shiny)
library(leaflet)

ui <- fillPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  # UI code here
  leafletOutput("mapa", width = "100%", height = "100%"),
  absolutePanel(
    id = "title",
    top = 10,
    left = "5%",
    right = "5%",
    border = "none",
    h1("Museo de la Infamia")
  )
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
