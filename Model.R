library(tidyverse)
library(psych)
library(ggcorrplot)
library(plotly)
library(leaps)
library(caret)
library(car)
library(reshape2)    

df <- read.csv(file = "finaldata2.csv")
df$Status<-factor(df$Status)
main_data=subset(df, select=-c(Country,Status))

corr<-data.frame(cor(main_data))
 
ggcorrplot(cor(main_data), hc.order = TRUE,show.diag = FALSE,type="lower",lab=TRUE,
           insig = "blank",digits = 2,lab_size=3)+ labs(title = "Correlation Matrix")


model1 <- lm(Life.expectancy ~., data = main_data)
summary(model)



models <- regsubsets(Life.expectancy~., data = main_data, nvmax = 5)
summary(models)





vif(model1)
1/vif(model1)
mean(vif(model1))
data.frame(vif(model1))

fit2 <- lm(Life.expectancy ~Income.composition.of.resources+Adult.Mortality+Alcohol
                 , data = main_data)
summary(fit2)

set.seed(1)
sample=sample(1:nrow(main_data),size=nrow(main_data)*.7)
train<-main_data[sample,] #Select the 80% of rows
test<-main_data[-sample,] #Select the 20% of rows
fit2 = lm(Life.expectancy~Adult.Mortality+Alcohol+percentage.expenditure+Diphtheria+HIV.AIDS+Income.composition.of.resources,train)
predicted=predict(fit2,test,type="response")
actuals_preds <- data.frame(cbind(actuals=test$Life.expectancy, predicteds=predicted))
min_max_accuracy <- mean(apply(actuals_preds, 1, min) / apply(actuals_preds, 1, max))
R2 = R2(predicted, test$Life.expectancy)
print(paste("R2 Error Rate: " ,R2))
print(paste("Error Rate: " ,RMSE(predicted, test$Life.expectancy)))
print(paste("Accuracy: " ,min_max_accuracy*100))


