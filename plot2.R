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
two_days_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## To remove the missing values
two_days_data$Global_active_power <- as.numeric(as.character(two_days_data$Global_active_power))

## converting date 
two_days_data$Date <- as.Date(two_days_data$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(two_days_data$Date), two_days_data$Time)
two_days_data$Datetime <- as.POSIXct(datetime)

## Plotting
png(filename="plot2.png", width=480, height=480)
plot(two_days_data$Global_active_power ~ two_days_data$Datetime, ylab="Global Active Power (kilowatts)", type = "l", xlab = "")
dev.off()







