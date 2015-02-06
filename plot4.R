# This code will construct the set of 4 plots arranged to 2 columns and 2 rows, it should reproduce Plot4 figure given in instructions
# Per instructions each script for each plot should have the code for reading data, which should be downloaded from the link provided
# Because everyone has different settings/subfolders we will assume that original dataset is placed into RStudio working directory

# This original dataset must be present in RStudio working directory
datafile="household_power_consumption.txt"

# Read original dataset, replacing missing values coded with "?" characters as NA
alldata <- read.table(datafile, sep=';', header=T, colClasses = c(rep('character', 2), rep("numeric", 7)), na.strings='?')

# Since we need a DateTime variable to work with, we will create it by converting existing Date and Time variables 
# to DateTime class:
alldata$DateTime <- strptime(paste(alldata$Date, alldata$Time), "%d/%m/%Y %H:%M:%S")

# Extract a subset to work only with desired dates:
subdata <- subset(alldata, as.Date(DateTime) >= as.Date("2007-02-01") & as.Date(DateTime) <= as.Date("2007-02-02"))

##################################
# Plot 4 construction (multi-plot)
##################################

# Open png file with a width of 480 pixels and a height of 480 pixels
# Background is set to NA (transparent), see forum discussion: https://class.coursera.org/exdata-011/forum/thread?thread_id=24
png(filename = "plot4.png", width = 480, height = 480, bg = NA)

# Set arrangement of 4 plots to 2 columns and 2 rows
par(mfrow=c(2,2))

#############################################
# Draw a top left plot of Global Active Power
#############################################
plot(subdata$DateTime, subdata$Global_active_power, type="l", ylab="Global Active Power", xlab="")

##################################################
# Draw a top right plot of Voltage versus datetime
##################################################
plot(subdata$DateTime, subdata$Voltage, type="l", ylab="Voltage", xlab="datetime")

##################################################################
# Draw a bottom left plot of Energy Submetering (3 diferent types)
##################################################################
plot(subdata$DateTime, subdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")

# Add line segments to a plot for submetering types 2 and 3, coloring them as red and blue respectively
lines(subdata$DateTime, subdata$Sub_metering_2, col='red')
lines(subdata$DateTime, subdata$Sub_metering_3, col='blue')

# Add legend, this time without the box line as in figure 4
legend("topright", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
        lty = c(1,1,1), bty = "n")

###################################################################
# Draw a bottom right plot of Global Reactive Power versus datetime
###################################################################
plot(subdata$DateTime, subdata$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

# Turn off PNG graphics device
dev.off()