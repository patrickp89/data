import pandas as pandas
from typing import List

# read in line by line into list
rawColumnNames: List[str] = [];
with open(r"orders/order_columns.txt", "r") as f:
    rawColumnNames = list(f)

# split each column at the ':' and take the first part so we have the pure column name
columnNames = list(map(lambda column : column.split(':')[0], rawColumnNames))

# transform csv into data frame with the 
df = pandas.read_csv(r"orders/order_data.csv", names = columnNames)

