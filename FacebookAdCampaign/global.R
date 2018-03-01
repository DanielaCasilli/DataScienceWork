#########################################################################
#
# --- Facebook Campaign global.R
#
#########################################################################

# --- Set up

setwd("/srv/shiny-server/facebookCampaign")
# libraries
library(dplyr)
library(ggplot2)
library(plotly)
library(scales)
library(dummies)
library(cluster)
# source functions
source('data.R')


# --- File reading
#data2 <- read.csv("./clusteredData.csv", stringsAsFactors = T)
data2$interest <- as.factor(data2$interest)
data2$cluster <- as.factor(data2$cluster)
data2$ad_id <- as.factor(data2$ad_id)
data2$xyz_campaign_id <- as.factor(data2$xyz_campaign_id)
data2$fb_campaign_id <- as.factor(data2$fb_campaign_id)



# --- plots
{
  
  # Quantify how conversion rate varies with age, gender or interest.
  plot1 <- data2 %>%
    group_by(cluster, age) %>%
    summarise(conversionRate = sum(Approved_Conversion)/sum(Total_Conversion)) %>%
    #summarise(conversionRate = sum(Approved_Conversion)) %>%
    plot_ly(x = ~cluster, y = ~conversionRate, color = ~ age,  type = "bar") %>%
    layout(title = "Age Distribution",
           xaxis = list(title = "Age"),
           yaxis = list(title = "Sum of Approved Conversions"),
           barmode = 'stack')
  
  plot1

  
  plot2 <- data2 %>%
    group_by(cluster, gender) %>%
    summarise(conversionRate = sum(Approved_Conversion)) %>%
    plot_ly(x = ~gender, y = ~conversionRate, color = ~cluster,  type = "bar") %>%
    layout(title = "Gender Distribution",
           xaxis = list(title = "Gender"),
           yaxis = list(title = "Sum of Approved Conversions"))
  
  plot2
  
  
  
  plot3 <- data2 %>%
    group_by(cluster, interest) %>%
    summarise(conversionRate = sum(Approved_Conversion)) %>%
    plot_ly(x = ~interest, y = ~conversionRate, color = ~cluster,  type = "bar") %>%
    layout(title = "Interest Distribution",
           xaxis = list(title = "Interest"),
           yaxis = list(title = "Sum of Approved Conversions"))
  
  plot3
  
  

  
  plot4 <- data2 %>% 
    plot_ly(x = ~Total_Conversion, y = ~Approved_Conversion, size = ~Spent, color = ~cluster)%>%
    layout(title = "Cluster Distribution",
           xaxis = list(title = "Total Conversion"),
           yaxis = list(title = "Approved Conversion"))
  
  plot4
  
  
  # Identify segments with high and low cost per acquisition.
  plot5 <- data2 %>% 
    plot_ly(x = ~Spent , y = ~Approved_Conversion , color = ~cluster)%>%
    layout(title = "Cluster Distribution",
           xaxis = list(title = "Spent"),
           yaxis = list(title = "Approved Conversion"))
  
  plot5
  
  
  
  
  # Segment the audience based on click through rates/ conversion rates
  
  # Compare how the various xyz_campaigns and fb_campaigns are performing.
  
  plot6 <- data2 %>%
    group_by(xyz_campaign_id, Impressions) %>%
    summarise(conversionRate = sum(Clicks)) %>%
    plot_ly(x = ~Impressions, y = ~conversionRate, color = ~xyz_campaign_id) %>%
    layout(title = "Clicks Distribution",
           xaxis = list(title = "Impressions"),
           yaxis = list(title = "Clicks"))
  
  plot6
  
  
  
  
  
}



