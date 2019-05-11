library(dplyr)
library(ggplot2)

message("Reading orders data...")
orderDf <- read.csv(file="data/interim/orders/orders_cleaned.csv", sep=",")
partialOrdersDf <- orderDf[c("Order_Session_ID", "Product_Object_ID", "Product_ID")]

# force certain variables to be categorical:
partialOrdersDf$Order_Session_ID <- factor(partialOrdersDf$Order_Session_ID)
partialOrdersDf$Product_Object_ID <- factor(partialOrdersDf$Product_Object_ID)
partialOrdersDf$Product_ID <- factor(partialOrdersDf$Product_ID)
summary(partialOrdersDf)


message("Reading clickstream data...")
clickstreamDf <- read.csv(file="data/interim/clickstream/clickstream_cleaned.csv", sep=",")
partialClickstreamDf <- clickstreamDf[c("Session_ID", "Product_Object_ID", "Product_ID", "Request_Date")]

# force certain variables to be categorical:
#partialClickstreamDf$Session_ID <- factor(partialClickstreamDf$Session_ID)
#partialClickstreamDf$Product_Object_ID <- factor(partialClickstreamDf$Product_Object_ID)
summary(partialClickstreamDf)



# generate some graphs:
message("Generating graphs...")
# most sold: Product_ID vs. ?
product_ids_bar_plot <- ggplot(data = partialOrdersDf) +
  geom_bar(mapping = aes(Product_ID))
ggsave("reports/figures/product-ids-bar-plot.pdf", product_ids_bar_plot)
