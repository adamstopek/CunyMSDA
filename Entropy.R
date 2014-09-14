##### q1 #####
#Create a function entropy() that takes a vector as input and returns a single numeric value that is the
#entropy of the vector

entropy <- function(d) {
  unique_vals <- unique(d)
  amount_of_unique_vals <- length(unique_vals)
  obs <- length(d)
  ent <- NULL
  for (i in 1:amount_of_unique_vals) {
    count = 0
    for (j in 1:obs) {
      if (d[j] == unique_vals[i]) {
        count=count+1
      }
      else count = count
    }
    pi <- count/obs
    enti = pi*(log2(pi))
    ent <- c(ent, enti)
  }
  return(-(sum(ent)))
}

entropy(entropy.test.file$answer)
# [1] 0.9832692

##### q2 #####
#create infogain() function which takes one attribute and calculates the information gained by adding this partition
# this is a total entropy minus the weighted average of entropy for each partion

infogain <- function(d, a) {
  unique_vals_of_a <- unique(a)
  amount_of_unique_vals_of_a <- length(unique_vals_of_a)
  obs <- length(a)
  df <- data.frame(d,a)
  nj_n_edj <- NULL
  for (i in 1:amount_of_unique_vals_of_a) {
    subset <- df[df$a == unique_vals_of_a[i],]
    nj <- nrow(subset)
    nj_n_edj <- c( nj_n_edj, (nj*entropy(subset$d)/obs))
  }
  return(entropy(d) - sum(nj_n_edj))
}
infogain(entropy.test.file$answer, entropy.test.file$attr1 )
#[1] 2.411565e-05
infogain(entropy.test.file$answer, entropy.test.file$attr2 )
#[1] 0.2599038
infogain(entropy.test.file$answer, entropy.test.file$attr3 )
#[1] 0.002432707


##### q3 #####
#create function decide() which find max gain. It takes a data frame and a number for where target var is and runs on other cols

target <- 4
df <- entropy.test.file
columns_in_df <- ncol(df)
vector_of_cnums <- c(1:columns_in_df)
attributes <- vector_of_cnums[which(vector_of_cnums!=4)] 

d <- df[,target]
a1 <- df[,attributes[1]]
df <- data.frame(d,a1)



decide <- function(input, target) {
  columns_in_df <- ncol(input)
  vector_of_cnums <- c(1:columns_in_df)
  names_of_df <- names(input)
  attr <- setNames(object = vector_of_cnums, nm = names_of_df)
  attributes <- attr[which(attr!=target)]
  gains <- NULL
  d <- input[,target]
  for (i in 1:length(attributes)) {
    a <- input[, attributes[i]]
    gains <- c(gains, infogain(d,a)) 
  }
  gains <- setNames(object = gains, nm = names(attributes))
  maximum <- match(max(gains),gains) 
  output <- list("max" = maximum, "gains" = gains)
  return(output)
}

decide(entropy.test.file,4)

#$max
#[1] 2

#$gains
#attr1        attr2        attr3 
#2.411565e-05 2.599038e-01 2.432707e-03 

