## Read data into data.frame myTable
myTable <- read.table("household_power_consumption.txt", 
                header = TRUE, sep = ";", colClasses = c(rep("character", 2), 
                rep("numeric", 7)), na.strings = "?")

## Filter by the dates of interest
myMinDate <- strptime("2007-02-01 00:00", format = "%Y-%m-%d %H:%M")
myMaxDate <- strptime("2007-02-02 23:59", format = "%Y-%m-%d %H:%M")
myTable <- myTable[complete.cases(myTable), ]
dateTimeStr <- paste(myTable$Date, myTable$Time, sep = " ")
dateTimePosixlt <- strptime(dateTimeStr, format = "%d/%m/%Y %H:%M:%S")
myTable <- cbind(myTable, dateTimePosixlt)
myTable$Date <- NULL
myTable$Time <- NULL
myTable <- myTable[myTable$dateTimePosixlt >= myMinDate & 
                        myTable$dateTimePosixlt <= myMaxDate, ]

## Generate 2x2 plot showing 
par(mfrow = c(2, 2), mar = c(5, 4, 2, 2), ps = 10)    # Row-major placement of graphs
with(myTable, plot(dateTimePosixlt, Global_active_power, type = "l", 
lty = 1, xlab = "", ylab = "Global Active Power (kilowatts)"))
with(myTable, plot(dateTimePosixlt, Voltage, type = "l", 
lty = 1, xlab = "datetime"))
with(myTable, plot(dateTimePosixlt, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(myTable, lines(dateTimePosixlt, Sub_metering_1, lty = 1, col = "black"))
with(myTable, lines(dateTimePosixlt, Sub_metering_2, lty = 1, col = "red"))
with(myTable, lines(dateTimePosixlt, Sub_metering_3, lty = 1, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n")
with(myTable, plot(dateTimePosixlt, Global_reactive_power, type = "l", 
lty = 1, xlab = "datetime"))

## Copy the figure to file
dev.copy(png, file = "plot4.png") # Copy plot to a PNG file
dev.off()