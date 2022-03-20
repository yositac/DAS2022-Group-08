#What influence do different features of coffee have on whether the quality of a batch of coffee is classified as good or poor?

#Data Wrangling
##import library
library(tidyverse)
library(moderndive)
library(gapminder)
library(sjPlot)
library(stats)
library(jtools)
library(janitor)
library(GGally)
library(dplyr)
library(readr)
library(purrr)
library(ggplot2)
library(gridExtra)
library(rcompanion)

##import data 
data <- read.csv("dataset8.csv")

##check for missing values using sapply
sapply(data, function(x) sum(is.na(x)))

##removing missing values
data <- na.omit(data)
glimpse(data)

##replace good/poor with the value 1 and 0
data$Qualityclass <- ifelse(data$Qualityclass == "Good", 1, 0)

##assign the value to keep in variable
Qualityclass <- data$Qualityclass
country_of_origin <- data$country_of_origin

##check for number of unique values in country of origin and harvest year using sapply
length(unique(data$country_of_origin))
length(unique(data$harvested))


#Exploratory Analysis
##correlation between variables. 
pair_cor <- data %>% 
    select(Qualityclass,
           harvested,
           altitude_mean_meters,
           aroma,
           flavor,
           acidity,
           category_two_defects) 
pair_cor$Qualityclass <- as.factor(pair_cor$Qualityclass)


#Quality class vs aroma.
plot_1  <-  ggplot(data = pair_cor, 
                   aes(x = Qualityclass, 
                       y = aroma, 
                       fill = Qualityclass)) +
            geom_boxplot() +
            labs(x = "Quality class vs aroma.", y = "Aroma") +
            theme(legend.position = "none")

ggpairs(pair_cor) +
    theme(text = element_text(size=10))


##box plots showing the distribution of the quantitative variables  
plot_1  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = aroma, 
                       fill = Qualityclass)) +
            geom_boxplot() +
            labs(x = "Quality Class", y = "Aroma") +
            theme(legend.position = "none")

plot_2  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = flavor, 
                       fill = Qualityclass)) +
            geom_boxplot() +
            labs(x = "Quality Class", y = "Flavor") +
            theme(legend.position = "none")

plot_3  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = acidity, 
                       fill = Qualityclass)) +
            geom_boxplot() +
            labs(x = "Quality Class", y = "Acidity") +
            theme(legend.position = "none")

plot_4  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = category_two_defects, 
                       fill = Qualityclass)) +
            geom_boxplot() +
            labs(x = "Quality Class", y = "Category Two Defects") +
            theme(legend.position = "none")

plot_5  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = altitude_mean_meters, 
                       fill = Qualityclass)) +
            geom_boxplot() +
            labs(x = "Quality Class", y = "Altitude mean (meters)") +
            theme(legend.position = "none")


#bar chart showing the quality class in each country 
plot_6  <-  ggplot(data = data, 
                   aes(x = country_of_origin, 
                       group = Qualityclass)) +
            geom_bar(aes(y = ..prop..,fill=  Qualityclass),
                     stat = "count", position = "dodge")

#bar chart showing the quality class in each harvest year 
plot_7  <-  ggplot(data = data, 
                   aes(x = harvested, 
                       group = Qualityclass)) +
            geom_bar(aes(y = ..prop..,fill=  Qualityclass),
                     stat = "count", position = "dodge")

#table showing the percentage of the quality classes for each country  
data %>%
    tabyl(country_of_origin, Qualityclass) %>%
    adorn_percentages() %>%
    adorn_pct_formatting() %>%
    adorn_ns() 

#table showing the percentage of the quality classes for each harvest year   
data %>%
    tabyl(harvested, Qualityclass) %>%
    adorn_percentages() %>%
    adorn_pct_formatting() %>%
    adorn_ns()


#setting the quality class as factor 
coffee$Qualityclass <- as.factor(coffee$Qualityclass)

model_1 <- glm(formula = Qualityclass ~ .,family = binomial(link = "logit"),
               data = data)
summ(model_1)    

model_2 <- glm(formula = Qualityclass ~ country_of_origin +aroma+flavor+acidity+category_two_defects+harvested,family = binomial(link = "logit"),
               data = data)
summ(model_2)

model_3 <- glm(formula = Qualityclass ~ country_of_origin +aroma+flavor+acidity+category_two_defects,family = binomial(link = "logit"),
               data = data)
summ(model_3)model_1

model_4 <- glm(formula = Qualityclass ~ aroma+flavor+acidity+category_two_defects,family = binomial(link = "logit"),
               data = data)
summ(model_4) 

#best model
model_5 <- glm(formula = Qualityclass ~ aroma+flavor+acidity ,family = binomial(link = "logit"),
               data = data)
summ(model_5)


#compare 5 models
compareGLM(model_1, model_2, model_3, model_4,model_5)
 
#Odds Plot
plot_model(model_5, show.values = TRUE, transform = NULL,
           title = "Log-Odds (features)", show.p = FALSE)

#Confidence intervals
confint(model_5) 

