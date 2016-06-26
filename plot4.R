
## setwd() to location with data

hpc_data <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = F, header = T)

head(hpc_data)
dim(hpc_data)
str(hpc_data)

hpc_data$Date2 <- as.Date(hpc_data$Date, "%d/%m/%Y")
hpc_data$DateTime <- strptime(paste(hpc_data$Date,hpc_data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

hpc_data_subset <- hpc_data[hpc_data$Date2 >= as.Date("2007-02-01") & 
                                  hpc_data$Date2 <= as.Date("2007-02-02"), ] 

hpc_data_subset$Global_active_power <- as.numeric(hpc_data_subset$Global_active_power)
hpc_data_subset$Global_reactive_power <- as.numeric(hpc_data_subset$Global_reactive_power)
hpc_data_subset$Voltage <- as.numeric(hpc_data_subset$Voltage)
hpc_data_subset$Sub_metering_1 <- as.numeric(hpc_data_subset$Sub_metering_1)
hpc_data_subset$Sub_metering_2 <- as.numeric(hpc_data_subset$Sub_metering_2)
hpc_data_subset$Sub_metering_3 <- as.numeric(hpc_data_subset$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

##Top Left
plot(hpc_data_subset$DateTime, hpc_data_subset$Global_active_power, type="l", 
      xlab="", ylab="Global Active Power")

##Top Right
plot(hpc_data_subset$DateTime, hpc_data_subset$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

##Bottom Left
plot(hpc_data_subset$DateTime, hpc_data_subset$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(hpc_data_subset$DateTime, hpc_data_subset$Sub_metering_1, type="l")
lines(hpc_data_subset$DateTime, hpc_data_subset$Sub_metering_2, type="l", col="red")
lines(hpc_data_subset$DateTime, hpc_data_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

##Bottom Right
plot(hpc_data_subset$DateTime, hpc_data_subset$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")


dev.off()

