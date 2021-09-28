library(ggplot2)
library(gridExtra)

data <- read.csv("household_power_consumption.txt",sep=';')
data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))


png("plot4.png", width=480, height=480)
plot1 <- ggplot(data,aes(y=Global_active_power,x=DateTime)) + geom_line()
plot1 <- plot1 + scale_x_datetime(date_labels = "%a",date_breaks="1 day")
plot1 <- plot1 + labs(y = "Global Active Power")
plot1 <- plot1 + labs(x = "")
plot1 <- plot1 + theme(axis.text.y = element_text(angle = 90))

plot2 <- ggplot(data,aes(y=Voltage,x=DateTime)) + geom_line()
plot2 <- plot2 + scale_x_datetime(date_labels = "%a",date_breaks="1 day")
plot2 <- plot2 + labs(y = "Voltage")
plot2 <- plot2 + labs(x = "datetime")
plot2 <- plot2 + theme(axis.text.y = element_text(angle = 90))


plot3 <- ggplot(data,aes(x=DateTime))
plot3 <- plot3 + geom_line(aes(y=Sub_metering_1,color='Sub_metering_1'))
plot3 <- plot3 + geom_line(aes(y=Sub_metering_2,color='Sub_metering_2'))
plot3 <- plot3 + geom_line(aes(y=Sub_metering_3,color='Sub_metering_3'))
plot3 <- plot3 + scale_color_manual(name=NULL,values=c(
  "Sub_metering_1" = '#000000',
  "Sub_metering_2" = '#FF0000',
  "Sub_metering_3" = '#0000FF'
))
plot3 <- plot3 + scale_x_datetime(date_labels = "%a",date_breaks="1 day")
plot3 <- plot3 + labs(y = "Energy sub metering")
plot3 <- plot3 + labs(x = "")
plot3 <- plot3 + theme(legend.position=c(0.8,0.8))
plot3 <- plot3 + theme(legend.text=element_text(size=6))
plot3 <- plot3 + theme(axis.text.y = element_text(angle = 90))


plot4 <- ggplot(data,aes(y=Global_active_power,x=DateTime)) + geom_line()
plot4 <- plot4 + scale_x_datetime(date_labels = "%a",date_breaks="1 day")
plot4 <- plot4 + theme(axis.text.y = element_text(angle = 90))

grid <- grid.arrange(plot1,plot2,plot3,plot4,nrow=2)

print(grid)
dev.off()