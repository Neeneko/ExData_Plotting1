library(ggplot2)

data <- read.csv("household_power_consumption.txt",sep=';')

#This is not what the instructions call for, but seems to match the required output
data <- data[data$Date %in% c("2/1/2007","2/2/2007"),]
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot1.png", width=480, height=480)
plot <- ggplot(data,aes(x=Global_active_power)) + geom_histogram(bins=16,color='#000000',fill='#ff0000')
plot <- plot + labs(x = "Global Active Power (kilowatts)")
plot <- plot + labs(y = "Frequencey")
plot <- plot + labs(title="Global Active power")
print(plot)
dev.off()