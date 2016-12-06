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


## Generate line plot showing global active power across time
# with(myTable, plot(dateTimePosixlt, Global_active_power, type = "l", 
# lty = 1, xlab = NULL, ylab = "Global Active Power (kilowatts)")) # Can't get rid of the x label
with(myTable, plot(dateTimePosixlt, Global_active_power, type = "l", 
lty = 1, xlab = "", ylab = "Global Active Power (kilowatts)"))

## Copy the figure to file
dev.copy(png, file = "plot2.png") # Copy plot to a PNG file
dev.off()