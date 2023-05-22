SELECT * FROM home_1.new_table;

SELECT manuf, price FROM new_table WHERE product_count > 2; 

SELECT product_name FROM new_table WHERE manuf = "Samsung";

SELECT * FROM phones WHERE total_cost > 100000 AND total_cost < 145000;

SELECT product_name, (price * product_count) as total_price 
FROM new_table 
WHERE (price * product_count) > 100000 AND (price * product_count) < 145000; 

SELECT * FROM new_table WHERE product_name LIKE '%Iphone%';

 SELECT * FROM new_table WHERE product_name LIKE '%Galaxy%';
 
 SELECT * FROM products WHERE product_name RLIKE '[0-9]';
 
 SELECT * FROM products WHERE product_name LIKE ' 8%';