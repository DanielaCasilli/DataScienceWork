#########################################################################
#
# --- Facebook Campaign dataManipulation.R
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
source('wssPlot.R')


# --- File reading
rawData <- read.csv("./conversion_data.csv", stringsAsFactors = T)
data <- rawData

# --- dummy variables
{
  
  # convert many columns to factors
  cols <- c("xyz_campaign_id")
  data[cols] <- lapply(data[cols], factor)
  data <- dummy.data.frame(data, sep = "_")
  
  # bucketize Impressions
  {
    # run kmeans to find number of buckets
    df <- as.data.frame(data$Impressions)
    names(df) <- c("Impressions")
    # scale data
    kmeansDataDf <- scale(df, center = TRUE, scale = TRUE)
    # wss plot
    wssPlot(kmeansDataDf)
    # kmeans ckuster with 4 cluster
    kmeansCluster <- kmeans(kmeansDataDf, 3)
    # add cluster label to data
    df$cluster <- as.factor(kmeansCluster$cluster)
    # make bucket based on mid point between means
    centroid1 <- mean(df[which(df$cluster == "1"),"Impressions"])
    centroid2 <- mean(df[which(df$cluster == "2"),"Impressions"])
    centroid3 <- mean(df[which(df$cluster == "3"),"Impressions"])
    # sort centroids
    centroids <- sort(c(centroid1, centroid2, centroid3))
    data <- data %>% 
      mutate(impression_grp1 = ifelse(Impressions <= (centroids[2]+centroids[1])/2, 1, 0),
             impression_grp2 = ifelse(Impressions <= (centroids[3]+centroids[2])/2 & Impressions > (centroids[2]+centroids[1])/2, 1, 0),
             impression_grp3 = ifelse(Impressions > (centroids[3]+centroids[2])/2, 1, 0)) %>%
      rename( !!paste("impression",round((centroids[2]+centroids[1])/2,2),sep = "<") := impression_grp1,
              !!paste("impression",round((centroids[3]+centroids[2])/2,2),sep = "<") := impression_grp2,
              !!paste("impression",round((centroids[3]+centroids[2])/2,2),sep = ">") := impression_grp3)
  }
  
  # bucketize Clicks
  {
    # run kmeans to find number of buckets
    df <- as.data.frame(data$Clicks)
    names(df) <- c("Clicks")
    # scale data
    kmeansDataDf <- scale(df, center = TRUE, scale = TRUE)
    # wss plot
    wssPlot(kmeansDataDf)
    # kmeans ckuster with 4 cluster
    kmeansCluster <- kmeans(kmeansDataDf, 3)
    # add cluster label to data
    df$cluster <- as.factor(kmeansCluster$cluster)
    # make bucket based on mid point between means
    centroid1 <- mean(df[which(df$cluster == "1"),"Clicks"])
    centroid2 <- mean(df[which(df$cluster == "2"),"Clicks"])
    centroid3 <- mean(df[which(df$cluster == "3"),"Clicks"])
    # sort centroids
    centroids <- sort(c(centroid1, centroid2, centroid3))
    data <- data %>% 
      mutate(Clicks_grp1 = ifelse(Clicks <= (centroids[2]+centroids[1])/2, 1, 0),
             Clicks_grp2 = ifelse(Clicks <= (centroids[3]+centroids[2])/2 & Clicks > (centroids[2]+centroids[1])/2, 1, 0),
             Clicks_grp3 = ifelse(Clicks > (centroids[3]+centroids[2])/2, 1, 0)) %>%
      rename( !!paste("Clicks",round((centroids[2]+centroids[1])/2,2),sep = "<") := Clicks_grp1,
              !!paste("Clicks",round((centroids[3]+centroids[2])/2,2),sep = "<") := Clicks_grp2,
              !!paste("Clicks",round((centroids[3]+centroids[2])/2,2),sep = ">") := Clicks_grp3)
  }
  
  # bucketize Total_Conversion
  {
    # run kmeans to find number of buckets
    df <- as.data.frame(data$Total_Conversion)
    names(df) <- c("Total_Conversion")
    # scale data
    kmeansDataDf <- scale(df, center = TRUE, scale = TRUE)
    # wss plot
    wssPlot(kmeansDataDf)
    # kmeans ckuster with 4 cluster
    kmeansCluster <- kmeans(kmeansDataDf, 3)
    # add cluster label to data
    df$cluster <- as.factor(kmeansCluster$cluster)
    # make bucket based on mid point between means
    centroid1 <- mean(df[which(df$cluster == "1"),"Total_Conversion"])
    centroid2 <- mean(df[which(df$cluster == "2"),"Total_Conversion"])
    centroid3 <- mean(df[which(df$cluster == "3"),"Total_Conversion"])
    # sort centroids
    centroids <- sort(c(centroid1, centroid2, centroid3))
    data <- data %>% 
      mutate(Total_Conversion_grp1 = ifelse(Total_Conversion <= (centroids[2]+centroids[1])/2, 1, 0),
             Total_Conversion_grp2 = ifelse(Total_Conversion <= (centroids[3]+centroids[2])/2 & Total_Conversion > (centroids[2]+centroids[1])/2, 1, 0),
             Total_Conversion_grp3 = ifelse(Total_Conversion > (centroids[3]+centroids[2])/2, 1, 0)) %>%
      rename( !!paste("Total_Conversion",round((centroids[2]+centroids[1])/2,2),sep = "<") := Total_Conversion_grp1,
              !!paste("Total_Conversion",round((centroids[3]+centroids[2])/2,2),sep = "<") := Total_Conversion_grp2,
              !!paste("Total_Conversion",round((centroids[3]+centroids[2])/2,2),sep = ">") := Total_Conversion_grp3)
  }
  
  # bucketize Approved_Conversion
  {
    # run kmeans to find number of buckets
    df <- as.data.frame(data$Approved_Conversion)
    names(df) <- c("Approved_Conversion")
    # scale data
    kmeansDataDf <- scale(df, center = TRUE, scale = TRUE)
    # wss plot
    wssPlot(kmeansDataDf)
    # kmeans ckuster with 4 cluster
    kmeansCluster <- kmeans(kmeansDataDf, 3)
    # add cluster label to data
    df$cluster <- as.factor(kmeansCluster$cluster)
    # make bucket based on mid point between means
    centroid1 <- mean(df[which(df$cluster == "1"),"Approved_Conversion"])
    centroid2 <- mean(df[which(df$cluster == "2"),"Approved_Conversion"])
    centroid3 <- mean(df[which(df$cluster == "3"),"Approved_Conversion"])
    # sort centroids
    centroids <- sort(c(centroid1, centroid2, centroid3))
    data <- data %>% 
      mutate(Approved_Conversion_grp1 = ifelse(Approved_Conversion <= (centroids[2]+centroids[1])/2, 1, 0),
             Approved_Conversion_grp2 = ifelse(Approved_Conversion <= (centroids[3]+centroids[2])/2 & Approved_Conversion > (centroids[2]+centroids[1])/2, 1, 0),
             Approved_Conversion_grp3 = ifelse(Approved_Conversion > (centroids[3]+centroids[2])/2, 1, 0)) %>%
      rename( !!paste("Approved_Conversion",round((centroids[2]+centroids[1])/2,2),sep = "<") := Approved_Conversion_grp1,
              !!paste("Approved_Conversion",round((centroids[3]+centroids[2])/2,2),sep = "<") := Approved_Conversion_grp2,
              !!paste("Approved_Conversion",round((centroids[3]+centroids[2])/2,2),sep = ">") := Approved_Conversion_grp3)
  }
  
  # bucketize Spent
  {
    # run kmeans to find number of buckets
    df <- as.data.frame(data$Spent)
    names(df) <- c("Spent")
    # scale data
    kmeansDataDf <- scale(df, center = TRUE, scale = TRUE)
    # wss plot
    wssPlot(kmeansDataDf)
    # kmeans ckuster with 4 cluster
    kmeansCluster <- kmeans(kmeansDataDf, 3)
    # add cluster label to data
    df$cluster <- as.factor(kmeansCluster$cluster)
    # make bucket based on mid point between means
    centroid1 <- mean(df[which(df$cluster == "1"),"Spent"])
    centroid2 <- mean(df[which(df$cluster == "2"),"Spent"])
    centroid3 <- mean(df[which(df$cluster == "3"),"Spent"])
    # sort centroids
    centroids <- sort(c(centroid1, centroid2, centroid3))
    data <- data %>% 
      mutate(Spent_grp1 = ifelse(Spent <= (centroids[2]+centroids[1])/2, 1, 0),
             Spent_grp2 = ifelse(Spent <= (centroids[3]+centroids[2])/2 & Spent > (centroids[2]+centroids[1])/2, 1, 0),
             Spent_grp3 = ifelse(Spent > (centroids[3]+centroids[2])/2, 1, 0)) %>%
      rename( !!paste("Spent",round((centroids[2]+centroids[1])/2,2),sep = "<") := Spent_grp1,
              !!paste("Spent",round((centroids[3]+centroids[2])/2,2),sep = "<") := Spent_grp2,
              !!paste("Spent",round((centroids[3]+centroids[2])/2,2),sep = ">") := Spent_grp3)
  }
  
  # bucketize interest
  {
    # run kmeans to find number of buckets
    df <- as.data.frame(data$interest)
    names(df) <- c("interest")
    # scale data
    kmeansDataDf <- scale(df, center = TRUE, scale = TRUE)
    # wss plot
    wssPlot(df)
    # kmeans ckuster with 4 cluster
    kmeansCluster <- kmeans(kmeansDataDf, 4)
    # add cluster label to data
    df$cluster <- as.factor(kmeansCluster$cluster)
    # make bucket based on mid point between means
    centroid1 <- mean(df[which(df$cluster == "1"),"interest"])
    centroid2 <- mean(df[which(df$cluster == "2"),"interest"])
    centroid3 <- mean(df[which(df$cluster == "3"),"interest"])
    centroid4 <- mean(df[which(df$cluster == "4"),"interest"])
    # sort centroids
    centroids <- sort(c(centroid1, centroid2, centroid3, centroid4))
    data <- data %>% 
      mutate(interest_grp1 = ifelse(interest <= (centroids[2]+centroids[1])/2, 1, 0),
             interest_grp2 = ifelse(interest <= (centroids[3]+centroids[2])/2 & interest > (centroids[2]+centroids[1])/2, 1, 0),
             interest_grp3 = ifelse(interest <= (centroids[4]+centroids[3])/2 & interest > (centroids[3]+centroids[2])/2, 1, 0),
             interest_grp4 = ifelse(interest > (centroids[4]+centroids[3])/2, 1, 0)) %>%
      rename( !!paste("interest",round((centroids[2]+centroids[1])/2,2),sep = "<") := interest_grp1,
              !!paste("interest",round((centroids[3]+centroids[2])/2,2),sep = "<") := interest_grp2,
              !!paste("interest",round((centroids[4]+centroids[3])/2,2),sep = "<") := interest_grp3,
              !!paste("interest",round((centroids[4]+centroids[3])/2,2),sep = ">") := interest_grp4)
    
  }
  
  rm(df, kmeansCluster, kmeansDataDf)
  rm(centroid1, centroid2, centroid3, centroid4, centroids)
  
}

# --- kmeans
{
  
  # drop unnecessary columns
  colsDrop <- c("interest","Impressions", "Clicks", "Spent", "Total_Conversion", "Approved_Conversion")
  data <- data[ , !(names(data) %in% colsDrop)]
  # plot to determine clusters
  wssPlot(data)
  # kmeans ckuster with 4 cluster
  set.seed(123)
  kmeansCluster <- kmeans(data, 4)
  # add cluster label to data
  data$cluster <- as.factor(kmeansCluster$cluster)
  # add clusetr label to original data set
  labels = data[,c("ad_id", "cluster")]
  data2 <- left_join(rawData, labels, by = "ad_id", all = TRUE)
  
  data2$xyz_campaign_id <- as.factor(data2$xyz_campaign_id)
}

