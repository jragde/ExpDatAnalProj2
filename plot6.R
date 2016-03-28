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
# Now pull out only data for Los Angeles County
#
LACountyVehicles <- vehicleRelatedData[vehicleRelatedData$fips == "06037",]
#
# Add a column with City so that we can identify the city associated with data
#
baltimoreVehicles$city <- "Baltimore"
LACountyVehicles$city <- "Los Angeles"
#
# Now combine the two sets of data
#
combinedData <- rbind(baltimoreVehicles, LACountyVehicles)
#
# Now create a plot and save it as plot6.png
#
png("plot6.png",width=600,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(combinedData, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore & Los Angeles - 1999-2008"))

print(ggp)

dev.off()
