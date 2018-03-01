#########################################################################
#
# --- Facebook Campaign ui.R
#
#########################################################################

# --- Set up
rm(list = ls())
setwd("/srv/shiny-server/facebookCmapaign")
# libraries
library(shiny)
library(shinyLP)
library(shinyBS)
library(shinythemes)
library(shinydashboard)
library(shinycssloaders)
library(dplyr)


# --- Set up Shiny

# Define Shiny Items
DBHeader <- dashboardHeader(title = "")

DBSidebar <- dashboardSidebar(
  sidebarMenu(theme = shinytheme("united"))
)
DBBody <- dashboardBody(
  
)


# --- UI

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
      "An analysis of Facebook ad campaign",
      button = FALSE
    ),
    
    
    column(
      12,
      panel_div(
        "success",
        "Application Maintainers",
        "Email: <a href='mailto:Daniela.Casilli@gmail.com?Subject=Shiny%20Facebook%20Ad%20Campaign%20Analysis' target='_top'>Daniela Casilli</a> <br>"
      )
    )
    
  )
  ,
  
  
  tabPanel(
    "Cluster Characteristics",
    fluidRow(
      column(12,
      box(plotlyOutput("plot1") %>% withSpinner(type = 8, color = "red")),
      box(plotlyOutput("plot2")%>% withSpinner(type = 8, color = "red"))
      )
    ),
    fluidRow(
      column(12,
      box(plotlyOutput("plot3")%>% withSpinner(type = 8, color = "red")),
      box(plotlyOutput("plot4")%>% withSpinner(type = 8, color = "red"))
      )
    )
  )
  ,
  
  
  tabPanel(
    "Cluster Analysis",
    fluidRow(
      column(12,
             box(plotlyOutput("plot5") %>% withSpinner(type = 8, color = "red")),
             box(plotlyOutput("plot6")%>% withSpinner(type = 8, color = "red"))
      )
    )
  )

))