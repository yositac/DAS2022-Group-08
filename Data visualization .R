##load packages 
library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(gridExtra)
library(GGally)
library(gapminder)
library(sjPlot)
library(stats)
library(jtools)
library(janitor)
library(purrr)
library(pROC)
library(caret)

# import dataset and remove NA from dataset. 
data.origin <- read_csv("dataset8.csv")
data.no.NA <- data.origin %>% 
  na.omit()

glimpse(data.no.NA)
# Qualityclass act as our response variables, and have a binary response variables (Good/Bad).
# Select variables from data set.


data <- data.no.NA %>% 
  select (Qualityclass,
         harvested,
         altitude_mean_meters,
         category_two_defects,
         acidity,
         flavor,
         aroma)


coeff ##variables selection. It seems only aroma flavor and acidity are highly 
# relevant with coffee quality. 
data$Qualityclass <- ifelse(data$Qualityclass == "Good", 1, 0)
model_1 <- glm(Qualityclass~aroma+flavor+acidity,family = binomial(link="logit"), data=data)
model_1 %>% 
  summ() # fitting information of final model 

levels(data.no.NA$Qualityclass)
modelcoefs <- round(coef(model_1),2)
modelcoefs
## log-odds
confint(model_1) 
plot_model(model_1, show.values = TRUE, transform =NULL,
           title = "Odds (Poor instructor)", show.p = TRUE,
           value.offset = 0.2)

##estimates of the log-odds for our data set. 
log.odds.est <- data.no.NA %>%
  mutate(logodds.poor = predict(model_1))

plot_model(model_1, type = "pred", title = "", par = c(1, 3),
           axis.title = c("Coffee Feature", "Probability of Poor Coffee Quality class"))


##

pair.cor$Qualityclass <- ifelse(pair.cor$Qualityclass == "Good", 1, 0)
#multilinearility checking
corr.variables <- cor(data[-1])
kappa(corr.variables, exact=TRUE)
##kappa value is 21.31, that is lower than 100. it suggest that 

##set up train data and test data. 
train_sub=sample(nrow(data), 8/10*nrow(data))
train_data <- data[train_sub, ]
test_data <- data[-train_sub, ]

##check the fitting information at train_data_set. 
model_for_train_data <- glm(Qualityclass~aroma+flavor+acidity,family = binomial(link="logit"), data=train_data)
model_for_train_data %>% 
  summ() # 
##add predicted data to the test_data_set. In which, 
predict_logistic <- as.numeric(predict(model_for_train_data, 
                                       newdata=test_data,
                                       type="response")>0.5)

conMat <- confusionMatrix(factor(predict_logistic), 
                          factor(test_data$Qualityclass), positive="1")

conMat
roc.cruve <- roc(test_data$Qualityclass,
                 predict_logistic,
                 plot=TRUE, print.thres=TRUE, print.auc=TRUE,
                 levels=c(0,1), direction="<")
