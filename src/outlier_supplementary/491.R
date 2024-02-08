library(dplyr)
library(ggplot2)
library(readr)
train <- read_csv("Downloads/Junior/ECON 491/train.csv")
summary(train)
names(train)
mydata <- train
?train
nrow(mydata)
ncol(mydata)
#scatterplot for price based on year
yrVSprice <- ggplot(data = train, mapping = aes(x = train$YearBuilt, 
                                                y = train$SalePrice)) + 
  geom_point()
yrVSprice



library(scales)
point <- format_format(big.mark = " ", decimal.mark = ",", scientific = FALSE)
yearbuilt <- ggplot(data = train, aes(x=train$YearBuilt, 
                                      y=train$SalePrice)) +
  geom_point() + 
  labs(x = "Year Built", y = "Sale Price" ,title = "Year Built and Sale Price") +
  geom_smooth(method = "glm", formula = y~x,
              method.args = list(family = gaussian(link = 'log')))+
  scale_y_continuous(labels = point)

yearbuilt

## add price per square foot as a variable

Q <- quantile(mydata$LotArea, probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(mydata$LotArea)
eliminated<- subset(mydata, mydata$LotArea > (Q[1] - 1.5*iqr) 
                    & mydata$LotArea < (Q[2]+1.5*iqr)
                    & (is.na(mydata$MasVnrType) != TRUE)
                    & (mydata$MasVnrType != "None"))  

masonrytype <- ggplot(data = eliminated, aes(x = MasVnrType)) +
  geom_histogram(stat="count")+
  labs(x = "Type of Masonry", y = "Number of Units", 
       title = "Type of Masonry in Unit") +
  theme(text = element_text(family = "Times New Roman"))
masonrytype


masonry <- ggplot(data = eliminated, aes(x = MasVnrArea, y = SalePrice, 
                                     color = LotArea, shape = MasVnrType)) +
  geom_point()+
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_color_viridis_c(name = "Lot Area", option = "mako")  +
  scale_shape_manual(values=c(15, 16, 3)) + 
  labs(x = "Area of Masonry", y = "Price", 
       title = "Area of Masonry vs Sale Price", shape = "Masonry Type") +
  scale_y_continuous(labels = point) +
  theme(text = element_text(family = "Times New Roman"))
masonry


 remodelHIST <- ggplot(data = subset(mydata, mydata$YearRemodAdd > 1950), aes(x = YearRemodAdd))+
   geom_histogram() + 
   labs(x = "Year of Remodel", y = "Frequency", title = "Remodeled Houses") + 
   scale_fill_manual(values = "#799163")
 remodelHIST
 
                 
remodel_breaks <- c(-Inf, 1950, 1970, 1990, 2010)
remodel_labels <- c("<1950", "1951-1970", "1971-1990", "<2010")
                 
                 # Create a new factor variable based on the breaks
mydata$Remodel_Group <- cut(mydata$YearRemodAdd, breaks = remodel_breaks, labels = remodel_labels)
                 
                 # Create the box plot
remodboxplot <- ggplot(data = mydata, aes(x = Remodel_Group, y = SalePrice, color = "YearRemodAdd")) +
  geom_boxplot(aes(color = as.factor(YearRemodAdd))) +  # Color points by YearRemodAdd
  geom_point(position = position_jitter(width = 0.2), size = 2.5) +  # Add jittered points
  labs(x = "Year of Remodel", y = "Sale Price", title = "Sale Price Distribution by Year of Remodel") +
                   labs(x = "Year of Remodel", y = "Sale Price", title = "Sale Price Distribution by Year of Remodel") +
                   scale_x_discrete(labels = c("Not Remodeled", "1951-1970", "1971-1990", "<2010")) +
                   theme_minimal()
remodboxplot


# Calculate the lower and upper bounds of the IQR
Q <- quantile(mydata$SalePrice, probs = c(0.25, 0.75))
lower_bound <- Q[1] - 1.5 * IQR(mydata$SalePrice)
upper_bound <- Q[2] + 1.5 * IQR(mydata$SalePrice)

# Identify outliers based on the bounds
outliers <- mydata$SalePrice < lower_bound | mydata$SalePrice > upper_bound

# Convert YearRemodAdd to numeric for gradient coloring
mydata$YearRemodAdd_numeric <- as.numeric(mydata$YearRemodAdd)

# Create the box plot
remodboxplot <- ggplot(data = mydata, aes(x = Remodel_Group, y = SalePrice)) +
  geom_boxplot() +
  geom_point(data = mydata[outliers, ], aes(color = YearRemodAdd_numeric), position = position_jitter(width = 0.15), size = 1.5) +
  labs(x = "Year of Remodel", y = "Sale Price", title = "Sale Price Distribution by Year of Remodel") +
  scale_x_discrete(labels = c("Not Remodeled", "1951-1970", "1971-1990", "<2010")) +
  scale_color_viridis_c(name = "Year Remod") +
  theme_minimal()

remodboxplot

remodviolinplot <- ggplot(data = mydata, aes(x = Remodel_Group, y = SalePrice)) +
  geom_violin(trim = FALSE) +  # Use trim = FALSE to extend the density to the minimum and maximum values
  geom_point(data = mydata[outliers, ], aes(color = YearRemodAdd_numeric), position = position_jitter(width = 0.15), size = 2) +
  labs(x = "Year of Remodel", y = "Sale Price", title = "Sale Price Distribution by Year of Remodel") +
  scale_x_discrete(labels = c("Not Remodeled", "1951-1970", "1971-1990", "<2010")) +
  scale_color_viridis_c(name = "Year Remod") +
  scale_y_continuous(labels = point) +
  theme_minimal()

remodviolinplot

library(RColorBrewer)
library(corrplot)

#correlation matrix
numeric_cols <- sapply(mydata, is.numeric)
numeric_no_missing <- colSums(is.na(mydata[numeric_cols])) == 0
newdata <- mydata[numeric_cols] [numeric_no_missing]
corr <- cor(newdata)

# Rcolor Brewer
my_colors <- colorRampPalette(brewer.pal(5, "Spectral"))(100)

#correlation matrix
ord <- order(corr[1, ])
corr_ord <- corr[ord, ord]
corrplot(corr_ord, order = 'AOE', method = "ellipse", number.cex = 0.8, 
         tl.cex = .5,tl.col = "black", col = my_colors, number.digits = 1)


## OUTLLIERS
##clean attempt 1
Qstar <- quantile(mydata$LotArea, probs=c(.25, .75), na.rm = FALSE)

iqrStar <- IQR(mydata$LotArea)
eliminated1<- subset(mydata, mydata$LotArea > (Qstar[1] - 1.5*iqrStar) 
                    & mydata$LotArea < (Q[2]+1.5*iqrStar))  
nrow(eliminated1)
nrow(mydata)

ids <- which(mydata$MasVnrArea > 1500)

View(data_for_id <- mydata[mydata$Id == ids, ])
rows_over_500k <- mydata[mydata$SalePrice > 500000, ]

# Print or view the rows with prices over $500,000
View(rows_over_500k)
