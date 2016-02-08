# Prepare data for plotting graphs:

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

#Convert to numeric data
selectdata$Global_active_power <- as.numeric(selectdata$Global_active_power)
selectdata$Sub_metering_1 <- as.numeric(selectdata$Sub_metering_1)
selectdata$Sub_metering_2 <- as.numeric(selectdata$Sub_metering_2)
selectdata$Sub_metering_3 <- as.numeric(selectdata$Sub_metering_3)
selectdata$Global_reactive_power <- as.numeric(selectdata$Global_reactive_power)
selectdata$Voltage <- as.numeric(selectdata$Voltage)

#Add Datetime Column
selectdata$DateTime<- strptime(paste(as.character(selectdata$Date),selectdata$Time), "%Y-%m-%d %H:%M:%S")

