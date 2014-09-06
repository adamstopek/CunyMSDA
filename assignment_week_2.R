#####Assign the five individuals to a vector called queue#####

queue <- c("James", "Mary", "Steve", "Alex", "Patricia")

##### Update the queue for the arrival of a new patron named Harold #####

queue <- c(queue, "Harold")

#### Update the queue to reflect the fact that James has finished checking out ####

queue <- queue[2:6]

##### Update queue to show Pam budges Steve ####

queue <- c(queue[1], "Pam", queue[2:5])


##### Update the queue to reflect the fact that Harold has grown impatient and left #####

queue <- queue[1:5]

####Update the queue to reflect the fact that Alex has grown impatient and left ##### 
#(Do this as if you do not know what slot Alex currently occupies by number.)

queue <- queue[which(queue!="Alex")] 

##### Identify the position of Patricia in the queue ####

pos <- which(queue=="Patricia") #ans: 4

##### Count the number of people in the queue #####

count <- length(queue) # ans: 4


#### revisit q21 from quiz, now add how many solutions there are ######


quadratic_solver <- function(a,b,c){
  delta <- (b^2)-(4*a*c)
  if (delta > 0) {
    roots <- c((-b + sqrt(delta))/(2*a),(-b - sqrt(delta))/(2*a))
    print("There are two solutions")
    print (roots)
 } 
  else if (delta == 0) {
    root <- -(b/(2*a))
    print("There is one solution")
    print (root)
  }
  else  {
    print("No Solution")
  }
}
 



#### Use R to determine how many numbers from 1 to 1000 are not divisible by any of 3,7, and 11 ####

# The wording is not clear whether you want to know:
#####how many numbers are not divisible by 3 and by 7 and by 11
#######or
#####how many numbers are not divisible by 3, 
#####how many numbers are not divisible by 7, 
#####how many numbers are not divisible by 11

#option 1
count_not_divisible_by_all <- function(num1,num2,num3){
  v <- c(1:1000)
  v_num <- v/(num1*num2*num3)
  t <- NULL
  for (i in 1:1000) {
    check <- v_num[i] == round(v_num[i],0)
    t <- c(check,t) 
  } 
  tfalse <- t[which(t==FALSE)]
  print(length(tfalse))
}

count_not_divisible_by_all(3,7,11) #ans 996 numbers are not divisible by (all) 3, 7 and 11

#option 2
count_not_divisible_by_one <- function(num1){
  v <- c(1:1000)
  v_num <- v/(num1)
  t <- NULL
  for (i in 1:1000) {
    check <- v_num[i] == round(v_num[i],0)
    t <- c(check,t) 
  } 
  tfalse <- t[which(t==FALSE)]
  print(length(tfalse))
}

count_not_divisible_by_one(3) #ans 667 numbers are not divisible by 3
count_not_divisible_by_one(7) #ans 858 numbers are not divisible by 7
count_not_divisible_by_one(11) #ans 910 numbers are not divisible by 11

##### Three inputs and determines whether they form a Pythagorean Triple #####

is_pythagorean_triple <- function(f,g,h){
  v <- sort(c(f,g,h),decreasing=TRUE)
  v[1]^2 == (v[2]^2)+(v[3]^2)
}
  
is_pythagorean_triple(3,4,5) #TRUE
is_pythagorean_triple(1,1,2) #FALSE

