library(dplyr)
library(lubridate)

create_plot3 <- function() {
        # Sample position from 2007-02-01 to 2007-02-02
        rowstart = 66637
        samplesize = 2880
        
        # Read the data file on the sample's positions
        data <- read.table("household_power_consumption.txt", 
                           sep = ";", 
                           stringsAsFactors = FALSE, 
                           header = FALSE, 
                           skip = rowstart, 
                           nrows = samplesize)
        
        # Read the first line containing the headers
        headers <- read.table("household_power_consumption.txt", 
                              sep = ";", 
                              nrows = 1, 
                              stringsAsFactors = FALSE)
        
        # Add the headers as variable names to data
        names(data) <- as.character(as.vector(headers[1, ]))
        
        # Create a DateTime variable
        data <- mutate(data, DateTime = dmy_hms(paste(data$Date, data$Time)))
        
        # Create the plot on PNG device and the 3 lines and legend separately
        png(file = "plot3.png", width = 480, height = 480, unit = "px")
        plot(data$DateTime, 
             data$Sub_metering_1,
             type = "n",
             ylab = "Energy sub metering",
             xlab = "")
        lines(data$DateTime, data$Sub_metering_1, type = "l")
        lines(data$DateTime, data$Sub_metering_2, col = 2, type = "l")
        lines(data$DateTime, data$Sub_metering_3, col = 4, type = "l")
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               lty = 1, 
               col = c(1, 2, 4))
        dev.off()
        
        "Plot has been successfully created."
}