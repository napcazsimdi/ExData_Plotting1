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
#PLOT
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12)
with(data, hist(Global_active_power, col = 'red', 
                xlab = 'Global Active Power (kilowatts)', ylab='Frequency',
                main = 'Global Active Power'))
dev.off()
