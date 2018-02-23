rankall <- function(outcome, num = "best") {
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcomes <- c("heart attack" , "heart failure" , "pneumonia")
  

  
  if( outcome %in% outcomes == FALSE ) {stop("invalid outcome") }

  data <- data[c(2, 7, 11, 17, 23)]
  names(data)[1] <- "name"
  names(data)[2] <- "state"
  names(data)[3] <- "heart attack"
  names(data)[4] <- "heart failure"
  names(data)[5] <- "pneumonia"
  

  if( num != "best" && num != "worst" && num%%1 != 0 ) stop("invalid num")
  
  data <- data[data[outcome] != 'Not Available', ]
  
  data[outcome] <- as.data.frame(sapply(data[outcome], as.numeric))
  data <- data[order(data$name, decreasing = FALSE), ]
  data <- data[order(data[outcome], decreasing = FALSE), ]

  getHospByRank <- function(df, s, n) {
    df <- df[df$state==s, ]
    vals <- df[, outcome]
    if( n == "best" ) {
      rowNum <- which.min(vals)
    } else if( n == "worst" ) {
      rowNum <- which.max(vals)
    } else {
      rowNum <- n
    }
    df[rowNum, ]$name
  }
  
  states <- data[, 2]
  states <- unique(states)
  newdata <- data.frame("hospital"=character(), "state"=character())
  for(st in states) {
    hosp <- getHospByRank(data, st, num)
    newdata <- rbind(newdata, data.frame(hospital=hosp, state=st))
  }
  

  newdata <- newdata[order(newdata['state'], decreasing = FALSE), ]
  newdata
}
source("rankall.R")
head(rankall("heart attack",20),10)
