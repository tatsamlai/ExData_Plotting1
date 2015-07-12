# Read the data
allData = read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

# Only get the data from the dates 2007-02-01 and 2007-02-02
subData = subset(allData, Date == "1/2/2007" | Date == "2/2/2007")

# Convert the Date and Time variables to DateTime variable
subData$datetime = paste(subData$Date, subData$Time)
subData$datetime = strptime(subData$datetime, "%d/%m/%Y %H:%M:%S")

# Convert the variables to numeric
subData$Global_active_power = as.numeric(subData$Global_active_power)
subData$Global_reactive_power = as.numeric(subData$Global_reactive_power)
subData$Voltage = as.numeric(subData$Voltage)
subData$Global_intensity = as.numeric(subData$Global_intensity)
subData$Sub_metering_1 = as.numeric(subData$Sub_metering_1)
subData$Sub_metering_2 = as.numeric(subData$Sub_metering_2)
subData$Sub_metering_3 = as.numeric(subData$Sub_metering_3)

# Open the PNG device
png("plot1.png")

# Set up only 1 plots
par(mfrow = c(1, 1))

# Plot the graph
with(subData, hist(Global_active_power,
	col = "red",
	main = "Global Active Power",
	xlab = "Global Active Power (kilowatts)",
	))

# Close the device
dev.off()