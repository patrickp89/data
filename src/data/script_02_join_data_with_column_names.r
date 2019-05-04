# Joins a CSV data file with its corresponding column names and returns the DataFrame #
readdatawithcolumns <- function(headersFile, dataFile) {
    tmpHeaderNames <- read.csv(file=headersFile, sep=":", header=FALSE)
    headerNames <- tmpHeaderNames$V1
    df <- read.csv(file=dataFile, sep=",", header=FALSE)
    colnames(df) <- headerNames
    return(df)
}

# read the ORDER data and write the dataset that contains proper headers to /tmp/:
orderDf <- readdatawithcolumns(headersFile="data/raw/orders/order_columns.txt", dataFile="data/raw/orders/order_data.csv")
write.csv(orderDf, file="/tmp/orderDf.csv", row.names = TRUE)

# read the CLICKSTREAM data and write the dataset that contains proper headers to /tmp/:
clickstreamDf <- readdatawithcolumns(headersFile="data/raw/clickstream/clickstream_columns.txt", dataFile="data/interim/clickstream/clickstream_data.csv")
write.csv(clickstreamDf, file="/tmp/clickstreamDf.csv", row.names = TRUE)
