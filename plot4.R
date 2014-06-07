## Read data into R
hhConsump<-read.table("household_power_consumption.txt",
                      sep=";",
                      header=TRUE,
                      colClasses="character",
                      na.strings="NA",nrows=170000)

## Create merged DateTime column
hhConsump$DateTime<-strptime(paste(hhConsump$Date,hhConsump$Time),
                             "%d/%m/%Y %H:%M:%S")

## Subset table on date
hhConsump$Date<-as.Date(hhConsump$Date,"%d/%m/%Y")
hhConsump<-hhConsump[hhConsump$Date>="2007-02-01",]
hhConsump<-hhConsump[hhConsump$Date<="2007-02-02",]

## Convert select columns to class numeric
hhConsump$Global_active_power<-as.numeric(hhConsump$Global_active_power)
hhConsump$Global_reactive_power<-as.numeric(hhConsump$Global_reactive_power)
hhConsump$Voltage<-as.numeric(hhConsump$Voltage)
hhConsump$Global_intensity<-as.numeric(hhConsump$Global_intensity)
hhConsump$Sub_metering_1<-as.numeric(hhConsump$Sub_metering_1)
hhConsump$Sub_metering_2<-as.numeric(hhConsump$Sub_metering_2)
hhConsump$Sub_metering_3<-as.numeric(hhConsump$Sub_metering_3)

## Plots four time series graphics including active power usage,
## sub metering, voltage and reactive power usage.
png(file="plot4.png")

par(mfcol=c(2,2))

## Plots global active power usage time series graphic
with(hhConsump,plot(DateTime,Global_active_power,type="l",
                    xlab="",ylab="Global Active Power"))

## Plots 3-layer sub metering time series graphic
with(hhConsump,plot(DateTime,Sub_metering_1,
                    ylab="Energy sub metering",
                    xlab="",
                    type="n"))
with(subset(hhConsump,Sub_metering_1>=0),
     points(DateTime,Sub_metering_1,col="black",type="l"))
with(subset(hhConsump,Sub_metering_2>=0),
     points(DateTime,Sub_metering_2,col="red",type="l"))
with(subset(hhConsump,Sub_metering_3>=0),
     points(DateTime,Sub_metering_3,col="blue",type="l"))
legend("topright",lwd=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3"))

## Plots voltage time series graphic
with(hhConsump,plot(DateTime,Voltage,
                    xlab="datetime",
                    type="l"))

## Plots global reactive power time series graphic
with(hhConsump,plot(DateTime,Global_reactive_power,
                    xlab="datetime",
                    type="l"))

dev.off()

## Remove intermediate files
unlink("household_power_consumption.txt")