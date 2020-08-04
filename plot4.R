library(lubridate)
library(data.table)
library(dplyr)

##Reading in file
power<- read.table(file="household_power_consumption.txt", header=T, sep=";", stringsAsFactors=F, dec=".", na.strings="?")

## (creates issue with col classes) power<- read.table(file="household_power_consumption.txt", header=T, sep=";", dec=".", na.strings="?")

#Checking strcture of data
str(power)

#(Not working still get NAs)subSETdata <- filter(power, (Date="1-2-2007") & (Date="2-2-2007"))

#transforming class of "Date" variable from character to date
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

#checking that transformation was successful
str(power)

#filtering dates
SubSetDates <- filter(power, (Date=="2007-2-1") | (Date=="2007-2-2"))

#creates new variable that combines date and time variables
datetime<- paste(SubSetDates$Date,SubSetDates$Time)

str(datetime)

#binds new variable to data frame
dt2 <- data.frame(cbind(SubSetDates, datetime))

str(dt2)

#need to set variable class to work with the graph
dt2$datetime<-as.POSIXct(dt2$datetime)


##setfile type
png(filename="plot4.png",width=480, height=480)

#set up for multiple plots
par(mfrow=c(2,2))

#plot function using base, then layers on additional elements

#first plot
plot(x=dt2$datetime, y=dt2$Global_active_power, type = 'l', xlab='', ylab = 'Global Active Power', col="black")

#second plot
plot(x=dt2$datetime, y=dt2$Voltage, type = 'l', xlab='datetime', ylab = 'Voltage', col="black")
#third plot
plot(x=dt2$datetime, y=dt2$Sub_metering_1, type = 'l', xlab='', ylab = 'Energy sub metering', col="black")

lines(x=dt2$datetime, y=dt2$Sub_metering_2, type = 'l', xlab='', ylab = 'Energy sub metering', col="red")

lines(x=dt2$datetime, y=dt2$Sub_metering_3, type = 'l', xlab='', ylab = 'Energy sub metering', col="blue")

legend("topright", lty = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#plot4
plot(x=dt2$datetime, y=dt2$Global_reactive_power, type = 'l', xlab='datetime', ylab = 'Global_reactive_power', col="black")

dev.off()