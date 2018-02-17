rm(list = ls())
#setwd("/srv/shiny-server/facebookAd")
setwd("/Users/danielacasilli/Docs/DataScience/DataScienceWork/FacebookAdCampaign")
source("global.R") 
# --- Libraries
library(shiny)
library(rvest)
# --- Initialisation

# Define server logic required to draw a histogram
shinyServer(function(input, output){
 value <- reactiveValues()

  # --- Age Plot
  output$plotAgeDist <- renderPlotly({plotAge})

  

  
  # --- Filter code
  
  ages <- sort(unique(data$age))
  output$ages <- renderUI({
    selectizeInput("ages", choices = ages, label = "Ages",multiple = TRUE)
  })
  
  # --- download code
  # summarydf1 <- eventReactive(input$myData1,{
  #   input$myData1 %>%
  #     read_html %>%
  #     html_table(fill = TRUE) %>%
  #     .[[2]]
  # })
  # 
  # observeEvent( input$save1, {
  #   write.csv(summarydf1(), file="./dataDownload.csv")
  # })
  # 
  # output$download1 <- downloadHandler(
  #   filename = function(){"Data.csv"}, 
  #   content = function(filename){
  #     write.csv(summarydf1(), filename,row.names = FALSE)
  #   }
  # )
  
  
})
