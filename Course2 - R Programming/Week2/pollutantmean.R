pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  #New array for values
  values <- c()
  
  #Get files
  files <- list.files(directory, full.names=TRUE)
  
  #Iterates for these files
  for (i in id){
    file <- files[i]
    info <- read.csv(file, sep = ",");
    file_values <- info[,pollutant]
    #Remove NA for this file
    file_values <- file_values[!is.na(file_values)]
    #Concatenate with other files values
    values <- c(values, file_values)
  } 
  mean(values)
}