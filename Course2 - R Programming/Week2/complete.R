complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  #Define result
  nobs <- c()
  
  #Get files
  files <- list.files(directory, full.names=TRUE)
  
  #Iterates for these files
  for (i in id){
    file <- files[i]
    info <- read.csv(file, sep = ",");
    complete_cases <- info[complete.cases(info),];
    nobs <- c(nobs,nrow(complete_cases))
  }
  result <- data.frame(cbind(id, nobs))
  result
}