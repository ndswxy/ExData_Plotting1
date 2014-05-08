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
png(file="plot1.png", width = 480, height = 480, units = "px")
hist(data[,3], xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="red")
dev.off()


