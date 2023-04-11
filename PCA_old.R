rm(list=ls())

library(tidyverse)
library(dplyr)

df <- read.csv("finaldata.csv")

set.seed(7)

target <- c("2011","2012","2013","2014","2015")
#target <- c("2012")

for (year in target)
{
  
  dfYear <- df %>% filter(df$Year == year)
  
  PCA <- prcomp(dfYear[,-c(1:5)],center=TRUE,scale=TRUE)
  
#  summary(PCA)
#  PCA$sdev
#  PCA$rotation
  
#  plot(PCA)
  
  dfYear$Class = integer(length(dfYear$Status))+2
  dfYear$Class[dfYear$Life.expectancy > 70]  = 3
  
  plot(PCA$x[,1], integer(length(PCA$x[,1])), col = dfYear$Class,xlab="", ylab="", pch=20, cex=2)
  plot(PCA$x[,c(1,2)], col = dfYear$Class, xlab="", ylab="", pch=20, cex=2)
  
  dfYear$CountryClass = integer(length(dfYear$Status))+2
  dfYear$CountryClass[dfYear$Status == 'Developed']  = 3
  
  plot(PCA$x[,1], integer(length(PCA$x[,1])), col = dfYear$CountryClass, xlab="", ylab="", pch=20, cex=2)
  plot(PCA$x[,c(1,2)], col = dfYear$CountryClass, xlab="", ylab="", pch=20, cex=2)
  
  std_dev <- PCA$sdev
  pr_var <- std_dev^2
  pve <- pr_var/sum(pr_var)
  
  x = 1:length(pve)
  
  p1 <- qplot(x,pve, xlab="Principal Component",ylab="PVE") +
    geom_line()+geom_point(shape=21,fill="blue",cex=3) + 
    ggtitle(paste("Proportion of Variance Explained from Year ", year))
  print(p1)
  
  p2 <- qplot(x,cumsum(pve), xlab="Principal Component",ylab="CPV", main="  ",ylim=c(0,1))+
    geom_line()+geom_point(shape=21,fill="blue",cex=3) + 
    ggtitle(paste("Cumulative Proportion of Variance from Year ", year))
  print(p2)
  
  
  
  km.out=kmeans(PCA$x[,c(1,2)],2,nstart=20) 
  km.out$cluster
  plot(PCA$x[,1], integer(length(PCA$x[,1])), col=(km.out$cluster+1), main=paste("1D K-Means Clustering Results with K=2 for Year ", year), 
       xlab="", ylab="", pch=20, cex=2)
  plot(PCA$x[,c(1,2)], col=(km.out$cluster+1), main=paste("2D K-Means Clustering Results with K=2 for Year ", year), 
       xlab="", ylab="", pch=20, cex=2)
  
}



