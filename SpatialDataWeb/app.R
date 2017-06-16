#Build a Shiny app that allows the user to interactively manipulate the spatial data and display the results in a Leaflet map. Here are some suggestions (but be as creative as you like!):
#For the image data:
#     change the transparency of the image (i.e. the extent to which the underlying map shows through)
#select individual image bands to display in black-and-white, or arbitrary permutations of 3 bands to display in color

library(raster)
library(rgdal)

landsat<- stack("Landsat7.tif")
landsat
plotRGB(landsat, r = 1, g = 2, b = 3, alpha=80,stretch="hist")

library(shiny)

# Define UI for application 
ui <- fluidPage(
     
     titlePanel("Title Panel"),
     
     sidebarLayout(
          sidebarPanel(
     sliderInput(inputId = "num",
                 label = "Transparency",
                 value = 100, min = 1, max = 255),
     sliderInput(inputId = "red",
                 label = "Red",
                 value = 1, min = 1, max = 3),
     sliderInput(inputId = "green",
                 label = "Green",
                 value = 2, min = 1, max = 3),
     sliderInput(inputId = "blue",
                 label = "Blue",
                 value = 3, min = 1, max = 3),
     selectInput('stretch', ' Stretch ', c("hist","lin"))),
     mainPanel(
          h1(" Leaflet Map "),
     plotOutput("plot1"))
     )
 )


# Define server logic 
server <- function(input, output) {
     
     output$plot1 <- renderPlot({landsat <- stack("Landsat7.tif")
     plotRGB(landsat, r = input$red, g = input$green, b = input$blue,alpha=input$num,stretch=input$stretch)
     })
}

# Run the application 
shinyApp(ui = ui, server = server)

