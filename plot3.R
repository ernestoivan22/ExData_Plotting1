# verify if the files to be used exist, if not it'll be downloaded
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")){
  if(!file.exists("household_power_consumption.zip")){
    download.file(fileUrl, destfile = "household_power_consumption.zip")
  }
  unzip("household_power_consumption.zip", exdir = ".")
}

#load the raw data and subset the rows that we need
raw_power_consumption <- read.csv("household_power_consumption.txt", sep=";")
power_consumption <- raw_power_consumption[raw_power_consumption$Date == "1/2/2007" 
                                           | raw_power_consumption$Date == "2/2/2007",]

#convert the columns that we need to numeric and merge data and time to get datetime
power_consumption$Sub_metering_1 <- as.numeric(as.character(power_consumption$Sub_metering_1))
power_consumption$Sub_metering_2 <- as.numeric(as.character(power_consumption$Sub_metering_2))
power_consumption$Sub_metering_3 <- as.numeric(as.character(power_consumption$Sub_metering_3))
dateTime <- strptime(paste(power_consumption$Date, power_consumption$Time, sep=" "), "%e/%m/%Y %H:%M:%S") 

#Open the device 
png("plot3.png", width=480, height=480)
#First initialize the graph without points
plot(dateTime, power_consumption$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab="")
#plot every column of interest
points(dateTime, power_consumption$Sub_metering_1, type = "l")
points(dateTime, power_consumption$Sub_metering_2, type = "l", col = "red")
points(dateTime, power_consumption$Sub_metering_3, type = "l", col = "blue")
#add the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))
#close the device
dev.off()