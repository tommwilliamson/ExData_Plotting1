library(data.table)
# Load the data
all_data <- fread('household_power_consumption.txt')
# Select just the data from 2007-02-01 and 2007-02-02
sub_data <- all_data[all_data$Date %in% "1/2/2007" | all_data$Date %in% "2/2/2007"]
gsub("?",NA,sub_data, fixed = TRUE)

# Create date/time variable
dateTime <- paste(sub_data$Date,sub_data$Time)
dateTime <- strptime(dateTime,"%d/%m/%Y %H:%M:%S")

# Create the first graph
png(filename="plot1.png",width = 480, height = 480)
par(bg=NA)
hist(as.numeric(sub_data$Global_active_power),col="red",main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", cex.lab=0.9, cex.axis=0.9)
dev.off()


# Create the second graph
png(filename="plot2.png",width = 480, height = 480)
par(bg=NA)
plot(dateTime,as.numeric(sub_data$Global_active_power), type='l',
     xlab="",  ylab="Global Active Power (kilowatts)")
dev.off()



# Create the third graph
png(filename="plot3.png",width = 480, height = 480)
par(bg=NA)
plot(dateTime,as.numeric(sub_data$Sub_metering_1),
     xlab="",  ylab="Energy sub metering",type='n')
points(dateTime,as.numeric(sub_data$Sub_metering_1), type='l',
     xlab="",  ylab="Energy sub metering")
points(dateTime, as.numeric(sub_data$Sub_metering_2), col="red", type='l')
points(dateTime, as.numeric(sub_data$Sub_metering_3), col="blue", type='l')
legend("topright", legend = names(sub_data)[grep('Sub_metering',names(sub_data))],
       col=c("Black","Red","Blue"),lty=1)
dev.off()



# Create the last graph
png(filename="plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
par(bg=NA)

plot(dateTime,as.numeric(sub_data$Global_active_power), type='l',
     xlab="",  ylab="Global Active Power (kilowatts)")

plot(dateTime,as.numeric(sub_data$Voltage), type='l',
     xlab="datetime",  ylab="Voltage")

plot(dateTime,as.numeric(sub_data$Sub_metering_1), type='n',
     xlab="",  ylab="Energy sub metering")
points(dateTime,as.numeric(sub_data$Sub_metering_1), type='l')
points(dateTime, as.numeric(sub_data$Sub_metering_2), col="red", type='l')
points(dateTime, as.numeric(sub_data$Sub_metering_3), col="blue", type='l')
legend("topright", legend = names(sub_data)[grep('Sub_metering',names(sub_data))],
       col=c("Black","Red","Blue"),lty=1,bty='n')

plot(dateTime,as.numeric(sub_data$Global_reactive_power), type='l',
     xlab="datetime",  ylab="global_reactive_power")
par(mfrow=c(1,1))
dev.off()

