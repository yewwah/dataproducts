
library(shiny)

shinyUI(fluidPage(
  
  # This is just a demo product
  titlePanel("Motor Trend Cars - Gas Mileage per Gallon"),
  
  # Sidebar with a helpful prompt, a slider to set cylinder
  # count, a slider to set weight, hosrsepower as well as Transmission Type and an output for the
  # predicted value (which will also be in the plot to the
  # right)
  sidebarLayout(
    sidebarPanel(
      p(
        "There are a few attributes",
        "Cylinder",
        "Weight",
        "Horsepower",
        "Transmission Type"
      ),
      br(),
      p(
        "Slide it around to change the values",
        "and the prediction will be displayed in the plot to the",
        "right. The predicted value will be at the top of the plot"
      ),
      br(),
      
      sliderInput("cyl",
                  "Number of cyclinders:",
                  min = 4,
                  max = 10,
                  value = 8),
      
      sliderInput("wt",
                  "Weight (tons):",
                  min = 1,
                  max = 15,
                  value = 4),
      
      sliderInput("hp",
                  "Horsepower:",
                  min = 50,
                  max = 250,
                  value = 10),
      
      selectInput("am",
                  "Transmission:",
                  choices = c("Automatic" = 0,"Manual" = 1)),
      
      br(), br()
      
    ),
    
    # Show a plot of the cars and the prediction
    mainPanel(
      
      plotOutput("mpgPlot"),
      p("The Triangle box will be the predicted value", align = "center"),
      verbatimTextOutput("predictedMpg")
    )
  )
))