## filename is Plot2.R

## Read in the dataset.  The headers are in the first row.
thedata <- read.table("household_power_consumption.txt", sep = ";", 
                      header = TRUE)  
str(thedata)
## 'data.frame':	2075259 obs. of  9 variables:
## $ Date                 : Factor w/ 1442 levels "1/1/2007","1/1/2008",..: 342 342 342 342 342 342 342 342 342 342 ...
## $ Time                 : Factor w/ 1440 levels "00:00:00","00:01:00",..: 1045 1046 1047 1048 1049 1050 1051 1052 1053 1054 ...
## $ Global_active_power  : Factor w/ 4187 levels "?","0.076","0.078",..: 2082 2654 2661 2668 1807 1734 1825 1824 1808 1805 ...
## $ Global_reactive_power: Factor w/ 533 levels "?","0.000","0.046",..: 189 198 229 231 244 241 240 240 235 235 ...
## $ Voltage              : Factor w/ 2838 levels "?","223.200",..: 992 871 837 882 1076 1010 1017 1030 907 894 ...
## $ Global_intensity     : Factor w/ 222 levels "?","0.200","0.400",..: 53 81 81 81 40 36 40 40 40 40 ...
## $ Sub_metering_1       : Factor w/ 89 levels "?","0.000","1.000",..: 2 2 2 2 2 2 2 2 2 2 ...
## $ Sub_metering_2       : Factor w/ 82 levels "?","0.000","1.000",..: 3 3 14 3 3 14 3 3 3 14 ...
## $ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...

names(thedata)
## [1] "Date"                  "Time"                  "Global_active_power"  
## [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
## [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"       


## Subset the data based on the two dates specified: February 1, 2007 and February 2, 2007
selected = c("1/2/2007", "2/2/2007")  ## specifies the dates required
powerdata <- droplevels(thedata[thedata$Date %in% selected, ]) 
## droplevels gets rid of the other dates (unused factor levels)

table(powerdata$Date) ## check to see if the subsetting worked correctly
## 1/2/2007 2/2/2007 
## 1440     1440


## PLOT 2: Global Active Power by day _______________________________________________________
## Need to merge "Date" and "Time" into one variable called "datetime"

## Convert Date to "character", then to "Date" format. (don't go directly from factor -> date)
powerdata$Date <- as.character(powerdata$Date)

## Convert "Date" to date format using "as.Date"
## This will put the dates in a format more easily converted using strptime (later)
powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y")
class(powerdata$Date)  ## [1] "Date"

## convert "Time" to character variable in preparation for merging with Date.
powerdata$Time <- as.character(powerdata$Time)
class(powerdata$Time) ##[1] "character"


## merge the Date and Time columns 
powerdata$datetime <- paste(powerdata$Date,powerdata$Time)
class(powerdata$datetime) ## [1] "character"
head(powerdata$datetime)
## [1] "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00" "2007-02-01 00:03:00"
## [5] "2007-02-01 00:04:00" "2007-02-01 00:05:00"

## Convert "datetime" to date format using strptime()
powerdata$datetime <- strptime(powerdata$datetime, format = "%Y-%m-%d %H:%M:%S")

class(powerdata$datetime) ## [1] "POSIXlt" "POSIXt" 
sum(is.na(powerdata$datetime))  ## [1] 0   (check for missing values)


## Create Plot 2.

plot(powerdata$datetime, powerdata$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
## This matches the one in the assignment.
## Save it as a .png file using dev.copy with the dimensions specified in the assignment.
dev.copy(png, file = "plot2.png", width = 480, height = 480) 
dev.off()
