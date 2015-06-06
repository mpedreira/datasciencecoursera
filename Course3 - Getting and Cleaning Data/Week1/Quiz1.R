question1 <- function (){
  microdata_file <- "./data/question1.csv"
  file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
  download.file(file,destfile = microdata_file,method="curl",quiet = TRUE)
  microdata <- read.table(microdata_file,header = TRUE,sep = ",")
  sum(!is.na(microdata$VAL[microdata$VAL==24]))
   
}

question3 <- function (){
  library(xlsx)
  gas_file <- "./data/question3.xlsx"
  rows <- 18:23
  cols <- 7:15
  file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx " 
  download.file(file,destfile = gas_file,method="curl",quiet = TRUE)
  gas <- read.xlsx(gas_file, sheetIndex=1, header=TRUE, colIndex=cols, rowIndex=rows)
  sum(gas$Zip*gas$Ext,na.rm=T)
}

question4 <- function (){
  library(XML)
  restaurants_file <- "./data/question4.xml"
  file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 
  download.file(file,destfile = restaurants_file,method="curl",quiet = TRUE)
  restaurants <- xmlTreeParse(restaurants_file,useInternalNodes = TRUE)
  restaurants_xml = xmlRoot(restaurants)
  sum(xpathSApply(restaurants_xml, "//zipcode", xmlValue)==21231)
}

question5 <- function (){
  library(data.table)
  microdata_file <- "./data/question5.csv"
  file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv " 
  download.file(file,destfile = microdata_file,method="curl",quiet = TRUE)
  DT <- fread(input = microdata_file,sep = ",")
  answer1 <- as.array(system.time(DT[,mean(pwgtp15),by=SEX]))
  answer2 <- as.array(system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15)))
  answer3 <- as.array(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))
  answer4 <- as.array(system.time(mean(DT$pwgtp15,by=DT$SEX)))
  answer5 <- as.array(system.time(tapply(DT$pwgtp15,DT$SEX,mean)))
  # This command fails
  # answer6 <- as.array(system.time(rowMeans(DT)[DT$SEX==1])+system.time(rowMeans(DT)[DT$SEX==2]))
  answers <- sort(c(answer1[1],answer2[1],answer3[1],answer4[1],answer5[1]))
  if (answers[1]==answer1[1]){
     print("Correct Answer is DT[,mean(pwgtp15),by=SEX]")
  }
  if (answers[1]==answer2[1]){
    print("Correct Answer is mean(DT[DT$SEX==1,]$pwgtp15));(mean(DT[DT$SEX==2,]$pwgtp15))")
  }
  if (answers[1]==answer3[1]){
    print("Correct Answer is sapply(split(DT$pwgtp15,DT$SEX),mean)")
  }
  if (answers[1]==answer4[1]){
    print("Correct Answer is mean(DT$pwgtp15,by=DT$SEX)")
  }
  if (answers[1]==answer5[1]){
    print("Correct Answer is tapply(DT$pwgtp15,DT$SEX,mean)")
  }
  
}