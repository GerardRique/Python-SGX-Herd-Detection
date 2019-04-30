import pandas as pd

data_set = pd.read_csv('TrainingSet/5FA_20050103_20150602.csv')

start_index = 0
end_index = 0
for index in data_set.index:
    try:
        if((data_set['Close'][index + 1]) >= float(data_set['Close'][index])):
            #print(str(data_set['Close'][index + 1]) + " - " + str(data_set['Close'][index]))
            end_index = index + 1
        else:
            count = end_index - start_index
            if(count > 5):
                print("Count: " + str(count))
                print(str(data_set['Date'][end_index]) + " - " + str(data_set['Date'][start_index]))
                print("")
            start_index = index + 1
            end_index = index + 1
    except KeyError:
        print("End of file")
        