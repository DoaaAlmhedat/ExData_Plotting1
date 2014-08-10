## Downloading file, check wether it is exist, 
raw_file <- "household_power_consumption.txt"
if (file.exists(raw_file) == FALSE) {
  zip_file <- "exdata-data-household_power_consumption.zip"
  if (file.exists(zip_file) == FALSE) { 
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile=zip_file, method="curl")
  }
  unzip(zip_file)
}
## Reading file into "data" data frame
data <- read.table(raw_file, sep =";", header=T)

## Subsetting the data that we want (two days in february) from "data"
my_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## To remove the missing values
my_data$Global_active_power <- as.numeric(as.character(my_data$Global_active_power))
my_data$Global_reactive_power <- as.numeric(as.character(my_data$Global_reactive_power))
my_data$Sub_metering_1 <- as.numeric(as.character(my_data$Sub_metering_1))
my_data$Sub_metering_2 <- as.numeric(as.character(my_data$Sub_metering_2))
my_data$Sub_metering_3 <- as.numeric(as.character(my_data$Sub_metering_3))
my_data$Voltage <- as.numeric(as.character(my_data$Voltage)) 

## convert date format and createnew variable at my_data as "Datetime" 
my_data$Date <- as.Date(my_data$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(my_data$Date), my_data$Time)
my_data$Datetime <- as.POSIXct(datetime)

## plotting
png(filename="plot4.png", width=480, height=480)
par(mfrow = c(2,2))

plot(my_data$Global_active_power ~ my_data$Datetime, ylab="Global Active Power", type = "l", xlab = "")
plot(my_data$Voltage ~ my_data$Datetime, ylab="Voltage",type = "l", xlab = "datetime")

plot(my_data$Sub_metering_1 ~ my_data$Datetime, type="l",ylab="Energy sub metering", xlab="")
lines(my_data$Sub_metering_2 ~ my_data$Datetime,col='Red')
lines(my_data$Sub_metering_3 ~ my_data$Datetime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(my_data$Global_reactive_power ~ my_data$Datetime, ylab="Global_reactive_power", type = "l", xlab = "datetime")
dev.off()