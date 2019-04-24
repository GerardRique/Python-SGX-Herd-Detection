import os
import numpy as np
import pandas as pd

def get_returns(opening_price, closing_price):
    return 100*(np.log(closing_price) - np.log(opening_price))


def main():
    num_days = 30
    feature_df = pd.DataFrame()
    volumes_df = pd.DataFrame()
    volume_dict = {}
    training_set_directory = os.fsencode("TrainingSet")
    for file in os.listdir(training_set_directory):
        filename = os.fsdecode(file)
        current_data_frame = pd.read_csv("TrainingSet/" + filename, nrows=num_days)
        current_data_frame['returns'] = get_returns(current_data_frame['Close'], current_data_frame['Open'])
        
        total_volume = current_data_frame['Volume'].sum()
        symbol = current_data_frame.loc[0, 'Symbol']
        volume_dict[symbol] = total_volume
        volumes_df.loc[symbol, 'volume'] = total_volume 
        feature_df[symbol] = current_data_frame['returns']

    print(volume_dict)

    #feature_df.index = current_data_frame['Date']


 
    feature_df = feature_df.transpose()
    print(volumes_df.index)
    print(feature_df.index)

    feature_df = feature_df.join(volumes_df)

    feature_df = feature_df.sort_values(by="volume")

    volumes_df.to_csv('volumes.csv', sep=",", encoding='utf-8')
    feature_df.to_csv('features.csv', sep=",", encoding='utf-8')

    for column in feature_df:
        print(feature_df[column])
    


if __name__ == "__main__":
    main()