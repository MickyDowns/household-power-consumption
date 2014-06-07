## Download and unzip. Then remove zip.
download.file(fileUrl,destfile="zipfile.zip",method="curl")

unzip("consData.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)

rm(fileUrl,"consData.zip")

## Read data into R
hhConsump<-read.table("household_power_consumption.txt",sep=";",
                      header=TRUE,na.strings="NA",nrows=170000)

## Convert date
hhConsump$Date <- as.Date(hhConsump$Date , "%d/%m/%Y")

## Subset table on date
hhConsump<-hhConsump[hhConsump$Date>="2007-02-01",]
hhConsump<-hhConsump[hhConsump$Date<="2007-02-02",]

## Convert time
library(chron)
hhConsump$Time<-chron(time=hhConsump$Time)
