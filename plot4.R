#Reading the data
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

#Preventing Scientific Notation
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Making a POSIXct date capable of being filtered and graphed by time of day
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Subsetting the Data according to given period
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

#Creating multiple plots
par(mfrow=c(2,2))

#Plot1
plot(data[, dateTime], data[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

#Plot2
plot(data[, dateTime],data[, Voltage], type="l", xlab="datetime", ylab="Voltage")

#Plot3
plot(data[, dateTime], data[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(data[, dateTime], data[, Sub_metering_2],col="red")
lines(data[, dateTime], data[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), bty="n", cex=.5)

#Plot4
plot(data[, dateTime], data[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

#Saving the plot
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
