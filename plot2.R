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

##create plot, create new row for kilowatts
z<- pastetime(x,y)
tc=strptime(z, format = "%d/%m/%Y %H:%M:%S")
dat <- cbind(data,tc)
dat <- mutate(dat, kwatt= as.numeric(dat$Global_active_power)/1000)
plot(dat$tc, dat$kwatt, type = "line", xlab = "", ylab = "Global Active Power (kilowatts)" )

##convert to png
dev.copy(png, file = "plot2.png")
dev.off()
