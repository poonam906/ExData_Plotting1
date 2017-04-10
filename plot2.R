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

png(filename = 'plot2.png', width = 480, height = 480)
plot(d1$Time, d1$Global_active_power, type = 'l', ylab = "Global Active Power (kilowatts)", xlab="")
dev.off()
