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

#convert the column that we need to numeric
power_consumption$Global_active_power <- as.numeric(as.character(power_consumption$Global_active_power))

#open de device and plot the graphic
png("plot1.png", width=480, height=480)
hist(power_consumption$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
#close the device
dev.off()
