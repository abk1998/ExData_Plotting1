#Reading the data
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

#Converting the date variable to a data class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Subsetting the Data according to given period
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#Creating the plot
hist(data$Global_active_power , main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red")

#Saving the plot
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
