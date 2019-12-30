
create_plot1 <- function() {
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
        
        # Create the histogram on PNG device
        png(file = "plot1.png", width = 480, height = 480, unit = "px")
        hist(data$Global_active_power, 
             main = "Global Active Power", 
             col = 2, 
             xlab = "Global Active Power (kilowatts)")
        dev.off()
        
        "Plot has been successfully created."
}