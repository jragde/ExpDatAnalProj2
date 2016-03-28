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
# Get all coal related codes from SCC.  Since
#
combustionCodes <- grepl("combustion", SCC$SCC.Level.One, ignore.case=TRUE)
coalCodes <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustionCodes <- (combustionRelated & coalRelated)
#
# 'Subset' coal combustion related data
#
coalCombstionCombinations <- SCC[coalCombustionCodes,]$SCC
coalCombustionInData <- NEI[NEI$SCC %in% coalCombstionCombinations,]
#
# Next, create a plot using ggplot2 and save it as plot4.png
#
png("plot4.png",width=600,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(coalCombustionInData,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Related Emissions Across US from 1999-2008"))

print(ggp)

dev.off()
