library( lubridate )

# Set locale to US to get correct days labels
invisible( Sys.setlocale("LC_TIME", "en_US.UTF-8") )

####################### Prepare data #######################
# Download dataset
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file( url = data_url, destfile = "dataset.zip", method = "curl" )

# UnZIP file from archive
unzip( "dataset.zip" )

# Read data from file to variable "data"
data <- read.csv( "household_power_consumption.txt", sep = ";", 
                  colClasses=c("character", "character", rep( "numeric", 7) ), na.strings = "?" )

# Convert Date column to correct format
data$Date <- strptime(data$Date, format = "%d/%m/%Y", tz = "UTC" )

# Extract only data for dates 2007-02-01 and 2007-02-02.
data_sub <- subset( data, 
                    data$Date == as.POSIXlt( "2007-02-01", format = "%Y-%m-%d", tz = "UTC") | 
                    data$Date == as.POSIXlt( "2007-02-02", format = "%Y-%m-%d", tz = "UTC") )

# Create new column containig date + time
data_sub$Datetime <- ymd( data_sub$Date ) + hms( data_sub$Time )

####################### Make plot #######################
# Set device parameters
png( filename = "plot2.png", width = 480, height = 480, bg = "transparent" )

# Make plot
plot( data_sub$Datetime,                          # Data to be plotted (X-axis)
      data_sub$Global_active_power,               # Data to be plotted (Y-axis)
      type = "l",                                 # Type = lines
      xlab = "",                                  # X-axis label
      ylab = "Global Active Power (kilowatts)",   # Y-axis label
      main = ""                                   # Main label
) 

# Close device, save file (hide output)
invisible( dev.off() )
