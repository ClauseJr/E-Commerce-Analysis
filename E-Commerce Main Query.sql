SELECT * FROM order_returns;
SELECT * FROM people;
SELECT * FROM orders;

-- EDA Analysis


SELECT * FROM orders;

-- Count of the total customers

SELECT 
	COUNT(DISTINCT customername)
FROM orders;

-- Checking for Duplicates

SELECT 
	rowid, 
	COUNT(*) 
FROM orders 
GROUP BY rowid 
	HAVING COUNT(*) > 1;

-- Total orders by shipping mode
SELECT 
    shipmode,
    COUNT(*) AS total_orders
FROM orders
GROUP BY shipmode
ORDER BY total_orders DESC;

-- Total orders by product segments
SELECT 
    segment,
    COUNT(*) AS total_orders
FROM orders
GROUP BY segment
ORDER BY total_orders DESC;

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

-- Total orders per region
SELECT 
    region,
    COUNT(*) AS total_orders,
	ROUND(SUM(sales)::numeric,2) total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- Total orders by product subcategory
SELECT 
    orderpriority,
    COUNT(*) AS total_orders,
	ROUND(SUM(sales)::NUMERIC,2) total_sales
FROM orders
GROUP BY orderpriority
ORDER BY total_orders DESC;

-- Total orders by product category
SELECT 
    category,
    COUNT(*) AS total_orders
FROM orders
GROUP BY category
ORDER BY total_orders DESC;

-- Total Sales, Profit, ShippingCost by Shipping mode
SELECT
	shipmode,
	total_sales,
	total_profit,
	total_shipping_cost,
	Net_profit,
	ROUND((Net_profit / total_sales),2) AS pec_net_profit
FROM(
	SELECT 
		shipmode,
		ROUND(SUM(sales)::numeric,3) total_sales,
		ROUND(SUM(profit)::numeric,3) total_profit,
		ROUND(SUM(shippingcost)::numeric,3) total_shipping_cost,
		ROUND(SUM(profit)::numeric,3) - ROUND(SUM(shippingcost)::numeric,3) AS Net_profit
	FROM orders
	GROUP BY shipmode
	ORDER BY total_sales DESC
)

-- Total Sales, Profit, ShippingCost by market region
SELECT
	market,
	total_sales,
	total_profit,
	total_shipping_cost,
	Net_profit,
	ROUND((Net_profit / total_sales),5) AS pec_net_profit
FROM(
	SELECT 
		market,
		ROUND(SUM(sales)::numeric,3) total_sales,
		ROUND(SUM(profit)::numeric,3) total_profit,
		ROUND(SUM(shippingcost)::numeric,3) total_shipping_cost,
		ROUND(SUM(profit)::numeric,3) - ROUND(SUM(shippingcost)::numeric,3) AS net_profit
	FROM orders
	GROUP BY market
	ORDER BY total_sales DESC
)

-- Total Sales, Profit, ShippingCost by category
SELECT 
	category,
	ROUND(SUM(sales)::numeric,3) total_sales,
	ROUND(SUM(profit)::numeric,3) total_profit,
	ROUND(SUM(shippingcost)::numeric,3) total_shipping_cost
FROM orders
GROUP BY category
ORDER BY total_sales DESC


-- Total Sales, Profit by orderpriority
SELECT 
	orderpriority,
	ROUND(SUM(sales)::numeric,3) total_sales,
	ROUND(SUM(profit)::numeric,3) total_profit
FROM orders
GROUP BY orderpriority
ORDER BY total_sales DESC

-- shipping analysis(shipping delays)
SELECT 
	(shipdate - orderdate) shipping_days,
	ROUND(AVG(profit)::numeric,2) total_profit
FROM orders
WHERE shipdate >= orderdate
GROUP BY shipping_days
ORDER BY shipping_days

-- Avg shipping days by shipping modes priority
SELECT 
	shipmode,
	ROUND(AVG(shipdate - orderdate),2) avg_shipping_days_priority,
	COUNT(*) total_orders,
	ROUND(SUM(sales)::numeric,2) total_sales
FROM orders
GROUP BY shipmode
ORDER BY avg_shipping_days_priority DESC

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

-- monthly analysis
SELECT
	order_month_num,
	order_month,
	total_orders,
	total_revenue,
	total_profit,
	total_shippingcost,
	net_profit_monthly,
	ROUND((net_profit_monthly / total_revenue),3) * 100 pec_net_profit_monthly
FROM(
	SELECT 
		EXTRACT(MONTH FROM orderdate) order_month_num,
		TO_CHAR(orderdate, 'Mon') order_month,
		COUNT(*) total_orders,
		ROUND(SUM(sales)::NUMERIC,2)total_revenue,
		ROUND(SUM(profit)::numeric,2) total_profit,
		ROUND(SUM(shippingcost)::numeric,2) total_shippingcost,
		ROUND(SUM(profit)::numeric,2) - ROUND(SUM(shippingcost)::numeric,2) AS net_profit_monthly
	FROM orders
	GROUP BY order_month_num, order_month
	ORDER BY  order_month_num
)

