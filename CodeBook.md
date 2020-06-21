The variables used are: 

1. fileUrl(chr) - Url from whcih the dataset is to be downloaded 
2. features(factor) - Features from acceleometer and Gyroscope (3 axial time and frequency signals)
3. activity(data.frame) - Activity ID and label
4. sub_test(data.frame) - Test Subject ID which range from 1 to 30
5. sub_train(data.frame) - Training Subject ID which range from 1 to 30
6. X_test(data.frame) - Test set
7. y_test(data.frame) - Test activity labels
8. X_train(data.frame) - Training set
9. y_train(data.frame) - Training activity labels
10. test(data.frame) - Merged test data set with Subject ID, Activity ID and Features
11. train(data.frame) - Merged training data set with Subject ID, Activity ID and Features
12. TestNTrain(data.frame) - Overall merged data set obtained by combining test and train
13. cols(num) - Indices of column to be extracted from TestNTrain
14. idVar(chr) - ID variables which won't be melted
15. measureVar(chr) - Measure variables which will be melted suitably to idVar
16. meltedData(data.frame) - Melted data set
17. AvgData(data.frame) - Data set casted to represent the mean for each subject and activity

Tranformations performed:

1. Merged sub_test, y_test and X_test to obtain test
2. Merged sub_train, y_train and X_train to obtain train
3. Merged test and train to obtain TestNTrain
4. Extracted the required features from TestNTrain
5. Added Activity label and then changed the order to make Activity label third column to TestNTrain
6. Changed column names of TestNTrain to make it more descriptive
7. Melted TestNTrain
8. Casted the melted data to find the average for each activity and subject
