##load library 
library(tidyverse)
library(ggplot2)
library(gridExtra)
library(GGally)

# import dataset and remove NA from dataset. 
data.origin <- read_csv("dataset8.csv")
data.no.NA <- data.origin %>% 
  na.omit()

glimpse(data.no.NA)
# Qualityclass act as our response variables, and have a binary response variables (Good/Bad).
# Select variables from data set.
data.analysis<- data.no.NA %>% 
  select(country_of_origin,
         harvested,
         Qualityclass,
         altitude_mean_meters,
         aroma,
         flavor,
         acidity)

#boxplot of Aroma/Flavor/Acidity/Farm's altitude by Quality class. 
plot.1 <- ggplot(data = data.no.NA, 
       aes(x = Qualityclass,
           y = aroma,
           fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality class", y = "Aroma")+ 
  theme(legend.position = "none")
  

plot.2 <- ggplot(data = data.no.NA, 
       aes(x = Qualityclass,
           y = flavor,
           fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality class", y = "Flavor")+ 
  theme(legend.position = "none")


plot.3 <- ggplot(data = data.no.NA, 
       aes(x = Qualityclass,
           y = acidity,
           fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality class", y = "Acidity")+ 
  theme(legend.position = "none")


#cor between variables. 
pair.cor <- data.no.NA %>% 
  select(Qualityclass,
         harvested,
         altitude_mean_meters,
         aroma,
         flavor,
         acidity,
         category_two_defects) 
pair.cor$Qualityclass <- as.factor(pair.cor$Qualityclass)
#Quality class vs aroma.
plot.4 <- ggplot(data = pair.cor, aes(x = Qualityclass, y = aroma, fill = Qualityclass)) +
  geom_boxplot() +
  labs(x = "Quality class vs aroma.", y = "Aroma") +
  theme(legend.position = "none")

ggpairs(pair.cor) +
  theme(text = element_text(size=10))




