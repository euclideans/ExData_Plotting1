#creates data table from txt file
df<-read.delim("~/Desktop/Coursera_DS/household_power_consumption.txt", sep = ";",stringsAsFactors = FALSE)

#create a new DateTime variable by pasting Date and Time
df$DateTime<- as.character(paste(df$Date,df$Time, sep =""))

#convert DateTime from character to a Date-Time data class
df$DateTime<-as.POSIXct(df$DateTime, format = "%d/%m/%Y%n%H:%M:%S")

#set DateTime column as first column
#remove Date and Time columns
#filter out all dates comprised out of the given dates for analysis
library(dplyr)
df2<-df %>% select(DateTime,everything(),-Date,-Time) %>% filter(DateTime > "2007-02-01 00:00:00" & DateTime <"2007-02-02 23:59:59")

#converting character columns to numeric
indx <- sapply(df2, is.character)
df2[indx] <- lapply(df2[indx], function(x) as.numeric(as.character(x)))

#some cleaning
df2<-rename(df2, "Global Active Power"="Global_active_power")

#plotting
png("~/Desktop/Coursera_DS/ExData_Plotting1-master/figure/plot3.png")

#The par(new=T) tells R to make the second plot without cleaning the first.
#Two things to consider though: in the second set axes to FALSE, 
#and xlabel and ylabel to empty strings or in the final result 
#you’ll see some overlapping and bleeding of the several labels and axes.
plot(df2$DateTime, df2$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
par(new=T)

#because of all this superimposing you need to know your axes ranges 
#and set them up equally in all plot commands
#ylim max value is set at 38 because max value is 38 from metering_3
plot(df2$DateTime, df2$Sub_metering_2, type='l', col="red",ylim=c(0,38), xlab='', ylab='', axes =F)
par(new=T)
plot(df2$DateTime, df2$Sub_metering_3, type='l', col="blue",ylim=c(0,38), xlab='', ylab='', axes =F)
legend("topright", 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = 1, cex=0.9)
dev.off()