library(dplyr)
library(lubridate)

create_plot2 <- function() {
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
        
        # Create the line chart on PNG device
        png(file = "plot2.png", width = 480, height = 480, unit = "px")
        plot(data$DateTime, 
             data$Global_active_power,
             type = "l",
             ylab = "Global Active Power (kilowatts)",
             xlab = "")
        dev.off()
        
        "Plot has been successfully created."
}