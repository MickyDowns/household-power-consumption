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
hhConsump$Sub_metering_1<-as.numeric(hhConsump$Sub_metering_1)
hhConsump$Sub_metering_2<-as.numeric(hhConsump$Sub_metering_2)
hhConsump$Sub_metering_3<-as.numeric(hhConsump$Sub_metering_3)

## Plots 3-layer sub metering time series graphic
png(file="plot3.png")
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
dev.off()