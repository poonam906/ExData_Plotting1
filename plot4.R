library(sqldf)

setwd(dirname(sys.frame(1)$ofile))
getwd()

d1 <- d1 <- read.csv.sql("household_power_consumption.txt", 
                         header = TRUE, 
                         sep = ";",
                         sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")

d1[d1 == "?"] <- NA
x <- paste(d1$Date, d1$Time, sep = " ")
d1$Time <- strptime(x, format="%d/%m/%Y %H:%M:%S")
d1$Date <- as.Date(d1$Date, "%d/%m/%Y")

png(filename = 'plot4.png', width = 480, height = 480)

par('mfrow'= c(2,2))

#PLOT 1 
plot(d1$Time, d1$Global_active_power, type = 'l', ylab = "Global Active Power", xlab="")

# PLOT 2
plot(d1$Time, d1$Voltage, type = 'l', ylab = "Voltage", xlab="datetime")

# PLOT 3
plot(d1$Time, d1$Sub_metering_1, type = 'l', ylab = "Energy sub metering", xlab="", col = 'black')
lines(d1$Time, d1$Sub_metering_2, col = 'red')
lines(d1$Time, d1$Sub_metering_3, col = 'blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', 'red', 'blue'), lty=c(1,1,1))

# PLOT 4
plot(d1$Time, d1$Global_reactive_power, type = 'l', ylab = "Global_reactive_power", xlab="datetime")

dev.off()
