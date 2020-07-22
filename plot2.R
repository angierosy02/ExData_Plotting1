plot2 <- function(){
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

#Plot 2:

#Combining the date and time columns into one to create the x axis for the plot
DateTime <- as.POSIXct(paste(subData$Date, subData$Time))

#Creating a scatterplot with a solid line for the two variables and saving it as a png
png("plot2.png", width=480, height=480)
with(subData, plot(DateTime, Global_active_power,xlab="",
                   ylab = "Global Active Power (kilowatts)", type = "l"),na.rm=TRUE )
dev.off()
}