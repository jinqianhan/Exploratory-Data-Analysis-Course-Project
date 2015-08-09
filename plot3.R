library(lubridate)
library(dplyr)

## read in data

data <- read.table("./household_power_consumption.txt", header = TRUE, sep=";")

## subset out data
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

##create a date + time column

x<-data$Date
y<-data$Time

pastetime <- function(a,b) {
    datime <- character(length(a))
    for (i in 1:length(a)) {
        datime[i] <- paste(a[i], b[i])
    }
    datime
}

##add date time column to data,
z<- pastetime(x,y)
tc=strptime(z, format = "%d/%m/%Y %H:%M:%S")
dat <- cbind(data,tc)

## convert graphs to numeric from factors
dat<- mutate(dat, sub1 = as.numeric(as.character(dat$Sub_metering_1)))
dat<- mutate(dat, sub2 = as.numeric(as.character(dat$Sub_metering_2)))
dat<- mutate(dat, sub3 = as.numeric(as.character(dat$Sub_metering_3)))

##plot initial graphs
plot(dat$tc, dat$sub1, type="l", col="black", ylab = "Energy sub metering", xlab="")
lines(dat$tc, dat$sub2, type="l", col="red")
lines(dat$tc, dat$sub3, type="l", col="blue")
##add legend
legend("topright", lty=1, col = c("black", "red", "blue"), legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##convert to png
dev.copy(png, file = "plot3.png")
dev.off()
