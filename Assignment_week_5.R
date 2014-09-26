#Assignment week 5 - Adam Stopek
##### Question 1: Write three questions#####
# How many people voted yes/no in each age group
# How many people voted  yes/no in each city
# What was the final result

#####question 2 ##### 
# Create a data frame with the messy data stored in 2 rows
# The method was to create a data frame out of the five different columns
# I renamed 16-24 to young and 25+ to old to make it easier
# I seperated age and decision by an underscore so that I could easily break them apart later


messy_data <- data.frame (
    "city"= c("edinburgh", "glasgow"),
    "old_yes" = c(143000,150400),
    "old_no" = c(214800, 207000),
    "young_yes" = c(80100, 99400),
    "young_no" = c(35900, 43000)  
   )
messy_data
#city old_yes old_no young_yes young_no
#1 edinburgh  143000 214800     80100    35900
#2   glasgow  150400 207000     99400    43000

##### question 3 #####
#convert to tidy data
#install.packages("tidyr")
library(tidyr)
library(plyr)
library(dplyr)

# first gather all the votes into a signle column
# then split up the key column into two
tidy_data <- (
messy_data %>%
gather(age_decision, votes, -city ) %>%
separate (age_decision, c("age", "decision"), "_")
)
tidy_data
#city   age decision  votes
#1 edinburgh   old      yes 143000
#2   glasgow   old      yes 150400
#3 edinburgh   old       no 214800
#4   glasgow   old       no 207000
#5 edinburgh young      yes  80100
#6   glasgow young      yes  99400
#7 edinburgh young       no  35900
#8   glasgow young       no  43000



##### question 4 #####
#Answer the questions from q1 using plyr

require (plyr)
by_age <- ddply(tidy_data, .(age, decision), summarize, total = sum(votes))
by_age
#age decision  total
#1   old       no 421800
#2   old      yes 293400
#3 young       no  78900
#4 young      yes 179500

by_city <- ddply(tidy_data, .(city, decision), summarize, total = sum(votes))
by_city

#city decision  total
#1 edinburgh       no 250700
#2 edinburgh      yes 223100
#3   glasgow       no 250000
#4   glasgow      yes 249800

total_result <- ddply(tidy_data, .(decision), summarize, total = sum(votes))
total_result

#decision  total
#1       no 500700
#2      yes 472900

##### question 5 #####
# When I started the assignment, I had the end goal in mind.
# I knew I wanted a data structure with 4 coulmns and I worked towrds that goal
# That was why I chose the structure I did
# In regards to the questions asked, 
# I asked the types of questions the ddply can answer but that are also the most important to know

