## Download and unzip. Then remove zip.
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl,destfile="consData.zip",method="curl")

unzip("consData.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)

## Remove intermediate files
unlink("consData.zip")
rm(fileUrl)