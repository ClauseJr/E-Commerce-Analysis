# Global Superstore (E-Commerce) Analysis 

## Executive Summary

### Overview Findings

This project demonstrates end-to-end data analysis of retail sales, integrating orders, returns, and regional data into a unified dataset. Analytical relationships were established using SQL views, enabling flexible exploration of denormalized data while maintaining integrity. Key business KPIs; including total sales, profit margins, shipping efficiency, and return rates were calculated to provide actionable insights. 

The dataset was structured for interactive visualization in Power BI, supporting informed, data-driven decision-making and performance evaluation.

The interactive Power BI dashboard enables us to:
  -  Analyze sales performance using descriptive statistics and visual analytics
  -  Identify trends in profitability, shipping efficiency and return rates
  -  Examine products, customers and geographical locations.
  -  Understand temporal patterns in return rates and revenue from the global market.
  -  Develop an interactive dashboard suitable for decision-making and storytelling

### Data Sources
The data spans a wide time range (2014-2018), allowing both sales and modern trend analysis.
The primary dataset of this analysis is from [kaggle.com](https://www.kaggle.com/), containing over 12,000 records.
The data contained three tables, i.e
  -  Orders
  -  Returns
  -  People

Get the whole dataset here [E-Commerce Data](https://www.kaggle.com/datasets/rohitgrewal/global-superstore-data)

---

## Tools Used
a. Excel:
Excel was used as the initial data preparation tool to:
  -  Clean and standardize column formats (dates, numerical fields)
  -  Handle missing and inconsistent values
  -  Validate data integrity before visualization

This step ensured the dataset was structured and analysis-ready before ingestion into PostgreSQL for analysis.

b. SQL:
The data was intergrated into PostgreSQl for SQL analysis and data cleaning
  -  Data Collection and Transformation
  -  Trend Analysis
  -  Explanatory analysis and Predictive preparation

c. Power BI:
Within Power BI:
  -  Relationships were established between songs, artists, and categorical dimensions
  -  Measures were created using DAX to calculate:
      -  Total and average popularity
      -  Song counts and distinct artist counts
      -  Aggregated audio feature values

Filters and slicers were implemented for dynamic analysis by year, artist, and song
    
---
<img width="755" height="410" alt="PROJECT OVERVIEW PAGE 1" src="https://github.com/user-attachments/assets/07f648e1-75c7-4188-b8ca-5d2f01583e12" />

<img width="752" height="410" alt="REVENUE INSIGHT PAGE 2" src="https://github.com/user-attachments/assets/b4da5079-0d15-4743-a512-bbf9b536c607" />

<img width="754" height="412" alt="CUSTOMER INSIGHT PAGE 3" src="https://github.com/user-attachments/assets/d934c5d9-1983-481d-ada4-bf1d8bb96c99" />

