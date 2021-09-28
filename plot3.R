library(ggplot2)

data <- read.csv("household_power_consumption.txt",sep=';')
data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot <- ggplot(data,aes(x=DateTime))
plot <- plot + geom_line(aes(y=Sub_metering_1,color='Sub_metering_1'))
plot <- plot + geom_line(aes(y=Sub_metering_2,color='Sub_metering_2'))
plot <- plot + geom_line(aes(y=Sub_metering_3,color='Sub_metering_3'))
plot <- plot + scale_color_manual(name=NULL,values=c(
  "Sub_metering_1" = '#000000',
  "Sub_metering_2" = '#FF0000',
  "Sub_metering_3" = '#0000FF'
))
plot <- plot + scale_x_datetime(date_labels = "%a",date_breaks="1 day")
plot <- plot + labs(y = "Energy sub metering")
plot <- plot + labs(x = "")
plot <- plot + theme(legend.position=c(0.8,0.8))
print(plot)
dev.off()