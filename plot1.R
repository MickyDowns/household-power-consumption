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

## Plots a histogram of global active power usage
png(file="plot1.png")
with(hhConsump,hist(Global_active_power,col="red",main="Global Active Power",
                    xlab="Global Active Power (kilowatts)"))
dev.off()