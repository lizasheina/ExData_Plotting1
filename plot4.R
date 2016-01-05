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
png( filename = "plot4.png", width = 480, height = 480, bg = "transparent" )

# Set plots layout = 2x2
par( mfcol = c(2, 2) )

# Make 1st plot
plot( data_sub$Datetime,                          # Data to be plotted (X-axis)
      data_sub$Global_active_power,               # Data to be plotted (Y-axis)
      type = "l",                                 # Type = lines
      xlab = "",                                  # X-axis label
      ylab = "Global Active Power",               # Y-axis label
      main = ""                                   # Main label
) 


# Make 2nd plot
plot( data_sub$Datetime,                          # Data to be plotted (X-axis)
      data_sub$Sub_metering_1,                    # Data to be plotted (Y-axis)
      type = "l",                                 # Type = lines
      xlab = "",                                  # X-axis label
      ylab = "Energy sub metering",               # Y-axis label
      main = ""                                   # Main label
) 

lines( data_sub$Datetime,                          # Data to be plotted (X-axis)
       data_sub$Sub_metering_2,                    # Data to be plotted (Y-axis)
       col = "red"                                 # Lines color
)

lines( data_sub$Datetime,                          # Data to be plotted (X-axis)
       data_sub$Sub_metering_3,                    # Data to be plotted (Y-axis)
       col = "blue"                                # Lines color
)

legend( "topright",                                                        # Legend location
        legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # Legend names
        col = c( "black", "red", "blue"),                                  # Colors
        lwd = c( 1, 1, 1),                                                 # Lines widths
        bty = "n"                                                          # No border
)

# Make 3rd plot
plot( data_sub$Datetime,                          # Data to be plotted (X-axis)
      data_sub$Voltage,                           # Data to be plotted (Y-axis)
      type = "l",                                 # Type = lines
      xlab = "datetime",                          # X-axis label
      ylab = "Voltage",                           # Y-axis label
      main = ""                                   # Main label
) 

# Make 4th plot
plot( data_sub$Datetime,                          # Data to be plotted (X-axis)
      data_sub$Global_reactive_power,             # Data to be plotted (Y-axis)
      type = "l",                                 # Type = lines
      xlab = "datetime",                          # X-axis label
      ylab = "Global_reactive_power",             # Y-axis label
      main = ""                                   # Main label
) 

# Close device, save file (hide output)
invisible( dev.off() )
