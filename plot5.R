# Project 2

library(ggplot2)


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
# Subset all data with 'Vehicles' by first finding
# all entries containing 'vehicle' in SCC and then
# getting corresponding SCC values in NEI.
#
containsVehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = FALSE)
containsVehiclesInSCC <- SCC[vehicles,]$SCC
vehicleRelatedData <- NEI[NEI$SCC %in% containsVehiclesInSCC,]
#
# Now pull out only data for Baltimore city
#
baltimoreVehicles <- vehicleRelatedData[vehicleRelatedData$fips == "24510",]
#
# Now create a plot and save it as plot5.png
#
png("plot5.png",width=600,height=480,units="px",bg="transparent")

ggp <- ggplot(baltimoreVehicles,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="green",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Vehicle Emissions in Baltimore from 1999-2008"))

print(ggp)

dev.off()