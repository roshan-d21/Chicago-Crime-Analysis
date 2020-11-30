                     DATA ANALYTICS - PROJECT

            TITLE : FORECASTING CRIME - BURGLARY USING ARIMA 

Contributors : Nikhil KR (PES2201800044)
               Roshan Daivajna (PES2201800372)
               Ruchira R Vadiraj (PES2201800602)

The link to the dataset can be found here (https://catalog.data.gov/dataset/crimes-2001-to-present-398a4).
The data is first acquired from the given link and is pre-processed.
The PartI.py file handles data acquisition, data pre-processing and exploratory data analysis.
The refined processed data is saved as a CSV file (output.csv - Download locally).
The second part of the analysis is done in R due to the packages available and ease of use.
The PartII.R file gets the output.csv file and model selection and forecasting is done.
The final result obtained is shown as the output, with the error rates.

NOTE : Forecasting is done on a particular type of crime, Burglary.
Data aggregation and further model selection is done in R due to easy data handling provided by R dataframes.