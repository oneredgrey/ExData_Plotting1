## filename is Plot3.R

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


## PLOT 3:  Energy sub metering (1, 2, 3) _________________________________________________

## Look at sub metering variables
str(powerdata)
## $ Sub_metering_1       : Factor w/ 8 levels "0.000","1.000",..: 1 1 1 1 1 1 1 1 1 1 ...
## $ Sub_metering_2       : Factor w/ 3 levels "0.000","1.000",..: 1 1 1 1 1 1 1 1 1 1 ...
## $ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...

## convert sub_metering 1 & 2 to character then to numeric
powerdata$Sub_metering_1 <- as.numeric(as.character(powerdata$Sub_metering_1)) ## convert to char then numeric
powerdata$Sub_metering_2 <- as.numeric(as.character(powerdata$Sub_metering_2))

## check for missing values.
sum(is.na(powerdata$Sub_metering_1)) ## [1] 0    
sum(is.na(powerdata$Sub_metering_2)) ## [1] 0   
sum(is.na(powerdata$Sub_metering_3)) ## [1] 0   


length(powerdata$datetime) ## [1] 2880



## Create the plot for PLOT 3

###  Note: when creating the PNG file using "dev.copy", the legend font is too big for the 
###  legend and gets cut off.  Avoid this by writing the plot directly to the png device.
###_______________________________________________________________________________________


png(file = "plot3.png")  ## open png device and create file name

## create the plot for one series, then add the other two series one at a time
plot(powerdata$datetime, powerdata$Sub_metering_1, type = "l", 
     col = "black",
     ylab = "Energy sub metering", xlab = "")
par(new=T)  ## keep the same settings as the first plot (don't overwrite new settings)

lines(powerdata$datetime, powerdata$Sub_metering_2,  col = "red")  ## add the second line
par(new=T)

lines(powerdata$datetime, powerdata$Sub_metering_3,  col = "blue")  ## add the third line
legend("topright", col = c("black", "red", "blue"),
       lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  ## add the legend

dev.off()  ## Always close the device when done!
