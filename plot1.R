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
# Now add all values under Emissions for each year in NEI
#
PM25ByYear <- with(NEI, tapply(Emissions, year, sum, na.rm=T))
#
# This should have the total emissions by year
# Now plot the totals for each year
#
png("plot1.png")
plot(names(PM25ByYear), PM25ByYear, type="l",
     xlab="Year", ylab=expression("Total Emissions (Tons)"),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()