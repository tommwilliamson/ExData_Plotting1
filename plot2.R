library(data.table)
# Load the data
all_data <- fread('household_power_consumption.txt')
# Select just the data from 2007-02-01 and 2007-02-02
sub_data <- all_data[all_data$Date %in% "1/2/2007" | all_data$Date %in% "2/2/2007"]
gsub("?",NA,sub_data, fixed = TRUE)

# Create date/time variable
dateTime <- paste(sub_data$Date,sub_data$Time)
dateTime <- strptime(dateTime,"%d/%m/%Y %H:%M:%S")

# Create the second graph
png(filename="plot2.png",width = 480, height = 480)
par(bg=NA)
plot(dateTime,as.numeric(sub_data$Global_active_power), type='l',
     xlab="",  ylab="Global Active Power (kilowatts)")
dev.off()