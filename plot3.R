#we use this library for more efficiency to manipulate big data sets than the base package
library(data.table)

#save your current system time then set it to use english day names
yourLCT<-Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","English")

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
dataPlotting1_plot3<-subset(dataPlotting1,Date=="2007-02-01"|Date=="2007-02-02")

#create the column "DateTime" with 
dataPlotting1_plot3$DateTime<-as.POSIXct(paste(dataPlotting1_plot3$Date,
                                               dataPlotting1_plot3$Time),
                                         format="%Y-%m-%d %H:%M:%S")

#create the PNG file with the requested attributes
png(file="plot3.png",width=480,height=480,units ="px")

#draw the graphs with proper formating, labels...
with(dataPlotting1_plot3,plot(DateTime,Sub_metering_1,col="black",type="l",xlab="",ylab="Energy sub metering"))
with(dataPlotting1_plot3,lines(DateTime,Sub_metering_2,col="red"))
with(dataPlotting1_plot3,lines(DateTime,Sub_metering_3,col="blue"))

#add legend
legend(x="topright",col=c("black","red","blue"),lty=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#close the current PNG graphics device and reset the system to your local time
dev.off()
Sys.setlocale("LC_TIME",yourLCT)
