library(shiny)
library(leaflet)

mylng = 60.188
mylat = 24.999

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%} .leaflet-container {cursor: pointer !important;}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(bottom = 40, right = 20,
                HTML("<div><b>Click anywhere</b><br/><a target='blank' href='https://www.hs.fi/tiede/art-2000009337638.html?fbclid=IwAR1AlfLLDmGWmFteOWp6-reI5cu36_SE87P-Zf5Jbi0-JuFsuXMsI_aPom0'>About</a></div>")
  )
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    leaflet() %>%
      setView(mylat, mylng, zoom = 10) %>% 
      addTiles()
  })
  
  observe({
    click = input$map_click
    if(is.null(click))
      return()
    map_proxy = leafletProxy("map") %>%
      clearShapes %>% 
      clearMarkers %>% 
      addCircleMarkers(lng = click$lng, lat = click$lat, weight = 0.8) %>% 
      addCircles(lng = click$lng, lat = click$lat, radius = 24000, weight = 0.8) %>% 
      setView(click$lng, click$lat, zoom = 10)
  })
  
}

shinyApp(ui, server)
