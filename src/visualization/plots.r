library(dplyr)
library(ggplot2)
library(ineq)
library(stringr)



orders_raw <- read.csv("data/interim/orders/orders_with_headers.csv")
orders_raw$Brand = unlist(lapply(orders_raw$Product_Level_2_Path, FUN = function(path){return(str_match(path, "\\/.*\\/.*\\/(.*)")[,2])}))

orders <- orders_raw %>%
  distinct(Customer_ID, .keep_all = TRUE) %>%
  filter(as.character(Gender) != "NULL") %>%
  filter(as.character(Age) != "?") %>%
  mutate(Age = as.numeric(as.character(Age))) %>%
  droplevels(exclude=c("NULL"))

# density plot
ggplot(orders, mapping = aes(Age, linetype=Gender)) +
  stat_density(geom="line", size =1.25 )

# lorenz curves
money_spent_per_customer <- orders_raw %>%
  group_by(Customer_ID) %>%
  summarise(Total_Spending = sum(Order_Line_Amount))
  
plot(Lc(money_spent_per_customer$Total_Spending))
  
money_spent_per_brand <- orders_raw %>%
  group_by(Brand) %>%
  summarise(Total_Spending = mean(Order_Line_Amount))

plot(Lc(money_spent_per_brand$Total_Spending))
  




