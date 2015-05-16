corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  #Get files
  files <- list.files(directory, full.names=TRUE)
  
  result <- c()
  
  for (file in files){
    info <- read.csv(file, sep = ",")
    complete_cases <- info[complete.cases(info),]
    if (nrow(complete_cases) > threshold) {
      result <- c(result, cor(complete_cases$sulfate, complete_cases$nitrate))    
    }
  } 
  result
}