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
Coffee Quality: cut off points is 82.5   
Task Questions: do different coffee features affect the quality in batches.  
Eight variables in total. 



 

### Basic classification of variables:   
 
Coffee Feature      | Coffee Quality  | Product origin information |   
--------------------|-----------------|----------------------------|  
Aroma               | Quality Class   |    Country                 |   
Flavor              |                 |  Harvest Year              | 
Acidity             |                 |                            | 
(altitude of Farm)  |                 |                            |  
Count of detect     |                 |                            |


## Methodology- A brief introduction. 
1. Check the data set, such as variables, missing values, data distribution and pairs correlations etc. (Explorancy analysis)
2. Checking **multicollinearity** by kappa function. both of VIF and kappa functions could determine the multicollinearity, the reason that chooses kappa function please check on there: https://stats.stackexchange.com/questions/62853/difference-between-variance-inflation-factor-vif-and-kappa-in-r (formal analysis)
3. Then, we start to build a comparison model. the strategy to establish a model is the top-down approach. Start time a model contains all variables. And remove the variables one by one. Evaluate it by AIC BIC and p-values. (formal analysis)
4. After the final model has been chosen, we calculate the log odd ratio. check whether this value falls within confidence intervals. (formal analysis)
5. The probability plot indicates how the probability changed. Those plots could explain how the variables affect the response outcome. (formal analysis) 
7. we also produce a prediction evaluation. If we use our final model to predict the quality class of coffee beans, what is the accuracy, sensitivity and specificity of our final model for this, the ROC and Confusion matrix has been used（Extend analysis）

## Extend Analysis – Prediction Assesment
Confusion Matrix , ROC

## Conclusion
1.Aroma,flavor and acidity affect the quality of coffee. 

2.With the increase of aroma, the probability of good coffee quality increases. Similarly, as flavor and acidity increase, the probability of good coffee quality increases. 

3.The variation of flavor has the greatest impact on the quality of coffee, while the variation of acidity has the least impact on the quality of coffee.

4.All but three of the variables in the final model had very little effect on the quality of the coffee.

5.Futher study: Evaluate the predictive power of the selected model by comparing the values of accuracy, sensitivity, specificity and AUC with the confusion matrix and ROC.






