
# The weight of the carthe n, umber of cyclinders, transmission mode and horsepower in the
# cars engine are used to predict gas mileage.
#

library(shiny)
library(ggplot2)
shinyServer(function(input, output) {

  #put the more computationally intensive model here
  
  
  predict_mpg <- reactive({
    # create the model. in the future additional inputs could
    # go here
    #model <- lm(mpg~  cyl+ wt + am + hp , data = mtcars)
    model <- lm(mpg ~ cyl + wt + hp + am, data=mtcars)
    #model <-  
    #get a prediction
    x <- predict(model, newdata = data.frame(cyl=input$cyl, wt=input$wt, hp = input$hp, am = as.numeric(input$am)))
    
    # return prediction to the caller
    return(x[1])    
  })
  
  # format and return the text of our prediction
  output$predictedMpg <- renderText(sprintf('Expected MPG: %.1f MPG',predict_mpg()))
  
  #output$predictedMpg <- renderText(sprintf('haha'))
  output$mpgPlot <- renderPlot({
    
    #copy of mtcars
    z <- mtcars
    
    # new column, initialized to show where the car data came from
    z$source_input = 'Initial'
    
    #just use the mean variables for the others
    # create the new car
    new_car <- data.frame(
      mpg = predict_mpg(),
      cyl = input$cyl,
      disp = mean(z$disp),
      hp = input$hp,
      drat = mean(z$drat),
      wt = input$wt,
      qsec = mean(z$qsec),
      vs = mean(z$vs),
      am = as.numeric(input$am),
      gear = mean(z$gear),
      carb = mean(z$carb),
      source_input = 'Prediction'
    )
    
    # append the new car
    z <- rbind(z, new_car)
    rownames(z)[nrow(z)] <- "new car"
    #z$cyl <- as.factor(z$cyl)
    
    # do the plot
    p <- ggplot(data = z, aes(x= wt +am + cyl + hp, y=mpg, shape=source_input)) +
      geom_smooth(method = 'lm')+
     
      geom_point(size=5, alpha=1, color = 'blue') +
      xlab('Weight + Transmission Type + Cylinder Count + HorsePower') +
      ylab('Miles Per Gallon') +
      ggtitle('Predicting Miles Per Gallon\nfrom Cylinder Count and Weight and Transmission Type and Horsepower\n') 
 
    # 'return' the plot to shiny
    print(p)
  })
  
})