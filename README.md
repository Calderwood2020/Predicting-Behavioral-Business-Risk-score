# Predicting-Behavioral-Business-Risk-score

## Project purpose

Conventional behavioral models use 12-24 month performance period. Open Banking gives an opportunity to mine transaction data, As transaction data is streaming data we many not get more than 12 month transactional history. Combining behavioral data with transaction data may improve the credit risk models.So it is necessary to generate behavioral models with less than 12 month duration of performance period

Hence, we built behavioral models with 3 month, 12 month and 24 month snapshot data and did analysis if it is feasible to build credit risk models based on limited length of streamline data.

## Data Discovery

In this project we have used real world dataset provided by consumer credit reporting agency.Thirty-six datasets in total. Each dataset represents a quarterly report between 2006 and 2014; snapshots were taken annually in January, April, July and October.  

Each dataset has over 11 million observations representing unique businesses and 305 potential predictors representing businesses’ general information that contain region, zip code etc , account activities and financial credit information such as business credit risk score etc.

The response variable is the business risk score of the companies. 
