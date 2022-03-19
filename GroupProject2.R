#Task: What influence do different features of coffee have on whether the quality of a batch of
#coffee is classified as good or poor?

#upload the libraries 
library(tidyverse)
library(dplyr)
library(readr)
library(purrr)
library(janitor)
library(sjPlot)

#importing and showing the data 
coffee <- read_csv("coffee.csv")
view(coffee)

#check for missing values using sapply
sapply(coffee, function(x) sum(is.na(x)))

#check for number of unique values in country of origin and harvest year using sapply
length(unique(coffee$country_of_origin))
length(unique(coffee$harvested))

#box plots showing the distribution of the quantitative variables  
ggplot(data = coffee, aes(x = Qualityclass, y = aroma, fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Aroma") +
  theme(legend.position = "none")

ggplot(data = coffee, aes(x = Qualityclass, y = flavor, fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Flavor") +
  theme(legend.position = "none")

ggplot(data = coffee, aes(x = Qualityclass, y = acidity, fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Acidity") +
  theme(legend.position = "none")

ggplot(data = coffee, aes(x = Qualityclass, y = category_two_defects, fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Category Two Defects") +
  theme(legend.position = "none")

ggplot(data = coffee, aes(x = Qualityclass, y = altitude_mean_meters, fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Altitude mean (meters)") +
  theme(legend.position = "none")

#bar chart showing the quality class in each country 
ggplot(data = coffee, aes(x = country_of_origin, group = Qualityclass)) +
  geom_bar(aes(y = ..prop..,fill=  Qualityclass),
           stat = "count", position = "dodge")

#bar chart showing the quality class in each harvest year 
ggplot(data = coffee, aes(x = harvested, group = Qualityclass)) +
  geom_bar(aes(y = ..prop..,fill=  Qualityclass),
           stat = "count", position = "dodge")


#table showing the percentage of the quality classes for each country  
coffee %>%
  tabyl(country_of_origin, Qualityclass) %>%
  adorn_percentages() %>%
  adorn_pct_formatting() %>%
  adorn_ns() 


#table showing the percentage of the quality classes for each harvest year   
coffee %>%
  tabyl(harvested, Qualityclass) %>%
  adorn_percentages() %>%
  adorn_pct_formatting() %>%
  adorn_ns() 



#setting the quality class as factor 
coffee$Qualityclass <- as.factor(coffee$Qualityclass)

#fitting the models 
model_1 <- glm(formula = Qualityclass ~ .,family = binomial(link = "logit"),
               data = coffee)
summary(model_1)

model_2 <- glm(formula = Qualityclass ~ country_of_origin +aroma+flavor+acidity+category_two_defects+harvested,family = binomial(link = "logit"),
               data = coffee)
summary(model_2)

model_3 <- glm(formula = Qualityclass ~ country_of_origin +aroma+flavor+acidity+category_two_defects,family = binomial(link = "logit"),
               data = coffee)
summary(model_3)

model_4 <- glm(formula = Qualityclass ~ aroma+flavor+acidity+category_two_defects,family = binomial(link = "logit"),
               data = coffee)
summary(model_4)


model_5 <- glm(formula = Qualityclass ~ aroma+flavor+acidity ,family = binomial(link = "logit"),
               data = coffee)
summary(model_5)

