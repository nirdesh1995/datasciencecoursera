
setwd("~/datascience/datasciencecoursera/Exploratory Data Analysis /Course Project 1")


#-------------------- PLOT 1 ----------------------------------------------------------
#reading in the data 
powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
#Date in d/m/y

#Subsetting the data 
powerdata <- powerdata[powerdata$Date %in% c("1/2/2007","2/2/2007") ,]

#Convert datetime and neumerica vlaues
#powerdata$Date <- as.Date(powerdata$Date, format = "%Y%m%d")
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)

#create histogram 
hist(powerdata$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency") 

#save histogram as png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()


#-------------------- PLOT 2 ----------------------------------------------------------

powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
powerdata <- powerdata[powerdata$Date %in% c("1/2/2007","2/2/2007") ,]

#set proper date frormat and add date time format to make a new column 
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(powerdata$Date), powerdata$Time)
powerdata$Datetime <- as.POSIXct(datetime)


#create plot
plot(powerdata$Global_active_power~powerdata$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()


#-------------------- PLOT 3 ----------------------------------------------------------

powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
powerdata <- powerdata[powerdata$Date %in% c("1/2/2007","2/2/2007") ,]

#set proper date frormat and add date time format to make a new column 
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(powerdata$Date), powerdata$Time)
powerdata$Datetime <- as.POSIXct(datetime)


#print combined plot with subplots
with(powerdata, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()


#-------------------- PLOT 4 ----------------------------------------------------------

powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
powerdata <- powerdata[powerdata$Date %in% c("1/2/2007","2/2/2007") ,]

#set proper date frormat and add date time format to make a new column 
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(powerdata$Date), powerdata$Time)
powerdata$Datetime <- as.POSIXct(datetime)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(powerdata, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=680, width=680)
dev.off()

#powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
#powerdata <- powerdata[powerdata$Date %in% c("1/2/2007","2/2/2007") ,]
write.table(powerdata, "./household_power_consumption.txt", row.name=FALSE)

