# Librerías necesarias para la construcción de la aplicación
library(shiny)
library(leaflet)

# make a random dummy dataset, of lenght 10, with latitudes and longitudes in Peru. Dataset should include UUID, lat, lng, name, description, and type
data <- data.frame(
  UUID = 1:10,
  lat = runif(10, -18, -0),
  lng = runif(10, -80, -68),
  name = paste0("name", 1:10),
  description = paste0("description", 1:10),
  type = sample(c("type1", "type2", "type3"), 10, replace = TRUE)
)

# Definición de la interfaz gráfica
ui <- fillPage(
  # Agregamos un archivo de estilo a la interfaz
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  # Definimos el mapa y lo colocamos en la página
  leafletOutput("mapa", width = "100%", height = "100%"),
  # Definimos el título y lo colocamos en la parte superior de la página
  absolutePanel(
    id = "title",
    top = 10,
    left = "5%",
    right = "5%",
    border = "none",
    h1("Museo de la Infamia")
  )
)

# Definición del servidor
server <- function(input, output, session) {
  # Definimos el mapa
  output$mapa <- renderLeaflet({
    # Creamos el mapa y añadimos la capa de tiles
    leaflet() |>
      addTiles() |>
      # Centramos el mapa en Lima
      setView(lng = -77.0428, lat = -12.0464, zoom = 6) |>
      # Añadimos un marcador en Lima
      addMarkers(lng = -77.0428, lat = -12.0464, popup = "Lima") |>
      # Add a marker for each row in the dataset
      addMarkers(
        lng = ~lng,
        lat = ~lat,
        popup = ~paste0("<b>", name, "</b><br>", description),
        data = data,
        clusterOptions = markerClusterOptions(
          showCoverageOnHover = FALSE,
          spiderfyOnMaxZoom = FALSE,
          zoomToBoundsOnClick = TRUE
        )
      )
  })
}

# Ejecutamos la aplicación
shinyApp(ui, server)
