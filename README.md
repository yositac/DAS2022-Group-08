# DAS2022-Group-08

## Requirement: 
1. model: GLM 
2. summary of findings:
3. presentation slides. 

### Summary needs involved (presentation slides/PPT):
1. Aim; 
2. Exploratory data analysis; 
3. Statistical modelling; 
4. Results,
5. Conclusion;
6. Future work/Extension.

### files needs submitting: 
1. Group_##_Analysis.Rmd
2. Presentation slides: Group_##_Presentation.pdf


### Dataset information: 
Coffee Quality: cut off ponits is 82.5   
Task Questions: do different coffee's features affect the quality in batches.  
8 variables in total. 



 

### Basic classification of variables:   
 
Coffee Feature      | Coffee Quality  | Product origin information |   
--------------------|-----------------|----------------------------|  
Aroma               | Quality Class   |    Country                 |   
Flavor              |                 |  Harvest Year              | 
Acidity             |                 |                            | 
(altitude of Farm)  |                 |                            |  
Count of detect     |                 |                            |


## Methdology- A brief introduction. 
1. Check the data set, such as variables, missing values, data distribution and pairs correlations etc. (Explorancy analysis)
2. Checking **multicollinearity** by kappa function. both of VIF and kappa function could determinate the multicollinearity, the reasone that choose kappa function please check on there: https://stats.stackexchange.com/questions/62853/difference-between-variance-inflation-factor-vif-and-kappa-in-r (formal analysis)
3. Then, we start to build  comparise model. the strategy to estabalish model is top-down approach. start time a model contians all variables. and remove the variables one by one. Evaluate it by AIC BIC and p vlues. (formal analysis)
4. After the final model has been choosen, we calculate the log odd ratio. check this wheather this value fall within confidence inverval. (formal analysis)
5. the probability plot indicates how the probability changed. this could explain how the variables effect the response outcome.(formal analysis) 
7. we also produce an prediction evaluation. if we use our final model to predict the quality class of coffee bean, what the accrancy, sensitivity and specifity of our final model. For this, the ROC and Confusion maxtrix has been used. 








