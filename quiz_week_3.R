##### q1: Write a function that takes a numeric vector and calculates the mean of the observations in the vector #####
mean_of_vector <- function(vector){
  print(mean(vector))
}
vector <- c(1:10)
mean_of_vector(vector) #ans: 5.5

##### q2 Modify your function in the previous question so that it can handle a numeric vector with missing values #####

mean_of_vector_with_NA <- function(vector_with_NA){
  print (mean(vector_with_NA, na.rm=TRUE))
}
vector_with_NA <- c(1:10, NA)
#mean_of_vector_with_nulls(vector_with_nulls)
mean_of_vector_with_NA(vector_with_NA) #ans: 5.5

##### q3: Write a function that takes two numeric input values and calculates the greatest common divisor of the two numbers ####

# First you need to install a package called "schoolmath" which has a predifined function for this purpose
#install.packages("schoolmath")
#library(schoolmath)
greatest_common_divisor <- function(a,b) {
  return(gcd(a,b))
}

greatest_common_divisor(20,50) #ans: 10

#####q4: Write a function that implements Euclid’s algorithm ######

euclid_algo <- function(a,b) {
  rk1 <- a
  rk2 <- b
  while (rk2 != 0) {
    rk <- rk1%%rk2
    rk1 <- rk2
    rk2 <- rk
  }
  return (rk1)
}  

euclid_algo(1071, 462) #ans 21

##### q5: Write a function that takes two numeric inputs x and y and calculates ((x^2)*y) +  (2*x*y) -(x*(y^2)) #####

polynom <- function(x,y) {
  print ((x^2)*y +  2*x*y -x*(y^2))
}

polynom(9,4) #ans 252

##### q6 Outer Join of two data frames #####

model_data <- read.csv("C:/Users/adams/Downloads/week-3-make-model-data.csv")
price_data <- read.csv("C:/Users/adams/Downloads/week-3-price-data.csv")


inner_join <- merge(x = model_data, y = price_data, by = "ModelNumber")

nrow(inner_join) #ans 27. one of the rows in price data is a model number that we dont have model data for

##### q7 Same as above but this time Left join #####

left_join <- merge(x = price_data, y = model_data, by = "ModelNumber", all.x=TRUE)

nrow(left_join) #ans 28. this time we return the One row even though we dont know what kind of car it is

##### q8 create datafram with only 2010 models #####



models_2010 <- subset(left_join, Year==2010)


##### q9 Take your result from question 7 and subset it so that only the red cars that cost more than $10,000 are included ####


red_cars_10k_plus <- subset(left_join, Color=="Red" & Price > 10000)

##### q10 Take your result from question 9 and subset it so that the ModelNumber and Color columns are removed #####

q10 <- red_cars_10k_plus[,c('ID','Mileage','Price', 'Make', 'Model', 'Year')]

##### q11 Write a function that takes as input a character vector and returns a numeric vector with the numbers of characters in each of the elements in the original vector #####

char_len_vector <- function(input) {
  vector = NULL
  for (i in 1:length(input)) {
    vector = c(vector, nchar(input[i]))
  }
  return(vector)
}
  
example_input <- c("these", "are", "characters", "in", "a", "vector")
char_len_vector(example_input)

##### q12 function that takes two character vectors of equal length and concatenates them element by element with a space as the separator #####

concat_2_vectors <-  function(input_a, input_b) {
  if (length(input_a)==length(input_b)) {
    vector = NULL
    for(i in 1:length(input_a)) {
    vector <- c(vector, paste(input_a[i],input_b[i], sep = " "))
    } 
  }
  else {
    vector <- "Sorry your two inputs are not the same length"
  }  
  return(vector)
}

a <- c("This","answer","question")
b <- c("is","for","twelve")
concat_2_vectors(a,b)

##### q13 Write a function that takes a character vector and returns the substring of three characters that begins with the first vowel in the string (where possible) #####

#install package stringr to use str_replace_all
#install.packages("stringr")
#library(stringr)


three_characters_first_vowel <- function(input) {
  full_string <- NULL
  output <- NULL
  for (i in 1:length(input)){
    full_string <- paste(full_string, input[i])
  }
  full_no_spaces <- str_replace_all(string=full_string, pattern=" ", replace = "")
  
  if(regexpr(pattern ='a',full_no_spaces)[1]>0) 
    {first_a <- regexpr(pattern ='a',full_no_spaces)[1]}
  else {first_a <- NULL}
  
  if(regexpr(pattern ='e',full_no_spaces)[1]>0) 
  {first_e <- regexpr(pattern ='e',full_no_spaces)[1]}
  else {first_e <- NULL}
  
  if(regexpr(pattern ='i',full_no_spaces)[1]>0) 
  {first_i <- regexpr(pattern ='i',full_no_spaces)[1]}
  else {first_i <- NULL}
  
  if(regexpr(pattern ='o',full_no_spaces)[1]>0) 
  {first_o <- regexpr(pattern ='o',full_no_spaces)[1]}
  else {first_o <- NULL}
  
  if(regexpr(pattern ='u',full_no_spaces)[1]>0) 
  {first_u <- regexpr(pattern ='u',full_no_spaces)[1]}
  else {first_u <- NULL}
  
  if(regexpr(pattern ='y',full_no_spaces)[1]>0) 
  {first_y <- regexpr(pattern ='y',full_no_spaces)[1]}
  else {first_y <- NULL}
  
  first_vowel <-min(first_a,first_e,first_i,first_o,first_u,first_y,nchar(full_no_spaces))
  if (first_vowel > nchar(full_no_spaces)-2) {
    output <- "This is not Possible"
  }
  else { output <- substr(full_no_spaces, first_vowel, first_vowel+2) }

  return(output)
}

  
a = c("at")
three_characters_first_vowel(a) # This is not possible
b = c("x", "at")
three_characters_first_vowel(b) # This is not possible
c = c("x", "at", "a")
three_characters_first_vowel(c) # "ata"


##### q14 #####
#Suppose you have a data frame where one column gives the month (in numeric format), the next gives the 
#day, and the third column gives the year. Use R to create such a data frame (by hand is fine) and then add a 
#fourth column with the date in date format



day <- c("01","02","03","04","05")
month <- c("09","10","11","12","01")
year <- c("2011","2012","2013","2014","2015")

df <- data.frame(day,month,year, date=as.Date(paste(year, month, day, sep="-" )))

##### q15 Illustrate the code necessary to take a string of MM-DD-YYYY format and convert it to a date #####


date_bad_format <- c("09-12-14")
date_good_format <- as.Date(date_bad_format, format = "%m-%d-%y")

##### q16 Illustrate the code necessary to take a date and extract the month of the date #####

months(date_good_format)

##### q17 Create a sequence of all of the dates from January 1, 2005, to December 31, 2014 #####

days <- data.frame(day=1:31, ind=1)
months <- data.frame(month=1:12, ind=1)
years <- data.frame(year=2005:2014, ind=1)


days_months <- merge(x = days, y = months, by = "ind", all.x=TRUE)
days_month_years <- merge(x=days_months, y=years, by ="ind", all.x=TRUE)
dates <- data.frame(date=as.Date(paste(days_month_years$year, days_month_years$month, days_month_years$day, sep= "-")))

