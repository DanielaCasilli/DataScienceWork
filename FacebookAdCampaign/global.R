#########################################################################
#
# --- Facebook Campaign main.R
#
#########################################################################

#setwd("/srv/shiny-server/facebookAd")
#setwd("/Users/danielacasilli/Docs/DataScience/DataScienceWork/FacebookAdCampaign")
setwd("~/DataScienceWork/FacebookAdCampaign/")
# --- Libraries
{
  library(dplyr)
  library(ggplot2)
  library(plotly)
  library(scales)
}

# --- File reading
data <- read.csv("conversion_data.csv", stringsAsFactors = F)

# --- plots

plotAge <- data %>%
  group_by(age) %>%
  summarise(countPpl = n()) %>%
  plot_ly() %>%
  add_trace(x = ~age, y = ~countPpl, type = "bar") %>%
  layout(title = "Age Distribution",
         xaxis = list(title = "Age"),
         yaxis = list(title = "Count of People"))

plotAge

plotInterest <- data %>%
  plot_ly() %>%
  add_trace(x = ~interest, 
            y = ~Total_Conversion, 
            color = ~age,
            colors = "Set1",
            marker = list(size = 10)) %>%
  layout(title = 'Conversion vs Interest by Age Group',
         yaxis = list(zeroline = FALSE),
         xaxis = list(zeroline = FALSE))
plotInterest



# --- kmeans

kmeansData <- data %>%
  mutate(Age30_34 = ifelse(age == "30-34", 1,0),
         Age35_39 = ifelse(age == "35-39", 1,0),
         Age40_44 = ifelse(age == "40-44", 1,0),
         Age45_49 = ifelse(age == "45-49", 1,0),
         Male_ind = ifelse(gender == "M", 1, 0)
         ) %>%
  select(ad_id,
         interest,
         Impressions,
         Clicks,
         Spent,
         Total_Conversion,
         Approved_Conversion,
         Age30_34,
         Age35_39,
         Age40_44,
         Age45_49,
         Male_ind)

# scale data
kmeansDataDf <- scale(kmeansData[,-1], center = TRUE, scale = TRUE)
# kmeans ckuster with 4 cluster
kmeansCluster <- kmeans(kmeansDataDf, 4)
kmeansCluster
# add cluster label to data
kmeansData$cluster <- as.factor(kmeansCluster$cluster)
# add clusetr label to original data set
labels = kmeansData[,c("ad_id", "cluster")]
data2 <- left_join(data, labels, by = "ad_id", all = TRUE)

# graph clusters
plotBehaviour <- data2 %>%
  #filter(cluster == "1") %>%
  group_by(cluster, gender) %>%
  summarise(count = n()) %>%
  ggplot(aes(x = cluster, y = count, fill = gender))+
  geom_bar(stat = "Identity")
# plot graph
plotBehaviour 




