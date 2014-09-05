#####Question 1 Create a vecor with 20 numbers:#####
q1 <- abs(-9:10)

#####Question 2 Convert to characters#####
q2 <- as.character(q1)

#####Question 3 Convert Vector to factors#####
q3 <- as.factor(q1)

#####Question 4 Number of levels in factor#####
q4 <- nlevels(q3)

#####Question 5 run math on vector#####
q5 <- 3 * (q1^2) - (4*q1) + 1

#####Question 6 Linear Regression#####
x1 <- c(1, 1, 1, 1, 1, 1, 1, 1, 5, 4, 6, 2, 3, 2, 7, 8, 8, 9, 4, 7, 4, 9, 6, 4)
x <- matrix(x1, 8, 3)
y1 <- c(45.2, 46.9, 31, 35.3, 25, 43.1, 41, 35.1)
y <- matrix(y1, 8, 1)
install.packages("MASS")
library(MASS)
beta_vector <- ginv(t(x) %*% x) %*% t(x) %*% y

#####Question 7: Named List#####
q7 <-list(a=1, b=2, c=3, d=4 ,e=5)

#####Question 8: Data Frame#####
q8_1 <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j")
q8_2 <- as.factor(c(0:2, 0:2, 0:2, 1))
q8_3 <- as.numeric(c(10:19))
q8_4 <- as.Date(c('2014-01-01', '2014-01-02', '2014-01-03', '2014-01-04', '2014-01-05', '2014-01-06', '2014-01-07', '2014-01-08', '2014-01-09', '2014-01-10'))
q8 <- data.frame(q8_1, q8_2, q8_3, q8_4)

#####Question 9: Add a row to calumn of factor data#####
q9_1 <- "k"
q9_2 <- as.factor(4) 
q9_3 <- as.numeric(20)
q9_4 <- as.Date('2014-01-11')
q9_5 <- data.frame(q9_1, q9_2, q9_3, q9_4)  
names(q9_5) <- names(q8)
q9 <- rbind(q8, q9_5)

#####question 10: Load temperatures.csv#####
q10 <- read.csv("temperatures.csv")

#####question 11 load measurements.txt from not working dir#####
q11 <-read.table("C:/Users/adams/Desktop/measurements.txt")

#####question 12 load data from www #####
q12 <- read.table("http://homepages.wmich.edu/~m3schul1/pipetest.psv", header=FALSE, sep="|")


#####question 13 loop to calculate 12 factorial #####
factorial <- function(x){
  j <- 1
  for(i in 1:x){
    j <- j * ((1:x)[i])
  }
  print(j)
}
  
factorial(12)  
#ans 479001600

##### question 14 loop for interest #####

interest <- function(initial,interest,years){
  months <- years*12
  j <- initial
  for(i in 1:months){
    j <- j*(1+(interest/12))
  }
  print(round(j,2))
}
interest(1500,0.0324,6)
# ans= 1821.40


##### question 15 sum up ever 3rd element of a vector #####

q15 <- c(1:19)

vectorsum <- function(v){
  i <- 1
  b<-0
  while (i <= length(v)){
    b <- b + v[i]
    i <- i+3
  }
  print(b)
}

vectorsum(q15)

##### question 16 Use a for loop to calculate ∑ #####
sigma <- function(base){
  x <- 0
  for (i in 1:10){
    x <- x + (base^i)
  }
  print(x)
}
sigma(2)

#ans 2046

##### question 17 use while for 16 #####

sigmav2 <- function(base){
  i <- 1
  x <- 0
  while (i <= 10) {
    x <- x + (base^i)
    i <- i+1
  }
  print(x)
}
sigmav2(2)
#ans 2046

##### question 18 solve the series without a loop #####
q18 <- c(1:10)
sum(2^q18)

##### question 19 
q19 <- c(20:50, 5)
c