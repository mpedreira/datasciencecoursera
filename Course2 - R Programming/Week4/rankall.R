rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", sep = ",")
  hospitals <- data.frame(x = character(), y = character())
  
  ## Check that state and outcome are valid
  valid_states = sort(unique(data[,"State"]))
  valid_outcome = c("heart attack", "heart failure", "pneumonia")
  if (!outcome %in% valid_outcome) {
    stop("invalid outcome")   
  }  
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
  
  # Change best and worst for a number
  if (num == "best"){
    pos <- 1
  }
  else if (is.numeric(num)){
        pos <- num    
      }
  #valid_states <- "WY"
  ## For each state, find the hospital of the given rank
  for (state in valid_states){
    state_data <- subset(data,data$State==state)
    state_data <- state_data[,c("Hospital.Name",header,"State")]
    state_data <- subset(state_data,!state_data[,header] == "Not Available" & !is.na(state_data[,header]))
    state_data <- state_data[order(as.numeric(as.character(state_data[,header])), as.character(state_data[,"Hospital.Name"])),]
    if (num == "worst"){
      pos <- nrow(state_data)
    } 
    hospital <- state_data[,"Hospital.Name"][pos]
    hospitals <- rbind(hospitals,data.frame(hospital, state))
    
  }
  print(names(hospitals))
  hospitals
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
}