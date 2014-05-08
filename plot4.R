firstcol <- read.csv("household_power_consumption.txt", sep=";", 
                     as.is=TRUE, na.strings= "?", 
                     colClasses = c(NA, rep("NULL", 8)))
ind <- which(firstcol[,1] %in% c("1/2/2007","2/2/2007"))

firstr <- read.csv("household_power_consumption.txt", sep=";", 
                   as.is=TRUE, nrows=1)
dataclasses <- sapply(firstr, class)
data <- read.csv("household_power_consumption.txt", sep=";", 
                 as.is=TRUE, na.strings= "?", 
                 colClasses=dataclasses,skip=min(ind)-1,
                 nrows=length(ind), col.names=names(firstr))

x <- paste(data[[1]], data[[2]])
datatrans <- transform(data, Date=as.Date(data$Date, "%d/%m/%Y"),
                       Time=strptime(x, "%d/%m/%Y %T"))

png(file="plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

with(datatrans, plot(Time,Global_active_power, type="l", xlab="", 
                     ylab="Global Active Power"))
with(datatrans, plot(Time, Voltage, type="l", xlab="datetime"))

with(datatrans, plot(Time, Sub_metering_1, type="l", 
                     ylab="Energy sub metering", xlab=""))
with(datatrans, lines(Time, Sub_metering_2, col="red"))
with(datatrans, lines(Time, Sub_metering_3, col="blue"))
legend("topright", legend=names(datatrans)[7:9], col=c("black","red","blue"), 
       lty = rep(1,3), bty="n")

with(datatrans, plot(Time, Global_reactive_power, type="l", xlab="datetime"))

dev.off()

