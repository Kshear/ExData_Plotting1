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

##SubSetDates$DateTime <- strptime(paste(SubSetDates$Date, SubSetDates$Time), format="%d/%m/%Y %H:%M:%S")

datetime<- paste(SubSetDates$Date,SubSetDates$Time)

str(datetime)

dt2 <- data.frame(cbind(SubSetDates, datetime))

str(dt2)

dt2$datetime<-as.POSIXct(dt2$datetime)


##setfile type
png(filename="plot1.png",width=480, height=480)

#plot function

plot(x=dt2$datetime, y=dt2$Global_active_power, type = 'l', xlab='',ylab = 'Global Active Power (kilowatts)')

dev.off()