SELECT * FROM order_returns;
SELECT * FROM people;
SELECT * FROM orders;

-- EDA Analysis
SELECT * FROM orders;

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
SELECT 
    country,
    COUNT(*) AS total_orders
FROM orders
GROUP BY country
ORDER BY total_orders DESC;

-- Total orders per region
SELECT 
    region,
    COUNT(*) AS total_orders
FROM orders
GROUP BY region
ORDER BY total_orders DESC;

-- Total orders by product subcategory
SELECT 
    orderpriority,
    COUNT(*) AS total_orders
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
	ROUND(SUM(sales)::numeric,3) total_sales,
	ROUND(SUM(profit)::numeric,3) total_profit,
	ROUND(SUM(shippingcost)::numeric,3) total_shipping_cost
FROM orders
GROUP BY shipmode
ORDER BY total_sales DESC

-- Total Sales, Profit, ShippingCost by market region
SELECT 
	market,
	ROUND(SUM(sales)::numeric,3) total_sales,
	ROUND(SUM(profit)::numeric,3) total_profit,
	ROUND(SUM(shippingcost)::numeric,3) total_shipping_cost
FROM orders
GROUP BY market
ORDER BY total_sales DESC


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
-- Avg shipping days by shipping modes
SELECT 
	shipmode,
	ROUND(AVG(shipdate - orderdate),2) avg_shipping_days
FROM orders
GROUP BY shipmode
ORDER BY avg_shipping_days DESC

-- yearly analysis
SELECT 
	EXTRACT(YEAR FROM orderdate) order_year,
	ROUND(SUM(sales)::NUMERIC,2)total_revenue
FROM orders
GROUP BY EXTRACT(YEAR FROM orderdate)
ORDER BY total_revenue DESC

-- monthly analysis
SELECT 
	EXTRACT(MONTH FROM orderdate) order_month_num,
	TO_CHAR(orderdate, 'Mon') order_month,
	ROUND(SUM(sales)::NUMERIC,2)total_revenue
FROM orders
GROUP BY order_month_num, order_month
ORDER BY  order_month_num


