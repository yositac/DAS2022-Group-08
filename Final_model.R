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

##import data 
data <- read.csv("dataset8.csv")

##check for missing values using sapply
sapply(data, function(x) sum(is.na(x)))

##removing missing values
data <- na.omit(data)
glimpse(data)

##replace good/poor with the value 1 and 0
#data$Qualityclass <- ifelse(data$Qualityclass == "Good", 1, 0)

##assign the value to keep in variable
Qualityclass <- data$Qualityclass
country_of_origin <- data$country_of_origin

##standardize variables to have the same scale 
standardize_aroma <- standardize(data$aroma)
standardize_flavor <- standardize(data$flavor)
standardize_acidity <- standardize(data$acidity)
standardize_category_two_defects <- standardize(data$category_two_defects)
standardize_altitude_mean_meters <- standardize(data$altitude_mean_meters)
standardize_harvested <- standardize(data$harvested)

##keep the value as the data frame
standardize <- as.data.frame(cbind(Qualityclass,
                                   country_of_origin,
                                   standardize_aroma,
                                   standardize_flavor,
                                   standardize_acidity,
                                   standardize_category_two_defects,
                                   standardize_altitude_mean_meters,
                                   standardize_harvested))

##convert standardize values in data frame to numeric values
standardize$standardize_aroma <- as.numeric(standardize$standardize_aroma)
standardize$standardize_flavor <- as.numeric(standardize$standardize_flavor)
standardize$standardize_acidity <- as.numeric(standardize$standardize_acidity)
standardize$standardize_altitude_mean_meters <- as.numeric(standardize$standardize_altitude_mean_meters)
standardize$standardize_harvested <- as.numeric(standardize$standardize_harvested)
standardize$Qualityclass <- as.numeric(Qualityclass)

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
                       y = standardize_aroma, 
                       fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Aroma") +
  theme(legend.position = "none")

plot_2  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = standardize_flavor, 
                       fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Flavor") +
  theme(legend.position = "none")

plot_3  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = standardize_acidity, 
                       fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Acidity") +
  theme(legend.position = "none")

plot_4  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = standardize_category_two_defects, 
                       fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality Class", y = "Category Two Defects") +
  theme(legend.position = "none")

plot_5  <-  ggplot(data = data, 
                   aes(x = Qualityclass, 
                       y = standardize_altitude_mean_meters, 
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
                   aes(x = standardize_harvested, 
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

#####################################################
model_2 <- glm(formula = Qualityclass ~ standardize_aroma  ,family = binomial(link = "logit"), data = standardize)
summary(model_2)


#####################################################
model_3 <- glm(formula = Qualityclass ~ 
                 standardize_aroma+
                 standardize_flavor, 
               family = binomial(link = "logit"),data = standardize)
summary(model_3)


#####################################################
model_4 <- glm(formula = Qualityclass ~ 
                 standardize_aroma+
                 standardize_flavor+
                 standardize_acidity, 
               family = binomial(link = "logit"),data = standardize)
summary(model_4)


#####################################################
model_5 <- glm(formula = Qualityclass ~ 
                 standardize_aroma+
                 standardize_flavor+
                 standardize_acidity+
                 standardize_category_two_defects, 
               family = binomial(link = "logit"),data = standardize)
summary(model_5)

