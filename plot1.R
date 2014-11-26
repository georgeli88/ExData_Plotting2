
## Before run 
## Use 
##      setwd("C:\\Class_Training\\Data Science\\4. Exploratory Data Analysis\\CourseProject2") 
## to set the current working directory 
## 
## Assume
## (1) Folder "exdata_data_NEI_data" is the sub-folder in current working directory
## (2) File "summarySCC_PM25.rds" is inside the sub-folder "exdata_data_NEI_data" 
##

## Course Project 2.1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008. 
## Upload a PNG file containing your plot addressing this question.


## Read data from RDS file
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

## get the unique number of the year
x <- unique(NEI$year)
        
## get the total PM2.5 emission from all sources 
y <- tapply(NEI$Emissions, factor(NEI$year), sum)
        
## Plot diagram
par(mfrow=c(1,2))
plot(x, y, type="b", xlab="Year", ylab="Total PM2.5 Emission", pch=19, main="PM2.5 Emission in US")
plot(x, y, type="l", xlab="Year", ylab="Total PM2.5 Emission", main="PM2.5 Emission in US")
      
## write to PNG file and close PNG device
dev.copy(png, file="plot1.png", width = 960, height = 480)
dev.off()

