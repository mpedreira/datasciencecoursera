best <- function(state, outcome) {
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
  
  ## Return hospital name in that state with lowest 30-day death
  ##Subseting for a State
  state_data <- subset(data,data$State==state)
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
  # Remove not valid data
  valid_data <- subset(state_data,!state_data[,header] == "Not Available" & !is.na(state_data[,header]))
  ## rate
  best_result <- min(as.numeric(as.character(valid_data[,header])))
  best_hospital <- valid_data[as.numeric(as.character(valid_data[,header])) == best_result,"Hospital.Name"]
  return(as.character(best_hospital[1]))
}