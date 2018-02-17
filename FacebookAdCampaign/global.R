#########################################################################
#
# --- Facebook Campaign main.R
#
#########################################################################

#setwd("/srv/shiny-server/facebookAd")
setwd("/Users/danielacasilli/Docs/DataScience/DataScienceWork/FacebookAdCampaign")
# --- Libraries
{
  library(dplyr)
  library(ggplot2)
  library(plotly)
}

# --- File reading
data <- read.csv("conversion_data.csv", stringsAsFactors = F)

# --- plot

plotAge <- data %>%
  group_by(age) %>%
  summarise(countPpl = n()) %>%
  plot_ly() %>%
  add_trace(x = ~age, y = ~countPpl, type = "bar") %>%
  layout(title = "Age Distribution",
         xaxis = list(title = "Age"),
         yaxis = list(title = "Count of People"))

plotAge

