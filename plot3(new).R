
## Course Project 2.3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

## Before run 
## Use 
##      setwd("C:\\Class_Training\\Data Science\\4. Exploratory Data Analysis\\CourseProject2") 
## to set the current working directory 
##  
## Assume
## (1) Folder "exdata_data_NEI_data" is the sub-folder in current working directory
## (2) File "summarySCC_PM25.rds" is inside the sub-folder "exdata_data_NEI_data" 
##

library(ggplot2)
        
## Read data from RDS file
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
        
## get the subset for Baltimore City, Maryland (fips == "24510") 
sub <- NEI[as.character(NEI$fips)=="24510", ]
        
## use aggregate() to split the data
alltypedata <- aggregate(Emissions ~ year + type, data=sub, sum)

## add factors to "Year" and "Type" variables
alltypedata$year<-factor(alltypedata$year)
alltypedata$type <- factor(alltypedata$type)
        
## Use ggplot() to plot the diagram
## from graph, "nonpoint", "on-road", "non-road" decreases
## "point" increases from 1999 to 2005 and then decrease in 2008 but still higher than 1999
g<-ggplot(alltypedata, aes(year, Emissions))
g + facet_grid(. ~ type) + geom_point() + labs(x="Year 1999-2008") + labs(y="Total PM2.5 Emission") + labs(title="Baltimore PM2.5 Emission Plot")
        
## write to PNG file and close PNG device
dev.copy(png, file="plot3.png",width = 580, height = 480)
dev.off()

