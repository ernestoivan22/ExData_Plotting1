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

#open the device
png("plot4.png", width=480, height=480)
#specify that we need two rows and two columns for the graphs
par(mfrow=c(2,2))

#First plot
power_consumption$Global_active_power <- as.numeric(as.character(power_consumption$Global_active_power))
dateTime <- strptime(paste(power_consumption$Date, power_consumption$Time, sep=" "), "%e/%m/%Y %H:%M:%S")
plot(dateTime, power_consumption$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")


#Second plot
power_consumption$Voltage <- as.numeric(as.character(power_consumption$Voltage))
plot(dateTime, power_consumption$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")


#Third plot
power_consumption$Sub_metering_1 <- as.numeric(as.character(power_consumption$Sub_metering_1))
power_consumption$Sub_metering_2 <- as.numeric(as.character(power_consumption$Sub_metering_2))
power_consumption$Sub_metering_3 <- as.numeric(as.character(power_consumption$Sub_metering_3))

plot(dateTime, power_consumption$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab="")
points(dateTime, power_consumption$Sub_metering_1, type = "l")
points(dateTime, power_consumption$Sub_metering_2, type = "l", col = "red")
points(dateTime, power_consumption$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), bty = "n")

#Forth plot
Global_active_power <- as.numeric(as.character(power_consumption$Global_reactive_power))
plot(dateTime, Global_active_power, xlab = "datetime", type = "l")

#close the device
dev.off()