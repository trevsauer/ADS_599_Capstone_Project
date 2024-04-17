# Applying Time Series Analysis to Tokens in Academic Abstracts

Authors:

* Stephen Reagin
* Trevor Sauerbrey

This repository contains the resources and findings of our graduate data science project for ADS 599 - Capstone Project. The project utilizes time series analysis and natural language processing (NLP) techniques on academic abstracts from arXiv to predict changes in token usage over time.

---

## Motivation

The primary objective of this project was to forecast the frequency of specific token phrases in academic research abstracts, contributing to the broader field of scientometrics. This study addresses the gaps in existing methods that focus on authorship or citation counts and proposes a novel approach for forecasting token trends using time series analysis.

## Methodology

### Data Sources
The datasets utilized in this study were sourced from the open-access arXiv API, which provided extensive metadata from academic abstracts across various disciplines within computer science.

## Data Processing and Analysis
- Tokenization and Cleaning: Abstracts were tokenized into unigrams and bigrams, filtered to remove stopwords and non-informative tokens, and lemmatized to standardize token forms.
- Feature Engineering: Time series curves for token frequencies were developed using moving averages to smooth out day-to-day fluctuations and normalize data scales.
- Modeling: We employed Vector Autoregression (VAR) models, clustered by a novel "integral" similarity technique that groups time series curves based on their shape characteristics.

## Results
- This research project utilized time series analysis to model and forecast token frequencies in academic abstracts over a 13-month validation period, comparing the effectiveness of Vector Autoregression (VAR) models against naïve baseline models. Individual token forecasts showed significant variability, reflecting the challenges of modeling token frequencies which can change abruptly. To assess forecast accuracy and reliability, we applied metrics such as RMSE, MAE, and MAPE, alongside Final Drift, which gauged long-term forecast drift. Our error analysis indicated a Cauchy distribution of errors, with significant deviations among generally accurate predictions, and a comprehensive evaluation of the area difference between actual and predicted curves highlighted cumulative errors across the validation period.

- These results underscore the complexity of forecasting in the domain of academic token usage and highlight both the potential and limitations of applying advanced time series analysis methods to NLP tasks. Future work will focus on refining these models and exploring additional data sources and other modeling techniques to enhance forecasting accuracy.

## Paper
For a detailed discussion of the methods, results, and conclusions of this study, refer to the accompanying paper located in the repository. It includes a comprehensive analysis of the data, methodology, and insights into the implications of our findings on the field of academic research forecasting.

## Navigating the Repository

* `datasets` - all dataset files including:
  * `arxiv_datasets` - raw information from arXiv API
  * `lemmatized_date_df` - raw frequency counts of tokens organized by date
  * `moving_avg_df` - rescaled and normalized moving average frequencies per token
  * `VAR_forecast_results` - validation period predictions of VAR models
* `images` - select image files from the project
* `notebooks` - main working notebooks for EDA and Results
* `r_script` - Vector Autoregression model script
* `scripts`

