<div align="center">
  <img src="./ucdcs.jpg" width="250">
  <h2> Data Science @ UCD </h2>
  <h4>A collection of projects from selected Data Science modules.</h4>
</div>

- [COMP30760 Data Science in Python](https://github.com/rajitbanerjee/data-science-ucd#comp30760-data-science-in-python)
  - [Getting Started](https://github.com/rajitbanerjee/data-science-ucd#getting-started)
  - [A1: Spotify Analysis](https://github.com/rajitbanerjee/data-science-ucd#a1-spotify-analysis)
  - [A2: COVID-19 Mobility Data Analysis](https://github.com/rajitbanerjee/data-science-ucd#a2-covid-19-mobility-data-analysis)
- [COMP30770 Programming for Big Data](https://github.com/rajitbanerjee/data-science-ucd#comp30770-programming-for-big-data)
- [COMP30850 Network Analysis](https://github.com/rajitbanerjee/data-science-ucd#comp30850-network-analysis)
- [Acknowledgements](https://github.com/rajitbanerjee/data-science-ucd#acknowledgements)

---

## COMP30760 Data Science in Python
Autumn Trimester, 2020  

### Getting Started

-   Create and activate the `ds-env` environment.
    ```bash
    conda env create -f environment.yml
    conda activate ds-env
    ```
-   Change to the `python-comp30760` directory, then run `juypter notebook`.
-   The project [notebooks](./python-comp30760/notebooks/) can now be run.

### A1: Spotify Analysis

<img src="python-comp30760/images/spotify-logo.jpg" width=500>

The objective of this assignment is to collect a dataset from one or more open web APIs, and use Python to prepare, analyse, and derive insights from the collected data.  
- **Source:** <http://mlg.ucd.ie/modules/COMP30760/assignment1.html>
- **API chosen:** [Spotify Web API](https://developer.spotify.com/documentation/web-api/)   
- **Data:** [python-comp30760/data/a1/](./python-comp30760/data/a1/) (pre-collected to avoid calling the API with secret tokens which are not included).
- **Notebook:** [a1-spotify-analysis.ipynb](./python-comp30760/notebooks/a1-spotify-analysis.ipynb) 

#### Tasks:

- Data Identification and Collection:
    - Choose one or more public web APIs.
    - Collect data from your API(s) using Python. 
    - Save the collected dataset in JSON format for subsequent analysis.
- Data Preparation and Analysis:
    -   Load the stored JSON dataset, and represent it using an appropriate structure.
    -   Apply any preprocessing steps that might be required to clean, filter or engineer the dataset before analysis.
    -   Analyse, characterise, and summarise the cleaned dataset, using tables and visualisations where appropriate. 
    -   Summarise any insights which you gained from your analysis of the dataset, and suggest ideas for further analysis.

### A2: COVID-19 Mobility Data Analysis

<img src="python-comp30760/images/title.jpg" width=500>

Increasingly, large-scale mobility datasets are being made publicly available for research purposes. This type of data describes the aggregated movement of people across a region or an entire country over time. Mobility data can naturally be represented using a time series, where each day is a different observation. Recently, Google made mobility data available to help researchers to understand the effects of COVID-19 and associated government policies on public behaviour. This data charts movement patterns across different location categories (e.g. work, retail etc). The objective of this assignment is construct different time series representations for a number of countries based on the supplied mobility data, and analyse and compare the resulting series.

- **Source:** <http://mlg.ucd.ie/modules/COMP30760/mobility.html>  
- **Data:** [python-comp30760/data/a2/](./python-comp30760/data/a2/) (three countries selected: _Ireland, New Zealand, USA_)
- **Notebook:** [a2-covid-19-mobility.ipynb](./python-comp30760/notebooks/a2-covid-19-mobility.ipynb) 

#### Tasks:

<ul>
  <li>
  <details>
    <summary>Within-country analysis (for each of the three selected countries separately)</summary>
    <ul>
      <li>
        Construct a set of time series that represent the mobility patterns for the different location categories for
        the country (e.g. workplaces, residential, transit stations etc).
      </li>
      <li>
        Characterise and visualise each of these time series. You may choose to apply
        resampling and/or smoothing in order to provide a clearer picture of the trends
        in the series.
      </li>
      <li>
        Compare and contrast how the series for the different location categories have
        changed over time for the country. To what extent are these series correlated
        with one another?
      </li>
      <li>
        Suggest explanations for any differences that you have observed between the
        time series for the location categories.
      </li>
    </ul>
  </details>
  </li>
  <li>
    <details>
      <summary>Between-country analysis (taking the three selected countries together)</summary>
      <ul>
        <li>
          Construct a set of time series that represent the overall mobility patterns for the
          three countries.
        </li>
        <li>
          Characterise and visualise each of these time series. You may choose to apply
          resampling and/or smoothing in order to provide a clearer picture of the trends
          in the series.
        </li>
        <li>
          Compare and contrast how the overall time series for the three countries have
          changed over time. To what extent are these series correlated with one another?
        </li>
        <li>
          Suggest explanations for any differences that you have observed between the
          time series for the countries.
        </li>
      </ul>
    </details>
  </li>
</ul>

## COMP30770 Programming for Big Data

## COMP30850 Network Analysis

## Acknowledgements
- [Dr. Derek Greene](https://people.ucd.ie/derek.greene)
- [Dr. Anthony Ventresque](https://people.ucd.ie/anthony.ventresque)
