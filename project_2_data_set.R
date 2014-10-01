library(ggplot2)
install.packages("corrplot")
library(corrplot)
install.packages("ellipse")
library (ellipse)
install.packages("pROC")
library(pROC)
library(MASS)


wine_quality <- read.csv("C:/Users/adams/Desktop/wine_quality.csv")
wine_quality$quality <- as.integer(wine_quality$quality)
wine_quality$color <- as.factor(wine_quality$color)
summary(wine_quality) 

#### discriptive statitistics #####

#fixed.acidity    volatile.acidity  citric.acid     residual.sugar  
#Min.   : 3.800   Min.   :0.0800   Min.   :0.0000   Min.   : 0.600  
#1st Qu.: 6.400   1st Qu.:0.2300   1st Qu.:0.2500   1st Qu.: 1.800  
#Median : 7.000   Median :0.2900   Median :0.3100   Median : 3.000  
#Mean   : 7.215   Mean   :0.3397   Mean   :0.3186   Mean   : 5.443  
#3rd Qu.: 7.700   3rd Qu.:0.4000   3rd Qu.:0.3900   3rd Qu.: 8.100  
#Max.   :15.900   Max.   :1.5800   Max.   :1.6600   Max.   :65.800  

#chlorides       free.sulfur.dioxide total.sulfur.dioxide    density      
#Min.   :0.00900   Min.   :  1.00      Min.   :  6.0        Min.   :0.9871  
#1st Qu.:0.03800   1st Qu.: 17.00      1st Qu.: 77.0        1st Qu.:0.9923  
#Median :0.04700   Median : 29.00      Median :118.0        Median :0.9949  
#Mean   :0.05603   Mean   : 30.53      Mean   :115.7        Mean   :0.9947  
#3rd Qu.:0.06500   3rd Qu.: 41.00      3rd Qu.:156.0        3rd Qu.:0.9970  
#Max.   :0.61100   Max.   :289.00      Max.   :440.0        Max.   :1.0390  

#pH          sulphates         alcohol      quality    color     
#Min.   :2.720   Min.   :0.2200   Min.   : 8.00   3:  30   red  :1599  
#1st Qu.:3.110   1st Qu.:0.4300   1st Qu.: 9.50   4: 216   white:4898  
#Median :3.210   Median :0.5100   Median :10.30   5:2138               
#Mean   :3.219   Mean   :0.5313   Mean   :10.49   6:2836               
#3rd Qu.:3.320   3rd Qu.:0.6000   3rd Qu.:11.30   7:1079               
#Max.   :4.010   Max.   :2.0000   Max.   :14.90   8: 193               
#                                                 9:   5 

#### Histogram all the variables ####
hist(wine_quality$fixed.acidity)
hist(wine_quality$volatile.acidity)
hist(wine_quality$citric.acid)
hist(wine_quality$residual.sugar)
hist(wine_quality$chlorides)
hist(wine_quality$free.sulfur.dioxide)
hist(wine_quality$total.sulfur.dioxide)
hist(wine_quality$density)
hist(wine_quality$pH)
hist(wine_quality$sulphates)
hist(wine_quality$alcohol)
ggplot(data=wine_quality, aes(x=quality))+  geom_bar()
ggplot(data=wine_quality, aes(x=color)) + geom_bar()


# There are no missing values in this data set


#### Cross Correlations for numeric variables#####
numeric_vars <- subset(wine_quality, select=c(1:12))
numeric_vars$quality <- as.numeric(numeric_vars$quality)
cross_tab <- cor(numeric_vars)
round(cross_tab, 2)


#                        fixed.acidity volatile.acidity citric.acid residual.sugar chlorides       free.sulfur.dioxide total.sulfur density  pH sulphates alcohol quality
                                                                                                                          #.dioxide 
#fixed.acidity                 1.00             0.22        0.32          -0.11      0.30               -0.28                -0.33    0.46 -0.25      0.30   -0.10   -0.08
#volatile.acidity              0.22             1.00       -0.38          -0.20      0.38               -0.35                -0.41    0.27  0.26      0.23   -0.04   -0.27
#citric.acid                   0.32            -0.38        1.00           0.14      0.04                0.13                 0.20    0.10 -0.33      0.06   -0.01    0.09
#residual.sugar               -0.11            -0.20        0.14           1.00     -0.13                0.40                 0.50    0.55 -0.27     -0.19   -0.36   -0.04
#chlorides                     0.30             0.38        0.04          -0.13      1.00               -0.20                -0.28    0.36  0.04      0.40   -0.26   -0.20
#free.sulfur.dioxide          -0.28            -0.35        0.13           0.40     -0.20                1.00                 0.72    0.03 -0.15     -0.19   -0.18    0.06
#total.sulfur.dioxide         -0.33            -0.41        0.20           0.50     -0.28                0.72                 1.00    0.03 -0.24     -0.28   -0.27   -0.04
#density                       0.46             0.27        0.10           0.55      0.36                0.03                 0.03    1.00  0.01      0.26   -0.69   -0.31
#pH                           -0.25             0.26       -0.33          -0.27      0.04               -0.15                -0.24    0.01  1.00      0.19    0.12    0.02
#sulphates                     0.30             0.23        0.06          -0.19      0.40               -0.19                -0.28    0.26  0.19      1.00    0.00    0.04
#alcohol                      -0.10            -0.04       -0.01          -0.36     -0.26               -0.18                -0.27   -0.69  0.12      0.00    1.00    0.44
#quality                      -0.08            -0.27        0.09          -0.04     -0.20                0.06                -0.04   -0.31  0.02      0.04    0.44    1.00


plotcorr(cross_tab)





# Strong Correlations: 
#Alchohol with Density -0.69
#Total Sulfur Dioxide with Free sulfar dioxide 0.72
#Density with Residual Sugar
#Alchoho with Quality

#### What makes a good wine? #####
#This question can be answered using Logistic Regression on Quality 
#Mean value given to quality was between a 5 and 6
#I will create a new variable called above average quality

wine_quality$above_avg_quality <- ifelse(wine_quality$quality<6,0,1)
logistic_model <- glm(above_avg_quality ~   fixed.acidity  + volatile.acidity + citric.acid + residual.sugar  
                      + chlorides +	free.sulfur.dioxide + total.sulfur.dioxide + density + pH +	sulphates
                      + alcohol	+ color , data = wine_quality, family="binomial")

summary(logistic_model)
step_wise <-step(logistic_model, direction = "both")
final_logistic_model <- glm(above_avg_quality ~ fixed.acidity + volatile.acidity + residual.sugar + 
                              free.sulfur.dioxide + total.sulfur.dioxide + density + pH + 
                              sulphates + alcohol,  data = wine_quality, family="binomial")

#Using this model we can predict quality
summary(final_logistic_model)

prob <- predict(final_logistic_model,type=c("response"))
wine_quality$prob <- prob

roc_curve <- roc(above_avg_quality ~ prob, data = wine_quality)
plot(roc_curve) 

# Area under the curve: 0.8123