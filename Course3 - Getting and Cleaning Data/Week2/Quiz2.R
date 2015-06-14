question1 <- function (){
  library(jsonlite)
  JSON <- fromJSON("https://api.github.com/users/jtleek/repos", flatten = TRUE)
  created_at <- JSON[JSON$name == "datasharing",]$created_at
  print(c("El repo se ha creado: ",created_at))
  created_at
}

question2 <- function (){
  library(sqldf)
  acs_file <- "./specdata/question2.csv"
  # file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv" 
  # download.file(file,destfile = acs_file,method="curl",quiet = TRUE)
  acs <- read.csv(acs_file, header=T, sep=",")
  head(sqldf("select pwgtp1 from acs where AGEP < 50"))
  # sqldf("select * from acs where AGEP < 50 and pwgtp1") ## Dont filters PWGTP1 colum
  # sqldf("select pwgtp1 from acs") ## Dont filters AGEP < 50
  # sqldf("select * from acs where AGEP < 50") ## Dont filters PWGTP1 colum
  
}

question3 <- function (){
  library(sqldf)
  acs_file <- "./specdata/question2.csv"
  # file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv" 
  #  download.file(file,destfile = acs_file,method="curl",quiet = TRUE)
  acs <- read.csv(acs_file, header=T, sep=",")
  sqldf("select distinct AGEP from acs")
  # sqldf("select unique AGEP from acs") ##FAILS
  # sqldf("select AGEP where unique from acs") ## FAILS
  # sqldf("select unique * from acs") ## FAILS
  
}

question4 <- function (){
  jleek_url <-  "http://biostat.jhsph.edu/~jleek/contact.html" 
  data <- url(jleek_url)
  html <- readLines(data)
  result <- sapply(html[c(10, 20, 30, 100)], nchar)
  close(data)
  print(paste("El Resultado es :",as.character(result[1]),as.character(result[2]),as.character(result[3]),as.character(result[4]),sep=" "))
  c(as.integer(result[1]),as.integer(result[2]),as.integer(result[3]),as.integer(result[4]))
}

## This is standar method for others
question4b <- function (){
  jleek_file <- "./specdata/question4.html"
  file <- "http://biostat.jhsph.edu/~jleek/contact.html" 
  download.file(file,destfile = jleek_file,method="curl",quiet = TRUE)
  html <- readLines(data_file)
  sapply(html[c(10, 20, 30, 100)], nchar)
  print(paste("El Resultado es :",as.character(result[1]),as.character(result[2]),as.character(result[3]),as.character(result[4]),sep=" "))
  c(as.integer(result[1]),as.integer(result[2]),as.integer(result[3]),as.integer(result[4]))
}


question5 <- function (){
  data_file <- "./specdata/question5.for"
  file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for" 
  download.file(file,destfile = data_file,method="curl",quiet = TRUE)
  parsed <- read.fwf(
  file=data_file,
    skip=4,
    widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4))
  sum(parsed[, 4])
}
