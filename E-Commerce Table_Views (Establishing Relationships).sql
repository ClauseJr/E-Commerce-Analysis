--- CREATING A VIEW TO CONNECT THE 3 TABLES WITH DUPLICATE ORDERS

CREATE OR REPLACE VIEW v_orders_analysis AS
SELECT
    o.RowID,
    o.OrderID,
    o.OrderDate,
    o.ShipDate,
    (o.ShipDate - o.OrderDate) AS shipping_days,

    -- Customer
    o.CustomerID,
    o.CustomerName,
    o.Segment,

    -- Geography
    o.City,
    o.State,
    o.Country,
    o.Region,
    p.Person AS regional_manager,

    -- Product
    o.ProductID,
    o.ProductName,
    o.SubCategory,
    o.Category,

    -- Sales metrics
    o.Sales,
    o.Quantity,
    o.Discount,
    o.Profit,
    o.ShippingCost,

    -- Order attributes
    o.ShipMode,
    o.OrderPriority,
    o.Market,

    -- Returns
    CASE
        WHEN r.Returned = 'Yes' THEN 1
        ELSE 0
    END AS is_returned

FROM orders o
LEFT JOIN order_returns r
    ON o.OrderID = r.OrderID
LEFT JOIN people p
    ON o.Region = p.Region;


SELECT * FROM v_orders_analysis

SELECT
	category,
	ROUND(SUM(sales)::numeric,2) total_revenue,
	ROUND(SUM(profit)::numeric,3) total_profit,
	ROUND(SUM(shippingcost)::numeric,3) total_shipping_cost
FROM v_orders_analysis
GROUP BY category
ORDER BY total_revenue DESC

