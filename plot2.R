# Project 2
#setwd("C:\\R\\ExploratoryDataAnalysis\\Project2")
#
# Read in the data files if they have not already been read
#
if (!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
  }

if (!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
  }
#
# Now add all values under Emissions for Baltimmore for each year in NEI
# (Baltimore is fips == "24510")
#
BaltimoreData <- subset(NEI, fips == "24510")
BaltimorePM25DataByYear <- with(BaltimoreData, tapply(Emissions, year, sum, rm.na=T))
#
# Next, create a plot and save it as plot2.png
#
png("plot2.png")
plot(names(BaltimorePM25DataByYear), BaltimorePM25DataByYear, type="l",
     xlab="Year", ylab=expression("Total Emissions (Tons)"),
     main=expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
