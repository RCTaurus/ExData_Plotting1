if (!exists("selectdata"))
{
  # Download the Zip file from repository
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", paste0(getwd(),"./coursemat.zip"))
  
  #Unzip the file to Coursemat folder
  unzip("coursemat.zip",overwrite=TRUE, exdir = "./coursemat")
  
  #Read the file from the extracted folder
  if (!exists(powercon)){powerconfull <- read.delim("./coursemat/household_power_consumption.txt", sep = ";", as.is = TRUE)}
  
  #Convert the Date format:
  powerconfull$Date <- as.Date(powerconfull$Date, "%d/%m/%Y")
  
  #Select the data for relevant dates only
  selectdata <- powerconfull[powerconfull$Date=="2007-02-01" | powerconfull$Date=="2007-02-02",]
  
  # convert to numeric data
  selectdata$Global_active_power <- as.numeric(selectdata$Global_active_power)
  selectdata$Sub_metering_1 <- as.numeric(selectdata$Sub_metering_1)
  selectdata$Sub_metering_2 <- as.numeric(selectdata$Sub_metering_2)
  selectdata$Sub_metering_3 <- as.numeric(selectdata$Sub_metering_3)
  selectdata$Global_reactive_power <- as.numeric(selectdata$Global_reactive_power)
  selectdata$Voltage <- as.numeric(selectdata$Voltage)
  
  #Add Datetime Column
  selectdata$DateTime<- strptime(paste(as.character(selectdata$Date),selectdata$Time), "%Y-%m-%d %H:%M:%S")
}


# Open file for Fourth graph
png(filename = "plot4.png",width = 480, height = 480)

# 2X2 graphs
par(mfrow=c(2,2))

#plot the 1,1 graph:
plot( selectdata$DateTime,selectdata$Global_active_power, type="l", ylab="Global Active Power (killowatts)", xlab="")

#plot the 2,1 graph:
plot( selectdata$DateTime,selectdata$Voltage, type="l", ylab="Voltage", xlab="datetime")


#plot the 1,2 graph:
plot( selectdata$DateTime,selectdata$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines( selectdata$DateTime,selectdata$Sub_metering_2, type="l", col="red")
lines( selectdata$DateTime,selectdata$Sub_metering_3, type="l", col="blue")

#add legends
legend(x="topright",col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1)

#plot the 2,2 graph:
plot( selectdata$DateTime,selectdata$Global_reactive_power, type="l", ylab="Global Reactive Power (killowatts)", xlab="datetime")

#close the device - plot4.png
dev.off()

