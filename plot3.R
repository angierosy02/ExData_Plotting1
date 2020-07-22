plot3 <- function(){
#Getting the Data from the provided course URL
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data/Elec_Power_Consumption_Dataset")
path_rf <- file.path("./data" , "Elec_Power_Consumption_Dataset")

#Create a list of files in the dataset folder
list_files <- list.files("./data", full.names = T, recursive = TRUE)

#Reading the text file in to a data frame
data <- read.table(list_files[[2]], header = TRUE, sep = ";", stringsAsFactors = FALSE,na.strings ="?")

# Converting the Date variable to Date class using the as.Date() function.
data$Date <- as.Date(data$Date,"%d/%m/%Y")

subData <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Converting the Time variable to Time class using the format() and strptime() functions.
subData$Time <- format(as.POSIXct(strptime(subData$Time,"%H:%M:%S")) ,format = "%H:%M:%S")

#Plot 3:

#Combining the date and time columns into one to create the x axis for the plot
DateTime <- as.POSIXct(paste(subData$Date, subData$Time))

#Create a png file
png("plot3.png", width=480, height=480)

#creates an empty plot with axes and title = type = “n”. The next few scatterplots will show up here with 
#different colors and a legend based on the code below.
with(subData,plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))   
with(subData, points(DateTime,Sub_metering_1 , type = "l"),na.rm=TRUE)
with(subData, points(DateTime,Sub_metering_2 ,col = "red", type = "l"),na.rm=TRUE)
with(subData, points(DateTime,Sub_metering_3 ,col = "blue", type = "l"),na.rm=TRUE)
legend("topright", col = c("black","red","blue"), 
        legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = 1)
dev.off()
}