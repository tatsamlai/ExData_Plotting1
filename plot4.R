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
png("plot4.png")

# Set up 2X2 plots
par(mfrow = c(2, 2))

# Plot graph 1
with(subData, plot(datetime,Global_active_power,
	ylab = "Global Active Power",
	xlab = "",
	type = "n"
	))
with(subData, lines(datetime,Global_active_power))

# Plot graph 2
with(subData, plot(datetime,Voltage,
	ylab = "Voltage",
	type = "n",
	))
with(subData, lines(datetime,Voltage))

# Plot graph 3
with(subData, plot(datetime, Sub_metering_1,
	type = "n",
	xlab = "",
	ylab = "Energy sub metering",
	))
with(subData, lines(datetime, Sub_metering_1, col = "black"))
with(subData, lines(datetime, Sub_metering_2, col = "red"))
with(subData, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", bty = "n", lty = "solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Plot graph 4
with(subData, plot(datetime,Global_reactive_power,
	ylab = "Global_reactive_power",
	type = "n",
	))
with(subData, lines(datetime,Global_reactive_power))

# Close the device
dev.off()