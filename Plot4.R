db = read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

db$DateTime <- paste(db$Date,db$Time, sep = ":")
db$DateTime = strptime(db$DateTime,format="%d/%m/%Y:%H:%M:%S")

db$Date <- as.Date(db$Date, format="%d/%m/%Y")


dbn <- subset(db, db$Date == "2007/02/01" | db$Date == "2007/02/02")

dbn$Global_active_power[dbn$Global_active_power=="?"] <- NA
dbn$Global_reactive_power[dbn$Global_reactive_power=="?"] <- NA
dbn$Sub_metering_1[dbn$Sub_metering_1=="?"] <- NA
dbn$Sub_metering_2[dbn$Sub_metering_2=="?"] <- NA
dbn$Sub_metering_3[dbn$Sub_metering_3=="?"] <- NA
dbn$Voltage[dbn$Voltage=="?"] <- NA
dbn$Global_intensity[dbn$Global_intensity=="?"] <- NA
dbn$Global_intensity <- gsub(",", "", dbn$Global_intensity)
dbn$Global_active_power <- gsub(",", "", dbn$Global_active_power)
dbn$Global_reactive_power <- gsub(",", "", dbn$Global_reactive_power)
dbn$Voltage <- gsub(",", "", dbn$Voltage)
dbn$Sub_metering_1 <- gsub(",", "", dbn$Sub_metering_1)
dbn$Sub_metering_2 <- gsub(",", "", dbn$Sub_metering_2)
dbn$Sub_metering_3 <- gsub(",", "", dbn$Sub_metering_3)
dbn$Global_intensity <- as.numeric(dbn$Global_intensity)
dbn$Global_active_power <- as.numeric(dbn$Global_active_power)
dbn$Global_reactive_power <- as.numeric(dbn$Global_reactive_power)
dbn$Voltage <- as.numeric(dbn$Voltage)
dbn$Sub_metering_1 <- as.numeric(dbn$Sub_metering_1)
dbn$Sub_metering_2 <- as.numeric(dbn$Sub_metering_2)
dbn$Sub_metering_3 <- as.numeric(dbn$Sub_metering_3)

par(mfrow=c(2,2))

plot(dbn$DateTime,dbn$Global_active_power,type="l", ylab="Global Active Power", xlab="")

plot(dbn$DateTime,dbn$Voltage,type="l", ylab="Voltage", xlab="datetime")

plot(dbn$DateTime,dbn$Sub_metering_1,type="l", col="red", ylab="Energy sub metering", xlab="")
lines(dbn$DateTime,dbn$Sub_metering_2,type="l", col="green")
lines(dbn$DateTime,dbn$Sub_metering_3,type="l", col="blue")
legend("top", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", lty=1, col=c("red", "green", "blue"))


plot(dbn$DateTime,dbn$Global_reactive_power,type="l", ylab="Global_reactive_power", xlab="datetime")

dev.copy(png,'plot4.png')
dev.off()
