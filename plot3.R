#place the household_power_consumption.txt into your working directory

#read the headers first
header <- read.table('household_power_consumption.txt', nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
#read the necessary rows, that is February 1st and 2nd, 2007
data <- read.table("household_power_consumption.txt", 
               skip=66636, nrows = 2880, sep=";", header = T, check.names = F, na.strings ="?")
#plug the headers back
colnames(data) <- unlist(header)
#create a new column with Date/Time info
data$DateTime <- strptime(paste(data$Date,data$Time),format='%d/%m/%Y %H:%M:%S')
#split according to day of the week
dataWD1 <- split(data$Sub_metering_1, weekdays(data$DateTime))
dataWD2 <- split(data$Sub_metering_2, weekdays(data$DateTime))
dataWD3 <- split(data$Sub_metering_3, weekdays(data$DateTime))
#concatenate Thursday and Friday into a single variable
SM1 <- c(unlist(dataWD1[2]),unlist(dataWD1[1]))
SM2 <- c(unlist(dataWD2[2]),unlist(dataWD2[1]))
SM3 <- c(unlist(dataWD3[2]),unlist(dataWD3[1]))
#PLOT
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12)
plot(1:2880, SM1, xlim = c(1,2881),
                xlab = '', ylab='Energy sub metering',xaxt='n',type='n')
lines(1:2880, SM1)
lines(1:2880, SM2, col = 'red')
lines(1:2880, SM3, col = 'blue')
axis(1, at = c(1,1441,2881), labels=c('Thu','Fri','Sat'))
legend('topright', lty = c(1,1,1), col = c('black','red','blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()
