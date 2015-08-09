## read in data
data <- read.table("./household_power_consumption.txt", header = TRUE, sep=";")

## subset out data
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

##make histogram of global active power, must convert from factor to numeric
grp <- as.numeric(as.character(data$Global_active_power))
hist(grp, main = "Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()
