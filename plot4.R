## Getting full dataset
data_full <- read.csv("C:/Users/Mitch/Documents/DataScience/exdata-data-household_power_consumption/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 4
par(mfrow = c(2,2))
par(mar = c(4,4,2,2))
with(data, {
        plot(Datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot(Datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        with(data, {
                plot(Sub_metering_1~Datetime, type="l",
                     ylab="Energy sub metering", xlab="")
                lines(Sub_metering_2~Datetime,col='Red')
                lines(Sub_metering_3~Datetime,col='Blue')
        })
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Datetime, Global_reactive_power, type = "l", xlab = "datetime")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()