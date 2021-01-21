# COMP30760 Data Science in Python

## Getting Started

-   Create the `ds-env` environment using `conda env create -f environment.yml`
-   From the root directory (`python-comp30760`), run `juypter notebook`
-   The project notebooks, [a1-spotify-analysis.ipynb](./notebooks/a1-spotify-analysis.ipynb) and [a2-covid-19-mobility.ipynb](./notebooks/a2-covid-19-mobility.ipynb) can now be run.

## Assignment 1

### Overview:

The objective of this assignment is to collect a dataset from one or more open web APIs, and use Python to prepare,analyse, and derive insights from the collected data. The assignment should be implemented as a single Jupyter Notebook (not a script file). Your notebook should be clearly documented, using comments and Markdown
cells to explain the code and results.

### Tasks:

In this assignment you should complete the following tasks:

1.  Data Identification and Collection:

    -   Choose one or more APIs from the list of public web APIs provided at the link below. If you decide to use more than one API, these APIs should be related in some way.  
        <http://mlg.ucd.ie/modules/COMP30760/assignment1.html>

    -   Collect data from your API(s) using Python. Depending on the choice of API, you might need to repeat the collection process multiple times to download sufficient data for analysis.

    -   Save the collected dataset in JSON format for subsequent analysis.

2.  Data Preparation and Analysis:

    -   Load the stored JSON dataset, and represent it using an appropriate structure (i.e. records/items as rows, described by features as columns).

    -   Apply any preprocessing steps that might be required to clean, filter or engineer the dataset before analysis. Where more than one API is used, apply suitable data integration methods.

    -   Analyse, characterise, and summarise the cleaned dataset, using tables and visualisations where appropriate. Clearly explain each step of this process, and interpret the results which are produced. Markdown cells should be used for the explanations and interpretations.

    -   At the end of your notebook, summarise any insights which you gained from your analysis of the dataset. Suggest ideas for further analysis which could be performed on the data in future.

## Assignment 2

### Summary:

Increasingly, large-scale mobility datasets are being made publicly available for research purposes. This type of data describes the aggregated movement of people across a region or an entire country over time. Mobility data can naturally be
represented using a time series, where each day is a different observation. Recently Google made mobility data available to help researchers to understand the 1 effects of COVID-19 and associated government policies on public behaviour. This data charts movement patterns across different location categories (e.g. work, retail etc). The objective of this assignment is construct different time series representations for a number of countries based on the supplied mobility data, and analyse and compare the resulting series.

### Tasks:

Select and download three mobility dataset CSV files for three countries of your choice from the page below. Use these datasets to complete Task 1 and Task 2. <http://mlg.ucd.ie/modules/COMP30760/mobility.html>

#### Task 1: Within-country analysis

For each of the three selected countries separately:

-   Construct a set of time series that represent the mobility patterns for the different location categories for the country (e.g. workplaces, residential, transit stations etc).
-   Characterise and visualise each of these time series. You may choose to apply
    resampling and/or smoothing in order to provide a clearer picture of the trends
    in the series.
-   Compare and contrast how the series for the different location categories have
    changed over time for the country. To what extent are these series correlated
    with one another?
-   Suggest explanations for any differences that you have observed between the
    time series for the location categories.

#### Task 2: Between-country analysis

Taking the three selected countries together:

-   Construct a set of time series that represent the overall mobility patterns for the
    three countries.
-   Characterise and visualise each of these time series. You may choose to apply
    resampling and/or smoothing in order to provide a clearer picture of the trends
    in the series.
-   Compare and contrast how the overall time series for the three countries have
    changed over time. To what extent are these series correlated with one another?
-   Suggest explanations for any differences that you have observed between the
    time series for the countries.
