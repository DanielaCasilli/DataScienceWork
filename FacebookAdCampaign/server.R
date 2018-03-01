#########################################################################
#
# --- Facebook Campaign server.R
#
#########################################################################

# --- Set up
rm(list = ls())
setwd("/srv/shiny-server/facebookCmampaign")
# source files
source("./global.R") 
# libraries
library(shiny)
library(rvest)



# --- Initialisation

# Define server logic required to draw a histogram
shinyServer(function(input, output){
 value <- reactiveValues()

  # --- Plot
  output$plot1 <- renderPlotly({plot1})
  
  output$plot2 <- renderPlotly({plot2})
  
  output$plot3 <- renderPlotly({plot3})
  
  output$plot4 <- renderPlotly({plot4})
  
  output$plot5 <- renderPlotly({plot5})
  
  output$plot6 <- renderPlotly({plot6})

  
  
})
