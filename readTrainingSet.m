TRAINING_SET_SIZE = 50;
NUMBER_OF_COLUMNS = 30;

X = zeros(TRAINING_SET_SIZE, NUMBER_OF_COLUMNS);
training_set_file_list = readdir('TrainingSet');

numFiles = length(training_set_file_list);

sum_volumes_vector = zeros(TRAINING_SET_SIZE, 1);

for i = 3:numFiles
    actual_index = i - 2;
    index_list = strfind(training_set_file_list(i, 1), "csv");
    index = index_list{1, 1};
    result = length(index);

    file_name = training_set_file_list{i, 1};

    full_file_name = strcat("TrainingSet/", file_name);

    [symbol, date_str, open_str, high_str, low_str, close_str, volume_str] = textread(full_file_name, '%s %s %s %s %s %s, %s', 'delimiter', ',');

    volume = str2double(volume_str(2:NUMBER_OF_COLUMNS + 1));

    %Convert opening price vector read from file to real numbers. 
    openVector = str2double(open_str(2:NUMBER_OF_COLUMNS + 1));

    %Convert closing price vector read from file to real numbers.
    closeVector = str2double(close_str(2:NUMBER_OF_COLUMNS + 1));

    currentSumVolume = sum(volume);
    sum_volumes_vector(actual_index, 1) = currentSumVolume;

    %Find the returns for every day for the current stock.
    stockReturns = findReturn(closeVector, openVector);

    stockReturnsTranspose = stockReturns';
    X(actual_index,:) = stockReturnsTranspose;

    %pause;
end

%Add the vector that comtains the sums of volumes so that we can use this column to sort the matrix.'
X = [sum_volumes_vector, X];
X = sortrows(X, 1);

csvwrite("matrix.csv", X);
X = X(:,2:end);
X = X(41:50,:);

m = rows(X)
n = columns(X)
csadList = zeros(n, 1);
equityList = zeros(n, 1);

for j = 1:n
    currentDay = X(:,j);
    equity = mean(currentDay);
    numStocks = length(currentDay);
    currentCSAD = (1/numStocks) .* sum(abs(currentDay - equity));
    csadList(j, 1) = currentCSAD;
    equityList(j, 1) = equity;
end

equity_list_absolute = abs(equityList);
equity_list_squared = equityList.^2;

result_data = [csadList, equityList, equity_list_absolute, equity_list_squared];

csvwrite("octave_data.csv", result_data);



