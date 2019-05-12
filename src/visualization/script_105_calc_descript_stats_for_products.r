library(dplyr)
library(ggplot2)

message("\n\nReading orders data...")
orderDf <- read.csv(file="data/interim/orders/orders_cleaned.csv", sep=",")
partialOrdersDf <- orderDf[c("Order_Session_ID", "Product_Object_ID",
                             "Product_ID", "Order_Amount", "Order_Day_of_Week",
                             "Product_Creation_Date")]

# force certain variables to be categorical:
partialOrdersDf$Order_Session_ID <- factor(partialOrdersDf$Order_Session_ID)
partialOrdersDf$Product_Object_ID <- factor(partialOrdersDf$Product_Object_ID)
partialOrdersDf$Product_ID <- factor(partialOrdersDf$Product_ID)
summary(partialOrdersDf)


message("\n\nReading clickstream data...")
clickstreamDf <- read.csv(file="data/interim/clickstream/clickstream_cleaned.csv", sep=",")
partialClickstreamDf <- clickstreamDf[c("Session_ID", "Product_Object_ID", "Product_ID", "Request_Date")]

# force certain variables to be categorical:
partialClickstreamDf$Session_ID <- factor(partialClickstreamDf$Session_ID)
partialClickstreamDf$Product_Object_ID <- factor(partialClickstreamDf$Product_Object_ID)
partialClickstreamDf$Product_ID <- factor(partialClickstreamDf$Product_ID)
summary(partialClickstreamDf)



# generate some graphs:
message("\n\nGenerating graphs...")

### most ordered products by Product_ID ###
message("\n\ --most ordered products by Product_ID:")
# pick the 15 Product_IDs with the highest frequency count ('n' is introduced by dplyr!), ignoring '?' IDs:
mostOrderedProductsDf <- partialOrdersDf %>%
  count(Product_ID) %>%
  arrange(desc(n)) %>%
  slice(2:16)
head(mostOrderedProductsDf)
# plot them (use the 'identity' stat to be able to provide our own frequency got as y axis):
most_ordered_product_ids_bar_plot <- ggplot(data = mostOrderedProductsDf) +
  geom_bar(mapping = aes(x = Product_ID, y = n), stat = "identity")
ggsave("reports/figures/most-ordered-product-ids-bar-plot.pdf", most_ordered_product_ids_bar_plot)


### most ordered product families by Product_Family_ID ###
# TODO: ...


### most clicked products by Product_ID ###
message("\n\ --most clicked products by Product_ID:")
mostClickedProductsDf <- partialClickstreamDf %>%
  count(Product_ID) %>%
  arrange(desc(n)) %>%
  slice(2:16)
head(mostClickedProductsDf)
most_clicked_product_ids_bar_plot <- ggplot(data = mostClickedProductsDf) +
  geom_bar(mapping = aes(x = Product_ID, y = n), stat = "identity")
ggsave("reports/figures/most-clicked-product-ids-bar-plot.pdf", most_clicked_product_ids_bar_plot)


# TODO: Product_ID vs. Order_Day_of_Week
# TODO: Product_ID vs. Order_Amount
# TODO: the oldest/youngest product in store (Product_Creation_Date)?
