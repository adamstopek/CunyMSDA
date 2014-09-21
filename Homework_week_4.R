movies <- read.table("C:/Users/adams/Downloads/movies.tab", sep="\t", header=TRUE, quote="", comment="")

##### Find the "Best" "Popular" movies#####
# We have chosen best to mean the highest rating
# Most popular has been chosen to mean the Most number of votes
# We will take a data frame with Year, Rating, and Number of Votes

data <- subset(movies, select=c("year","rating","votes"))
data$rank_rating <-c(rank(data$rating, ties.method = "random" ))
data$rank_votes <-c(rank(data$votes, ties.method = "random" ))
data$weighted_score <- (data$rank_rating+data$rank_votes)/2
data$count <- 1
year_score <- subset(data, select=c("year","weighted_score"))
year_count <- subset(data, select=c("year","count"))


yearly_avg_score <- aggregate(year_score$weighted_score, by=list(year_score$year), FUN=mean, na.rm=TRUE)
yearly_num_movies <- aggregate(year_count$count, by=list(year_count$year), FUN=sum, na.rm=TRUE)
names(yearly_avg_score)<- c("year","average_score")
names(yearly_num_movies)<- c("year","amount_of_movies")

###plyr usage of Join
#install.packages("plyr")
library(plyr)
joined_data <- join(yearly_avg_score, yearly_num_movies, by = "year", type = "inner", match = "all")

#take only years with a minumum of X movies made : example x=200
min_amount_of_movies <- joined_data[joined_data$amount_of_movies>=200,]
answer <- min_amount_of_movies[min_amount_of_movies$average_score==max(min_amount_of_movies$average_score),]
answer



library(ggplot2)
score_plot <- ggplot(data=min_amount_of_movies, aes(x=year, y=average_score)) + geom_line(size=1.5) + geom_point() 
#number_of_movies_plot <- ggplot(data=min_amount_of_movies, aes(x=year, y=amount_of_movies)) + geom_line(size=1.5) + geom_point()

#Graph of score
score_plot
