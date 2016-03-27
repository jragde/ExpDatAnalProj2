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
# Segment data for Baltimmore City for each year in NEI
# (Baltimore is fips == "24510")
#
BaltimoreData <- subset(NEI, fips == "24510")
#
# Next, create a plot using ggplot2 and save it as plot3.png
#
png("plot3.png",width=600,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(BaltimoreData,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

dev.off()
