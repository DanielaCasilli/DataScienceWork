rm(list = ls())
#setwd("/srv/shiny-server/facebookAd")
setwd("/Users/danielacasilli/Docs/DataScience/DataScienceWork/FacebookAdCampaign")
library(shiny)
library(shinyLP)
library(shinyBS)
library(shinythemes)
library(shinydashboard)
library(shinycssloaders)
library(dplyr)
# Define Shiny Items
DBHeader <- dashboardHeader(title = "")

DBSidebar <- dashboardSidebar(
  sidebarMenu(theme = shinytheme("united"))
)
DBBody <- dashboardBody(
  
)
# Create UI


shinyUI(navbarPage(
  title = div(
              "Facebook Ad Campaign Analysis"),
  inverse = F,
  theme = shinytheme("united"),
  
  tabPanel(
    "Landing Page",
    icon = icon("home"),
    
    jumbotron(
      "Facebook Ad Campaign Analysis",
      "An analysis of Facebook Ad campaign",
      button = FALSE
    ),
    
    
    column(
      6,
      panel_div(
        "success",
        "Application Maintainers",
        "Email: <a href='mailto:Daniela.Casilli@gmail.com?Subject=Shiny%20Facebook%20Ad%20Campaign%20Analysis' target='_top'>Daniela Casilli</a> <br>"
      )
    )
    
  )
  ,
  
  
  tabPanel(
    "Age Plot",
    fluidRow(
    column(4,
           uiOutput("ages"))
    ),
    fluidRow(
      box(plotlyOutput("plotAgeDist") %>% withSpinner(type = 8, color = "red"))
    )
  )

))