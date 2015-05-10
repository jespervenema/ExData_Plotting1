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
dbn$Global_intensity <- as.numeric(dbn$Global_intensity)
dbn$Global_active_power <- as.numeric(dbn$Global_active_power)
plot(dbn$DateTime,dbn$Global_active_power,type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,'plot2.png',width = 480, height = 480)
dev.off()
