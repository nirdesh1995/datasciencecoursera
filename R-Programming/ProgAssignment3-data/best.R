outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

ncol(outcome)
nrow(outcome)
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])

best <- function (state, outcome){
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcomes <- c("heart attack" , "heart failure" , "pneumonia")
  
  if (any(data[7] == state) == FALSE) {stop("invalid state")}
  if( outcome %in% outcomes == FALSE ) {stop("invalid outcome") }
  data <- data[c(2, 7, 11, 17, 23)]
  names(data)[1] <- "name"
  names(data)[2] <- "state"
  names(data)[3] <- "heart attack"
  names(data)[4] <- "heart failure"
  names(data)[5] <- "pneumonia"
  data <- data[data$state == state & data[outcome] != 'Not Available', ]
  vals <- data[, outcome]
  rowNum <- which.min(vals)
  data[rowNum, ]$name

}

best("TX", "heart attack")
best("TX", "heart failure")
