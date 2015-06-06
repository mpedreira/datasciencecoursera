rankhospital <- function (state,outcome,num="best"){
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", sep = ",")
 
  ## Check that state and outcome are valid
  valid_states = unique(data[,"State"])
  valid_outcome = c("heart attack", "heart failure", "pneumonia")
  if (!state %in% valid_states) {
    stop("invalid state")
  }
  if (!outcome %in% valid_outcome) {
    stop("invalid outcome")   
  }  
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  ##Subseting for a State
  data <- subset(data,data$State==state)
  #Select appropiate outcome
  if (outcome == "heart attack"){
    header <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  }
  else if (outcome == "heart failure"){
    header <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }
  else{
    header <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  }
  data <- data[,c("Hospital.Name",header)]
  data <- subset(data,!data[,header] == "Not Available" & !is.na(data[,header]))
  # Define what we are looking for
  if (num == "best"){
    num <- 1
  }
  else if (num == "worst"){
          num <- nrow(data)
        } 
       else if (!is.numeric(num)){
              stop("invalid num")
       }
          else if (num > nrow(data)){
                  return (NA)   
              }
  
  data <- data[order(as.numeric(as.character(data[,header])), as.character(data[,"Hospital.Name"])),]
  as.character(data[,"Hospital.Name"][num])
}