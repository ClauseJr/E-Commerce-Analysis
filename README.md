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

## Key Areas of Analysis

### 1.	Revenue Analysis

-	Overall revenue analysis per the global market
-	Revenue analysis of different product subcategory
-	Analysis of sales per week and per month

### 2.	Demographics
-	Consumable products generated higher profits and revenue, since most consumers were consumers.
-	Alot of revenue were discovered from the Asian Pasifc region followed by Europe.
-	Alot of Orders were made from the standard mode of shipment, as a preference of most of the customers.

<img width="422" height="101" alt="MONTHLY ANALYSIS" src="https://github.com/user-attachments/assets/603e4054-d245-4332-8a94-093def341150" />
<img width="223" height="98" alt="RETURNS RATES" src="https://github.com/user-attachments/assets/2eeb597f-797a-4c7e-a66b-28de0b98af4d" />
<img width="284" height="104" alt="PRIORITIES ANALYSIS" src="https://github.com/user-attachments/assets/68feeb89-9211-44df-a58b-f673f1f818f1" />


### 3.	 Product Category and Subcategory
-	Average sales performance of each product category:
	-	Technology 37.58%
	-	Furniture 32.53%
	-	Office Supplies 29.89%
-	The was a margin rise in the net profits of each product category
-	Higher orders were made for Office supplies at over 60%, though the revenue encountered was minimal.
-	Tables product subcategory had no impact in profit generation, since no orders were made by any customer.

### 4.	Customer Orders and Segments
-	Consumable Orders were highly ordered made by alot of customers, followed by corporate orders.
-	Higher orders were made from Asian pacific by segments, product category and subcategory.
-	The return rate of orders was quite low at 11% across the 4 years.

### 5.	Profits and Shipping Cost from sales
-	Higher Profits were encountered from Technology -> Office Supplies -> Furniture and this was proportional to the total shipping cost                                                  
	-	This highlights that the management should maximize on the sales of Technology items such as phones and accessories.
-	Based on the order of Priority, a lot of profits were encountered from the medium class of priorities and least orders were made in the low class of priorities.
-	A lot of profits were made based on the shipping modes as follows
	-	Standard Class Delivery 59.31%
	-	Second Class Delivery 20.25%
	-	First Class Delivery 15.18%
	-	Same Day Delivery 5.25%

---

## Recommendations

-	Onboarding & Mentorship
  
	Strengthen onboarding programs and provide structured career development support during the first 10 years of employment.

-	Compensation Review
  
	Reevaluate salary bands and incentive structures, particularly for Middle levels and finance employees.

-	Retention Programs by Demographic
  
	Design retention programs around life stages rather than gender, with special attention to employees undergoing life transitions (divorce, new singles, etc.).

-	Work-Life Balance Programs
  
	Expand flexible work options and well-being initiatives, especially targeting younger employees who report higher attrition rates.

---

## Limitations & Caveats

-	The dataset is based on HR Analytics Attrition dataset and may not fully reflect a real company.
-	Some variables (e.g., work-life balance) are self-reported, making them subjective and potentially biased.
-	External factors not included in the dataset (e.g. geographic job market conditions) may also influence attrition.

---

##  Conclusion

This project demonstrates the practical application of Excel and Power BI in transforming raw Spotify data into meaningful analytical insights. By combining data preparation, modeling, and interactive visualization, the analysis delivers a comprehensive view of music streaming behavior.

---

## References
1.	SQL for Data Engineering [Data with Baraa](https://www.youtube.com/watch?v=SSKVgrwhzus)
2.	Data Analytics with [Chandoo](https://www.youtube.com/results?search_query=chandoo)


