
##### load Data #####
movies <- read.table("C:/Users/adams/Downloads/movies.tab", sep="\t", header=TRUE, quote="", comment="")

##### q1 Visualize movies per decade ##### 
movies$decade <- round((movies$year/10),0)*10
movies$count <- 1
movies_per_decade <- subset(movies,  select = c("decade", "count"))
freq <- table(movies_per_decade$count, movies_per_decade$decade)
barplot(freq, ylim=c(0,20000), main="Movies per Decade", xlab="Decade", ylab="Number of Movies", col="blue")

##### q2 Average IMDB rating per genre over time #####
ratings_and_category <- subset(movies,  select = c("decade", "rating", "Action", "Comedy", "Drama", "Documentary", "Romance", "Short"))


mdata <- melt(ratings_and_category, id=c("decade","rating"))
mdata <- mdata[mdata$value==1,]
rownames(mdata) <- NULL
names(mdata)[names(mdata)=="variable"] <- "category"



# movie ratings per category (all time)
rating_category <- subset(mdata,  select = c(2:3))
avg_rating_per_cat <- subset(aggregate(rating_category, by=list(rating_category$category), FUN=mean, na.rm=TRUE), select= c(1:2))
names(avg_rating_per_cat)<- c("Category","Average_Rating")
ggplot(data=avg_rating_per_cat, aes(x=Category, y=Average_Rating, fill=Category)) + geom_bar(stat="identity")


#movie ratings over time per category
rating_category_decade <- subset(mdata,  select = c(1:3))
avg_rating_per_cat_per_decade <- aggregate(rating_category_decade, by=list(rating_category_decade$decade, rating_category_decade$category), FUN=mean)
avg_rating_per_cat_per_decade <- subset(avg_rating_per_cat_per_decade,  select = c(1,2,4))
names(avg_rating_per_cat_per_decade)<- c("Decade","Category","Average_Rating")
ggplot(data=avg_rating_per_cat_per_decade, aes(x=Decade, y=Average_Rating, group=Category, color=Category)) + geom_line(size=1.5) + geom_point() 

##### q3 relation between length and rating?#####
#I chose to do a linear regression model on Rating (Y) and Length(X)
df <- subset(movies,  select = c("length", "rating"))
fit <- lm(rating ~ length, data=df)
summary(fit)


###Output
#Call:
#  lm(formula = rating ~ length, data = df)

#Residuals:
#  Min      1Q  Median      3Q     Max 
#-5.0182 -0.9268  0.1549  1.0786  4.0120 
#
#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  6.0214706  0.0135013 445.991  < 2e-16 ***
#  length      -0.0010763  0.0001444  -7.455 9.09e-14 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 1.552 on 58786 degrees of freedom
#Multiple R-squared:  0.0009446,  Adjusted R-squared:  0.0009276 
#F-statistic: 55.58 on 1 and 58786 DF,  p-value: 9.087e-14

###Explanation of Output: 
#R-squared is REALLY small so that means that the relation between them is VERY negligable, 
#however P-Value on length Beta Estimate is significant 

##This means that length DOES effect rating but the relationship is WEAK

##### q4 relationship between length and genre? #####
#I chose to fit a multiple linear model here. Genre columns are binary so it works well.
length_and_categories <- subset(movies,  select = c("length", "Action", "Comedy", "Drama", "Documentary", "Romance", "Short"))
fit <- lm(length ~ Action + Comedy +Drama + Documentary + Romance + Short, data=length_and_categories)
summary(fit)

###Output
#Call:
#  lm(formula = length ~ Action + Comedy + Drama + Documentary + 
#       Romance + Short, data = length_and_categories)
#
#Residuals:
#  Min     1Q Median     3Q    Max 
#-94.8   -9.6   -2.2    6.8 5128.4 
#
#Coefficients:
#  Estimate Std. Error  t value Pr(>|t|)    
#(Intercept)  91.6191     0.2408  380.466  < 2e-16 ***
#  Action        6.8585     0.4997   13.725  < 2e-16 ***
#  Comedy       -1.1116     0.3144   -3.536 0.000407 ***
#  Drama         7.1579     0.3015   23.742  < 2e-16 ***
#  Documentary  -1.9708     0.5896   -3.342 0.000831 ***
#  Romance       6.4203     0.5008   12.821  < 2e-16 ***
#  Short       -78.0624     0.3781 -206.463  < 2e-16 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 32.41 on 58781 degrees of freedom
#Multiple R-squared:  0.4659,  Adjusted R-squared:  0.4659 
#F-statistic:  8546 on 6 and 58781 DF,  p-value: < 2.2e-16

###Explanation of Output:
#Here opposed to last model we have a pretty good R-Squared which means yes there is a relation between length and genre
#All of the estimates are significant which is great. this means that each genre has an effect on the model

#Explanation of estimates
#Actions, Dramas, Romances are Long
#Comedy, Documentary, and (obviously) Short are short


###Yes there is a relation between length and genre!!!

##### q5 which other variable(s) predict amount of votes? #####
# I will use a correlation matrix to calculate the correlation between every two variables
# We can only pay attention to votes vs others but this will tell us a lot about other relationships
#budget is mostly NA (unknow) so I wont use it, rating will be used instead of distirubtion of ratings
# I will check Age (2005-year), length, rating, mpaa (transformed to binary), genres
movies$age <- 2005-movies$year
movies$mpaa_r <-ifelse(movies$mpaa=="R", 1, 0)
movies$mpaa_pg13 <-ifelse(movies$mpaa=="PG-13", 1, 0)
movies$mpaa_pg <-ifelse(movies$mpaa=="PG", 1, 0)
movies$mpaa_nc17 <-ifelse(movies$mpaa=="NC-17", 1, 0)

vars <- subset(movies, select = c("votes","age", "length", "rating", "mpaa_r", "mpaa_pg13", "mpaa_pg", "mpaa_nc17","Action", "Comedy", "Drama", "Documentary", "Romance", "Short" ))
ctab <- cor(vars)
round(ctab, 2)

#Output:
#             votes   age length rating mpaa_r mpaa_pg13 mpaa_pg mpaa_nc17 Action Comedy Drama Documentary Romance Short
#votes        1.00 -0.09   0.12   0.10   0.17      0.20    0.08      0.01   0.11   0.02  0.05       -0.03    0.05 -0.07
#age         -0.09  1.00  -0.15   0.07  -0.23     -0.12   -0.08     -0.01  -0.10   0.08 -0.03       -0.10    0.00  0.10
#length       0.12 -0.15   1.00  -0.03   0.10      0.07    0.03      0.01   0.11  -0.10  0.24       -0.07    0.11 -0.68
#rating       0.10  0.07  -0.03   1.00  -0.08     -0.01   -0.02     -0.01  -0.12   0.01  0.11        0.12    0.04  0.15
#mpaa_r       0.17 -0.23   0.10  -0.08   1.00     -0.03   -0.02      0.00   0.10  -0.01  0.07       -0.04    0.04 -0.11
#mpaa_pg13    0.20 -0.12   0.07  -0.01  -0.03      1.00   -0.01      0.00   0.08   0.05  0.03       -0.02    0.07 -0.06
#mpaa_pg      0.08 -0.08   0.03  -0.02  -0.02     -0.01    1.00      0.00   0.01   0.04  0.00        0.00    0.03 -0.04
#mpaa_nc17    0.01 -0.01   0.01  -0.01   0.00      0.00    0.00      1.00   0.00   0.00  0.01        0.00    0.00 -0.01
#Action       0.11 -0.10   0.11  -0.12   0.10      0.08    0.01      0.00   1.00  -0.08  0.01       -0.07   -0.02 -0.10
#Comedy       0.02  0.08  -0.10   0.01  -0.01      0.05    0.04      0.00  -0.08   1.00 -0.26       -0.14    0.11  0.11
#Drama        0.05 -0.03   0.24   0.11   0.07      0.03    0.00      0.01   0.01  -0.26  1.00       -0.17    0.10 -0.23
#Documentary -0.03 -0.10  -0.07   0.12  -0.04     -0.02    0.00      0.00  -0.07  -0.14 -0.17        1.00   -0.07  0.06
#Romance      0.05  0.00   0.11   0.04   0.04      0.07    0.03      0.00  -0.02   0.11  0.10       -0.07    1.00 -0.10
#Short       -0.07  0.10  -0.68   0.15  -0.11     -0.06   -0.04     -0.01  -0.10   0.11 -0.23        0.06   -0.10  1.00

##The question asked for only the first row of the output
#The variables that are the most correlated with VOTES are: pg13 ratings, R ratings, length, and action movies




