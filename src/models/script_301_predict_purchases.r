library(caret)
library(tidyverse)
library(rpart)
library(rpart.plot)


message("\n\n\nLoading data...")
orderDf <- read.csv(file="data/interim/orders/orders_cleaned.csv", sep=",")
partialOrdersDf <- orderDf[c("Product_Family_ID",
                             "Order_Line_Day_of_Week",
                             "Order_Line_Hour_of_Day",
                             "Product_ID",
                             "Gender",
                             "US_State",
                             "Age")]


# force certain variables to be categorical:
partialOrdersDf$Product_Family_ID <- factor(partialOrdersDf$Product_Family_ID)
partialOrdersDf$Order_Line_Day_of_Week <- factor(partialOrdersDf$Order_Line_Day_of_Week)
partialOrdersDf$Order_Line_Hour_of_Day <- factor(partialOrdersDf$Order_Line_Hour_of_Day)
partialOrdersDf$Gender <- factor(partialOrdersDf$Gender)
partialOrdersDf$US_State <- factor(partialOrdersDf$US_State)
summary(partialOrdersDf)


message("\n\n\nTraining the model...")

tree <- rpart(Product_Family_ID ~ Order_Line_Day_of_Week + Gender,
              method="class",
              data=partialOrdersDf,
              cp = 0.0000001)

# print results:
#print(tree)
# print cross-validation results:
printcp(tree)
# pretty-print the resulting tree:
prp(tree)

# TODO:
# Product_Family_ID ~ Order_Line_Day_of_Week + Order_Line_Hour_of_Day,
# ...
# cp = 0.001)
# => 83 splits


#TODO:
# enable cross validation and set the number of folds:
#ctrl <- trainControl(method = "cv",
#                     number = 10)

# Can certain variables predict the Product_Family_ID?
# try a logistic regression:
#productFamilyIdModel1 <- train(Product_Family_ID ~ Order_Line_Day_of_Week + Order_Line_Hour_of_Day,
#                               data = partialOrdersDf,
#                               trControl = ctrl,
#                               method = "glm")
#productFamilyIdModel1
