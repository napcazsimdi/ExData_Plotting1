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
dataWD <- split(data$Global_active_power, weekdays(data$DateTime))
#concatenate Thursday and Friday into a single variable
Gap <- c(unlist(dataWD[2]),unlist(dataWD[1]))
#PLOT
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12)
plot(1:2880, Gap, xlim = c(1,2881),
                xlab = '', ylab='Global Active Power (kilowatts)',xaxt='n',type='n')
lines(1:2880, Gap)
axis(1, at = c(1,1441,2881), labels=c('Thu','Fri','Sat'))
dev.off()
