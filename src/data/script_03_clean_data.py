import pandas as pd
import os
import os.path

def clean_file(file_path: str) -> pd.DataFrame:
    """ Cleans a given CSV file from NaN values etc. and returns the data frame. """
    print('Loading file ' + file_path)
    if os.path.isfile(file_path):
        df = pd.read_csv(file_path, encoding = "latin-1")
        print('1. Removing empty rows and columns')
        df_without_na_rows = df.dropna(how = "all")
        df_without_na_rows_and_cols = df_without_na_rows.dropna(axis = 1, how = "all")
        return df_without_na_rows_and_cols
    else:
        print('The data file does not exist!')


def clean_order_data() -> pd.DataFrame:
    """ Reads and cleans the order data. """
    return clean_file(r'data/interim/orders/orders_with_headers.csv')

def clean_clickstream_data() -> pd.DataFrame:
    """ Reads and cleans the clickstream data. """
    return clean_file(r'data/interim/clickstream/clickstream_with_headers.csv')

cdf = clean_clickstream_data()
cdf.to_csv(r'/tmp/tmp_data.csv', encoding = 'latin-1')
