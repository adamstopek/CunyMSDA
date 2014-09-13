 ##### q1 Write a function that takes a vector as input and returns the number of missing values in the vector #####
 
 count_na <- function(input) {
   count=0
   t_f <- is.na(input)
   for (i in 1:length(input)) {
     if (t_f[i]==TRUE) {
       count=count+1
     }
     else {
       count=count
     }
   }
   print(count)
 }
 
vector_with_some_missing <- c("this",NA,"has",NA,"5",NA,"missing",NA,"values",NA)
count_na(vector_with_some_missing) #ans 5
 
 ##### q2 #####
 #Write a function that takes a data frame as input and returns a named vector with the number of missing 
 #values in each column of the data frame. (The names of the entries should be the corresponding column 
 #names of the data frame.) You may use the function from the previous question as part of your solution.
 
 (colnames(days_month_years))
 ncol(days_month_years)
 
 count_na_df  <- function(df) {
       output = data.frame(c(1))
       names <- c(colnames(df)) 
       for (i in 1:length(names)){
           count = 0 
           colname <- names[i]
           column <- subset(df, select=c(colname))
           col_t_f <- is.na(column)
           for (j in 1:nrow(df)) {
               if (col_t_f[j] == TRUE) {
                   count=count+1
                 }
               else {
                   count=count
                 }       
             }
         output = data.frame(output, count)
         }
   
       output <- output[,2:(ncol(df)+1)]
       colnames(output) <- c(names)
       print(output)
     }
 
 df= data.frame(a=c(1,NA), b=c(2,3), d=c(NA,NA))
 count_na_df(df)
 
##### q3 ######
 #Write a function that takes a numeric vector as input and uses it to determine the minimum, the maximum, 
 #the mean, the median, the first quartile, the third quartile, the standard deviation of the vector, and the 
 #number of missing values. Do not use any built-in functions to do this. Return a named list with the eight
 #desired values in an order you deem best. (You may, if you like, use the function you wrote for question 1.)
 
 
 numeric_vector_info <- function(input){
   #Min
   
   without_na <- input[!is.na(input)]
   min = without_na[1]
   for (i in 2:length(without_na)) {
     if (min < without_na[i]) {
       min = min}
     else min=without_na[i]
   }
   output <- c("minimum"=min)
   
   # max
   max = without_na[1]
   for (i in 2:length(without_na)) {
     if (max > without_na[i]) {
       max = max}
     else max=without_na[i]
   }
   output <- c(output, "maximum"=max)
   
   #mean
   avg = sum(without_na)/length(without_na)
   output <- c(output, "mean"=avg)
   
   #median
   ordered <- sort(without_na)
   l <- length(without_na)
   if (l%%2 == 1) {
     middle = (l/2)+.5
     med = ordered[middle]
   }
   else {
     middle_1 = (l/2)
     middle_2 = (l/2)+1
     med = (ordered[middle_1]+ordered[middle_2])/2
   }
   output <- c(output, "median"=med)
   
   #1st and 3rd quartile
   if(l%%2 == 1) {
     bottom_half <- c(ordered[1]:ordered[((l/2)-.5)])
     top_half <- c(ordered[((l/2)+.5)]:ordered[l]) 
   } else {
     bottom_half <- c(ordered[1]:ordered[l/2])
     top_half <- c(ordered[(l/2)+1]:ordered[l])
   }
   first_qrt_b = (l/4)
   first_qrt_t = (l/4)+1
   first_qrt = (bottom_half[first_qrt_b]+bottom_half[first_qrt_t])/2
   third_qrt = (top_half[first_qrt_b]+top_half[first_qrt_t])/2
   output <- c(output, "first_quartile"=first_qrt, "third_quartile" =third_qrt)
   
   
   #missing values
   mv <- length(input)-length(without_na)
   output <- list(c(output, "missing_values"=mv))
   
   print(output)
 }
 
 
 
 
 
 ####q4####
 #Write a function that takes a character or factor vector and determines a) the number of distinct elements in 
 #the vector, b) the most commonly occurring element,  c) the number of times the most commonly occurring 
 #element occurs, d )and the number of missing values. (Be sure to handle ties gracefully.) Have the function 
 #return a named list with the desired information in a logical order.
 
 
 factor_vector_info <- function(input) {
   without_na <- input[!is.na(input)]
   factored <- factor(without_na)
   level_vector <- levels(factored)
   level_num <- length(level_vector)
   factor_table <-table(factored)
   max_count <- max(table(factored))
   
   if (level_num == 1) {
     max_level = without_na[1]
   }
   else {
     first_place_amount = max_count
     second_place_amount = max(sort(factor_table,partial=level_num-1)[level_num-1])
     if (first_place_amount==second_place_amount) {
       max_level = "There is no one max level"
       max_count = paste("The tied levels have ", max_count, "times in each")
     }
     else {
     count = 0
     i=1
      while (i <= level_num) {
        for (j in 1:length(without_na)) {
          if (without_na[j]==level_vector[i]) {count = count+1} else {count = count}
        }
       if (count == max_count) {
         max_level = level_vector[i]
         i=level_num+1
       }  
       else {
         i=i+1  
         }  
      } }
     }
   output <- list(c("distinct_elements"=level_num, "most_occuring_element"=max_level, "how_many_times"=max_count, 
   "missing_values"=(length(input)-length(without_na))))
 return(output)  
 }


 
 ##### q5 #####
 #Write a function that takes a logical vector and determines the number of a) true values, the b) number of false 
 #values, the c) proportion of true values, and the d) number of missing values. Have the function return a named 
 #list with the desired information in a logical order.
 
 logical_vector_info <- function(input) {
    without_na <- input[!is.na(input)]
    v <- data.frame("col1" = without_na)
    vt <- v[which(v$col1 == T),]
    vf <- v[which(v$col1 == F),]
    true_vals<-length(vt) 
    false_vals <-length(vf)
    porportion_of_true <- true_vals/length(input)
    missing_vals <- length(input)-length(without_na)
    output <- list(c("true_values" = true_vals, "false_values" = false_vals, 
                     "proportion_of_true_values"= round(porportion_of_true,2), "missing_values"=missing_vals  ))
 return(output) 
 }


 ##### q6 #####
 
 
# Write a function that takes as its input a data frame and returns a summary of its columns using the 
# functions you write for questions 3-5. You may assume that all columns will be of the three types in those 
# questions. You are expected to use the functions you have written in the previous questions, so you do not 
#have to write them again by scratch. Return the desired information in a format that you deem best. (One 
#suggestion would be a named list of lists, but I leave it to your judgment.)
 
 describe_df <- function(df_input) {
   all_output <- NULL
   number_of_columns <-ncol(df_input)
   col_names <- names(df_input)
   for (z in 1:number_of_columns){
     
     input <- df[,z]
     if (is.numeric(input)==TRUE) {
       
       output <- list(col_names[z],numeric_vector_info(input))
     }
     else if (is.factor(input)==TRUE) {
       output <-list(col_names[z],factor_vector_info(input) ) 
     }
     else {
       output <-list(col_names[z],logical_vector_info(input) ) 
     }
     all_output <- list(all_output,output)
   }
   
   return(all_output)
 }    
  
 v1 <- as.factor(c(1,1,2,3,1,NA,NA))
 v2 <- as.numeric(c(1:5, NA, 6))
 v3 <- as.logical(c(T,F,T,F,F,F,NA))
 df <- data.frame(v1,v2,v3)
 
 describe_df(df)
 
  
