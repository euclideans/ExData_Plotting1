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
    png("~/Desktop/Coursera_DS/ExData_Plotting1-master/figure/plot1.png")
    
    hist(df2$`Global Active Power`, xlab="Global Active Power (kilowatt)", 
         main="Global Active Power", col="red")
    
    dev.off()