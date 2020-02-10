#we use this library for more efficiency to manipulate big data sets than the base package
library(data.table)

#check if the data set file exists in the working directory, else download/unzip it
if (!file.exists("household_power_consumption.txt")){
        if (!file.exists("exdata_data_household_power_consumption.zip")){
                download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                              destfile="exdata_data_household_power_consumption.zip",
                              method="curl")
        }
        unzip("exdata_data_household_power_consumption.zip")
}

#load the whole data set
dataPlotting1<-fread("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")

#format the "Date" column characters into date type and select only the 2 requested days
dataPlotting1$Date<-as.Date(dataPlotting1$Date,format="%d/%m/%Y")
dataPlotting1_plot1<-subset(dataPlotting1,Date=="2007-02-01"|Date=="2007-02-02")

#create the column "DateTime" with 
dataPlotting1_plot1$DateTime<-as.POSIXct(paste(dataPlotting1_plot1$Date,
                                                dataPlotting1_plot1$Time),
                                                format="%Y-%m-%d %H:%M:%S")

#create the PNG file with the requested attributes
png(file="plot1.png",width=480,height=480,units ="px")

#draw the histogram with proper formating, labels...
hist(dataPlotting1_plot1$Global_active_power,col="red", main="Global Active Power",
                xlab="Global Active Power (kilowatts)",ylab="Frequency")

#close the current PNG graphics device
dev.off()
