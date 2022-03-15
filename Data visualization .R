##load library 
library(tidyverse)
# import dataset and remove NA from dataset. 
data.origin <- read_csv("dataset8.csv")
data.no.NA <- data.origin %>% 
  na.omit()

glimpse(data.no.NA)
## Qualityclass as our response variables,, 






