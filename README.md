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
a. Excel

Excel was used as the initial data preparation tool to:
  -  Clean and standardize column formats (dates, numerical fields)
  -  Handle missing and inconsistent values
  -  Validate data integrity before visualization

This step ensured the dataset was structured and analysis-ready before ingestion into PostgreSQL for analysis.

b. SQL

The data was intergrated into PostgreSQl for SQL analysis and data cleaning
  -  Data Collection and Transformation
  -  Trend Analysis
  -  Consolidation of the data tables into Data View
  -  Explanatory analysis and Predictive preparation

c. Power BI

Within Power BI:
  -  Relationships were established between the data view and date table
  -  Measures were created using DAX to calculate:
      -  Total Revenue, Total profit and Total Shipping Cost
      -  Number of customers
      -  Total Customer Orders
      -  Return Rates

Slicers were implemented for dynamic analysis by month, product category, subcategory, profitabilty and return rates.
    
---

## Data Analysis

```sql
-- Total orders per country
SELECT *
FROM(
	SELECT 
	    country,
	    COUNT(*) AS total_orders,
		ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) AS rank_orders_country
	FROM orders
	GROUP BY country
	ORDER BY total_orders DESC
)
WHERE rank_orders_country <= 10;
```
```sql
-- yearly analysis
SELECT
	order_year,
	total_orders,
	total_revenue,
	total_profit,
	total_shippingcost,
	net_profit_yearly,
	ROUND((net_profit_yearly / total_revenue),3) * 100 pec_net_profit_yearly
FROM(
	SELECT 
		EXTRACT(YEAR FROM orderdate) order_year,
		COUNT(*) total_orders,
		ROUND(SUM(sales)::NUMERIC,2) total_revenue,
		ROUND(SUM(profit)::numeric,2) total_profit,
		ROUND(SUM(shippingcost)::numeric,2) total_shippingcost,
		ROUND(SUM(profit)::numeric,2) - ROUND(SUM(shippingcost)::numeric,2) AS net_profit_yearly
	FROM orders
	GROUP BY EXTRACT(YEAR FROM orderdate)
	ORDER BY total_orders DESC
)
```
---
## Project Dashboards

###  1. Overview Dashboard

This dashboard provides a high-level summary of the Sales analysis, focusing on overall performance indicators.

Key KPIs:
  -  Total Revenue
  -  Total Profit
  -  Total Customer Orders
  -  Average Shipping Time

Analytical Insights:
  -  A significant increment in the revenue by Technology, followed Furniture and then Office Supplies.
  -  High revenues were encountered in the months of November and December.
  -  Higher profits of over 60% were encountered by the Standard Class and this was proportional to the number of customer orders
  -  Higher Orders came from the Asian Pacific global market
  -  There was a high rise in Total Revenue from 2014 to 2017
    
 This dashboard functions as an executive summary, offering quick insight into overall revenue, profits and orders.

<img width="755" height="410" alt="PROJECT OVERVIEW PAGE 1" src="https://github.com/user-attachments/assets/07f648e1-75c7-4188-b8ca-5d2f01583e12" />

###  2. Revenue Insight Dashboard

The Revenue Insight Dashboard focuses on revenue and sales analysis, highlighting contribution and performance across different sectors.

Key Insights:
  -  Higher revenues were encountered in the global markets of Asian Pacific and a least revenue was realized in African region
  -  Higher revenues were encountered in the Medium priorities and there was a least priority in the Low priority and this is proportional to the profits.
  -  Copiers, Phones and Bookcases were the higher product subcategories that contributed to the higher performance in profts
  -  Their were higher performance of revenue per week on Mondays, Fridays and Sundays, and this was as a result in the number of orders
 
    
<img width="752" height="410" alt="REVENUE INSIGHT PAGE 2" src="https://github.com/user-attachments/assets/b4da5079-0d15-4743-a512-bbf9b536c607" />

###  3. Customer Insights Dashboard

The Customer Insights Dashboard focuses on the analysis of revenue, profitability, customer orders, return rates and average shipping time

<img width="754" height="412" alt="CUSTOMER INSIGHT PAGE 3" src="https://github.com/user-attachments/assets/b5967809-22b7-45c8-88cb-bc4a3c429ca8" />

---
