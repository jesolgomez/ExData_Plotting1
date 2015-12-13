## Create a temporary file. Download file from internet as temp.
temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, temp, mode="wb")

## Read proper txt file from zipped temp. Delete temp.
data1 <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink(temp)

## Subset the dataframe.
## sapply(data1, class)
data1$Date <- as.character(data1$Date)
data2 <- subset(data1, Date=="1/2/2007" | Date=="2/2/2007")
rownames(data2) <- NULL

## Transform variables
data2$Date <- strptime(paste(data2$Date, data2$Time), "%d/%m/%Y %H:%M:%S")
cols = c(3:8)
data2[,cols] = apply(data2[,cols], 2, function(x) as.numeric(x))
## sapply(data2, class)

## Make plot
png(file = "plot4.png")
par(mfrow=c(2,2))
plot(data2$Date, data2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(data2$Date, data2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(data2$Date, data2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data2$Date, data2$Sub_metering_2, col = "red")
lines(data2$Date, data2$Sub_metering_3, col = "blue")
legend("topright", bty = "n", lty=c(1,1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot (data2$Date, data2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()