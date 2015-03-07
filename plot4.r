
#plot4.R constructs the plot4.png 
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

#Four plots examining the dataset from a variety of angles
png("plot4.png", width = 480, height = 480)
#this command sets up the format table of plots - a table of 2 columns and 2 rows
par(mfrow = c(2, 2))
with(newdata,{
  #plot 1
  plot(newdata$dateTime,  newdata$Global_active_power, type = "l", xlab ="",ylab = "Global Active Power")
  #plot 2
  plot(newdata$dateTime,  newdata$Voltage, type = "l", xlab ="datetime",ylab = "Voltage")
  #plot 3
  plot(dateTime, Sub_metering_1, type = "l", xlab ="",ylab = "Energy sub metering")
  lines(dateTime,  Sub_metering_2,col = "red")
  lines(dateTime,  Sub_metering_3,col = "blue")
  legend("topright", lty = 1, bty="n", col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  #plot 4
  plot(newdata$dateTime,  newdata$Global_reactive_power, type = "l", xlab ="datetime",ylab = "global_reactive_power")
})
dev.off()
