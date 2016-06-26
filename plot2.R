
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

png("plot2.png", width=480, height=480)
plot(hpc_data_subset$DateTime, hpc_data_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
