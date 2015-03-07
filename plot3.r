#plot3.R constructs the plot3.png 
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

#4 step graphic creation: 1) original plot 2+3)adding two lines for variables on same scale and 4) adding legend
png("plot3.png", width = 480, height = 480)
with(newdata, plot(dateTime, Sub_metering_1, type = "l", xlab ="",ylab = "Energy sub metering"))
with(newdata, lines(dateTime,  Sub_metering_2,col = "red"))
with(newdata, lines(dateTime,  Sub_metering_3,col = "blue"))
legend("topright", lty = 1, col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()