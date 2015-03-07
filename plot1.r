#plot1.R constructs the plot1.png 
library(dplyr)
library(datasets)
#read in the data
data <- read.csv("household_power_consumption.txt", sep=";", colClasses=c("character","character",rep("numeric", 7)), na.strings="?")

#filter out data for all days besides the first two days of February, 2007
filteredData<-filter(data,  Date == "1/2/2007" | Date == "2/2/2007")

#Combine the date and time fields
dateTime<- strptime(paste(filteredData$Date,filteredData$Time, sep= " "), format = "%d/%m/%Y %H:%M:%S")
newdata<-cbind(dateTime,select(filteredData,3:9))

#clean up environment
rm(data)
rm(filteredData)
rm(dateTime)

#standard historigram
png("plot1.png", width = 480, height = 480)
with(newdata, {  hist(newdata$Global_active_power,  main = "Global Active Power",col="red",xlab = "Global Active Power (kilowatts)")})
dev.off()