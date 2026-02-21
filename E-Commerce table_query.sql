DROP TABLE IF EXISTS order_returns;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS people;


-- PEOPLE TABLE
CREATE TABLE people (
    Person VARCHAR(30),
    Region VARCHAR(25)
);


-- ORDERS TABLE
CREATE TABLE orders (
    RowID BIGINT,
    OrderID VARCHAR(30),
    OrderDate DATE,
    ShipDate DATE,
    ShipMode VARCHAR(25),
    CustomerID VARCHAR(25),
    CustomerName VARCHAR(30),
    Segment VARCHAR(15),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(45),
    Region VARCHAR(25),
    Market VARCHAR(20),
    ProductID VARCHAR(15),
    ProductName VARCHAR(150),
    SubCategory VARCHAR(25),
    Category VARCHAR(25),
    Sales FLOAT,
    Quantity INT,
    Discount INT,
    Profit FLOAT,
    ShippingCost FLOAT,
    OrderPriority VARCHAR(25)
);


-- RETURNS TABLE
CREATE TABLE order_returns (
    Returned VARCHAR(5),
    OrderID VARCHAR(30),
    Region VARCHAR(25)
);

SELECT * FROM order_returns;
SELECT * FROM people;
SELECT * FROM orders;

