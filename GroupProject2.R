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
coffee

#bar chart showing the quality class in each country 
ggplot(data = coffee, aes(x = country_of_origin, group = Qualityclass)) +
  geom_bar(aes(y = ..prop..,fill=  Qualityclass),
           stat = "count", position = "dodge") 

#table showing the percentage of the quality classes for each country  
coffee %>%
  tabyl(country_of_origin, Qualityclass) %>%
  adorn_percentages() %>%
  adorn_pct_formatting() %>%
  adorn_ns() 


#setting the quality class as factor 
coffee$Qualityclass <- as.factor(coffee$Qualityclass)

#fitting the fist model 
model_1 <- glm(formula = Qualityclass ~ .,family = binomial(link = "logit"),
              data = coffee)
summary(model_1)

