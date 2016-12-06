## Read data into data.frame myTable
myTable <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")


## Filter by the dates of interest
myMinDate <- as.Date("2007-02-01")
myMaxDate <- as.Date("2007-02-02")
myTable$Date <- as.Date(myTable$Date, format = "%d/%m/%Y")
myTable <- myTable[complete.cases(myTable), ]
myTable <- myTable[myTable$Date >= myMinDate & myTable$Date <= myMaxDate, ]


## Generate histogram showing frequencies for various global active powers
with(myTable, hist(Global_active_power, col = "red", 
xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

## Copy the figure to file
dev.copy(png, file = "plot1.png") # Copy plot to a PNG file
dev.off()