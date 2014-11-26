
## Course Project 2.6
## Compare emissions from motor vehicle sources in Baltimore City with 
##         emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?


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

## (1) get the subset of data from NEI from motor vehicle sources in Baltimore 
sub <- NEI[NEI$SCC %in% sources & NEI$fips == "24510", ]
## get the unique number of the year
x <- unique(sub$year)
## get the total PM2.5 emission from motor vehicle sources 
y <- tapply(sub$Emissions, factor(sub$year), sum)
## add the emission data of Baltimore City to a dataframe
data <- data.frame(x)
data[,2] <- y

## (2) get the subset of data from NEI from motor vehicle sources in Los Angeles County
sub <- NEI[NEI$SCC %in% sources & NEI$fips == "06037", ]
## get the total PM2.5 emission from motor vehicle sources 
y <- tapply(sub$Emissions, factor(sub$year), sum)
## add the emission data of Los Angeles County to a dataframe
data[,3] <- y

## name the data frame
names(data) <- c("Year", "Baltimore", "LA.County")

## (3) Plot diagram
rng <- range(data$Baltimore, data$LA.County)
plot(data$Year, data$LA.County, type="n", ylim=rng, mar=c(4,4,2,1), ylab="Total PM2.5 Emission", xlab="Year 1999 - 2008", main="Motor Vehicle Emission Baltimore vs LA County")
points(data$Year, data$Baltimore, type="b", pch=19, col="blue") 
points(data$Year, data$LA.County, type="b", pch=19, col="red") 
legend("topleft", cex=0.8, bty="n", pch=1, col=c("blue", "red"), legend = c("Baltimore", "LA County")) 

## write to PNG file and close PNG device
dev.copy(png, file="plot6.png", width = 600, height = 480)
dev.off()


