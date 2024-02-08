##-----------------------------------------------------------------------------
# ECON 491
# Illakkia Ranjani
# Analysis By Neighborhood
##-----------------------------------------------------------------------------
# Set Up
##-----------------------------------------------------------------------------

rm(list = ls())
setwd("C:/Users/illak/OneDrive/Classes/spring 24/ECON 491")

housing <- read.csv("train.csv")

##-----------------------------------------------------------------------------
# Making data frame containing avg sale price, avg yr built, avg yr remodeled
# grouped by neighborhood
##-----------------------------------------------------------------------------

library(tidyverse)
library(ggrepel)


names <- c("Bloomington Heights", "Bluestem", "Briardale", "Brookside", "Clear Creek",
           "College Creek", 'Crawford', 'Edwards', 'Gilbert', 'Iowa DOT and Rail Road',
           'Meadow Village', 'Mitchell', 'North Ames', 'Northridge', 'Northpark Villa',
           'Northridge Heights', 'Northwest Ames', 'Old Town', 'South & West of Iowa State University',
           'Sawyer', 'Sawyer West', 'Somerset', 'Stone Brook', 'Timberland', 'Veenker')

neighborhood_price <- data.frame(aggregate(housing$SalePrice, list(housing$Neighborhood), FUN=mean))
colnames(neighborhood_price) <- c("Neighborhood_ID", "Average_Sale_Price")

neighborhood_yr_built <- data.frame(aggregate(housing$YearBuilt, list(housing$Neighborhood), FUN=mean))
colnames(neighborhood_yr_built) <- c("Neighborhood_ID", "Average_Year_Built")

neighborhood_yr_remod <- data.frame(aggregate(housing$YearRemodAdd, list(housing$Neighborhood), FUN=mean))
colnames(neighborhood_yr_remod) <- c("Neighborhood_ID", "Average_Year_Remodel")

neighborhood_qual <- data.frame(aggregate(housing$OverallQual, list(housing$Neighborhood), FUN=mean))
colnames(neighborhood_qual) <- c("Neighborhood_ID", "Average_Overall_Quality")

neighborhood_price$name <- names
colnames(neighborhood_price) <- c("Neighborhood_ID", "Average_Sale_Price", "Neighborhood_Name")
neighborhood_price <- neighborhood_price[, c(1, 3, 2)]

neighborhood_data <- merge(neighborhood_price, neighborhood_yr_built)

neighborhood_data <- merge(neighborhood_data, neighborhood_yr_remod)

neighborhood_data <- merge(neighborhood_data, neighborhood_qual)

##-----------------------------------------------------------------------------
# Making scatterplots
##-----------------------------------------------------------------------------


#qual

avg_qual <- ggplot(neighborhood_data, aes(x = Average_Overall_Quality,
                                             y = Average_Sale_Price, 
                                             label = Neighborhood_Name)) +
  geom_point()

avg_qual + ggtitle("Correlation Between Avg Overall Quality and Avg Sale
                                  Price, By Neighborhood")+
  geom_label_repel(aes(label = Neighborhood_Name), 
                   box.padding   = 0.20, 
                   point.padding = 0.4,
                   segment.color = 'grey50')


#yr built

avg_yr_plot <- ggplot(neighborhood_data, aes(x = Average_Year_Built,
                                                y = Average_Sale_Price, 
                                                label = Neighborhood_Name)) +
                geom_point()

avg_yr_plot + ggtitle("Correlation Between Avg Year Built and Avg Sale
                                  Price, By Neighborhood")+
  geom_label_repel(aes(label = Neighborhood_Name), 
                   box.padding   = 0.25, 
                   point.padding = 0.4,
                   segment.color = 'grey50')

#yr remod

avg_remod <- ggplot(neighborhood_data, aes(x = Average_Year_Remodel,
                                          y = Average_Sale_Price, 
                                          label = Neighborhood_Name)) +
  geom_point()

avg_remod + ggtitle("Correlation Between Avg Year Remodeled and Avg Sale
                                  Price, By Neighborhood")+
  geom_label_repel(aes(label = Neighborhood_Name), 
                   box.padding   = 0.15, 
                   point.padding = 0.4,
                   segment.color = 'grey50')

##-----------------------------------------------------------------------------
