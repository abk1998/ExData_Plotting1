#Reading the data
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

#Preventing Scientific Notation
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Making a POSIXct date capable of being filtered and graphed by time of day
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Subsetting the Data according to given period
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

#Creating the plot
plot(x = data[, dateTime], y = data[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Saving the plot
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
