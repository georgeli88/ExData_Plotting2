
## Before run 
## Use 
##      setwd("C:\\Class_Training\\Data Science\\4. Exploratory Data Analysis\\CourseProject2") 
## to set the current working directory 
## 
## Assume
## (1) Folder "exdata_data_NEI_data" is the sub-folder in current working directory
## (2) File "summarySCC_PM25.rds" is inside the sub-folder "exdata_data_NEI_data" 
##

## Course Project 2.2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

## Read data from RDS file
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
        
## get the subset for Baltimore City, Maryland (fips == "24510") 
sub <- NEI[as.character(NEI$fips)=="24510", ]

## get the unique number of the year
x <- unique(sub$year)
        
## get the total PM2.5 emission from all sources 
y <- tapply(sub$Emissions, factor(sub$year), sum)
        
## Plot 2 diagrams with "dot" and "line"
par(mfrow=c(1,2))
plot(x, y, xlab="Year", ylab="Total PM2.5 Emission", pch=19, main="PM2.5 Emission in Baltimore")
lines(x,y,type="l") 
plot(x,y, type="l", xlab="Year", ylab="Total PM2.5 Emission",main="PM2.5 Emission in Baltimore")


## write to PNG file and close PNG device
dev.copy(png, file="plot2.png", width = 960, height = 480)
dev.off()

