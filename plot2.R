# This code will construct the plot that should reproduce Plot2 figure given in instructions
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

#####################
# Plot 2 construction
#####################

# Open png file with a width of 480 pixels and a height of 480 pixels
# Background is set to NA (transparent), see forum discussion: https://class.coursera.org/exdata-011/forum/thread?thread_id=24
png(filename = "plot2.png", width = 480, height = 480, bg = NA)

# Draw a line plot of Global Active Power versus Time as per figure 2
# In order to draw a line plot, using argument of type = "1", see documentation: ?plot
plot(subdata$DateTime, subdata$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Turn off PNG graphics device
dev.off()