#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(shinyhelper)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  observe_helpers(help_dir = "helpfiles")
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "AirPassenger" = AirPassengers,
           "pressure" = pressure,
           "cars" = cars,
           "airquality" = airquality)
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
  output$doc <- renderText({ 
    "Documentation: click help icons to see some documentation.\n"
  })
  
})