library(ggplot2)

data <- read.csv("household_power_consumption.txt",sep=';')
data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
data$Global_active_power <- as.numeric(data$Global_active_power)
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))
data$Date <- as.Date(data$Date,"%d/%m/%Y")

png("plot2.png", width=480, height=480)
plot <- ggplot(data,aes(y=Global_active_power,x=DateTime)) + geom_line()
plot <- plot + scale_x_datetime(date_labels = "%a",date_breaks="1 day")
plot <- plot + labs(y = "Global Active Power (kilowatts)")
plot <- plot + labs(x = "")
print(plot)
dev.off()