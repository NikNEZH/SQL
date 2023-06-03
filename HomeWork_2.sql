CREATE DATABASE IF NOT EXISTS home_2; 

USE home_2; 

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2)
);

INSERT INTO sales (product, quantity, price)
VALUES 
('Product 1', 50, 10.99),
('Product 2', 200, 20.55),
('Product 3', 350, 30.00),
('Product 4', 80, 15.99),
('Product 5', 250, 25.00),
('Product 6', 400, 40.00);

SELECT * FROM sales;

SELECT 
    CASE 
        WHEN quantity < 100 THEN 'less than 100' 
        WHEN quantity >= 100 AND quantity <= 300 THEN '100-300' 
        ELSE 'more than 300' 
    END AS sales_segment, 
    COUNT(*) AS sales_count
FROM sales
GROUP BY sales_segment;
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ---------------------------------------------------------

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_name CHAR(45),
    product_name CHAR(45),
    quantity INT,
    price DECIMAL(10,2),
    order_status CHAR(45)
);

INSERT INTO orders (client_name, product_name, quantity, price, order_status)
VALUES 
('John', 'Product 1', 2, 10.99, 'Open'),
('Mike', 'Product 3', 3, 30.00, 'Open'),
('Kate', 'Product 2', 1, 20.55, 'Closed'),
('Tom', 'Product 4', 4, 15.99, 'Open'),
('Jane', 'Product 5', 2, 25.00, 'Closed'),
('Sam', 'Product 6', 1, 40.00, 'Cancelled');

SELECT 
    client_name, 
    product_name, 
    quantity, 
    price, 
    CASE 
        WHEN order_status = 'Open' THEN 'Order is in open state' 
        WHEN order_status = 'Closed' THEN 'Order is the closed' 
        WHEN order_status = 'Cancelled' THEN 'Order is cancelled'
    END AS order_status_text
FROM orders;