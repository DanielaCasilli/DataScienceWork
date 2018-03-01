# ~~~~~~~~ Wss Function

wssPlot <- function(df) {
  # plot to determine clusters
  wssplot = function(data, nc = 15, seed = 0) {
    wss = (nrow(data) - 1) * sum(apply(data, 2, var))
    for (i in 2:nc) {
      set.seed(seed)
      wss[i] = sum(kmeans(data, centers = i, iter.max = 100, nstart = 100)$withinss)
    }
    plot(1:nc, wss, type = "b",
         xlab = "Number of Clusters",
         ylab = "Within-Cluster Variance",
         main = "Scree Plot for the K-Means Procedure")
  }
  #Visualizing the scree plot for the scaled iris data; 3 seems like a plausible choice
  #wssplot(df)
}




