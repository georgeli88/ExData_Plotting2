
## Course Project 2.5
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 


## Before run 
## Use 
##      setwd("C:\\Class_Training\\Data Science\\4. Exploratory Data Analysis\\CourseProject2") 
## to set the current working directory 
## 
## Assume
## (1) Folder "exdata_data_NEI_data" is the sub-folder in current working directory
## (2) File "summarySCC_PM25.rds" is inside the sub-folder "exdata_data_NEI_data" 
## (3) File "Source_Classification_Code.rds" is inside the sub-folder "exdata_data_NEI_data" 
##

## Read data from PM2.5 SCC Summary file
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

## Read data from Source Classification Code file
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

## get the motor vehicle sources
sources <- SCC[grep("vehicle", SCC$EI.Sector, value=FALSE, ignore.case=TRUE), ]
sources <- sources[, 1]

## get the subset of data from NEI from motor vehicle sources in Baltimore
sub <- NEI[NEI$SCC %in% sources & NEI$fips == "24510", ]

## get the unique number of the year
x <- unique(sub$year)

## get the total PM2.5 emission from motor vehicle sources 
y <- tapply(sub$Emissions, factor(sub$year), sum)

## Plot 2 diagrams with "dot" and "line"
plot(x, y, xlab="Year", ylab="Total PM2.5 Emission", main="Motor Vehicle Emission in Baltimore", pch=19)
lines(x,y,type="l")
        
## write to PNG file and close PNG device
dev.copy(png, file="plot5.png", width = 600, height = 480)
dev.off()

