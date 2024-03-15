CREATE DATABASE swiggy;
USE swiggy;

CREATE TABLE customers (
user_id INT PRIMARY KEY,
name VARCHAR(30),
email VARCHAR(45) NOT NULL,
password VARCHAR(30) NOT NULL
);


CREATE TABLE restaurants(
r_id INT PRIMARY KEY,
r_name VARCHAR(30),
cuisine VARCHAR(30)
);

CREATE TABLE food(
f_id INT,
f_name VARCHAR(30),
f_type VARCHAR(30),
PRIMARY KEY (f_id)
);

CREATE TABLE menu(
menu_id INT,
restaurant_id INT,
food_id INT,
price INT,
PRIMARY KEY (menu_id),
FOREIGN KEY (restaurant_id) REFERENCES restaurants (r_id),
FOREIGN KEY (food_id) REFERENCES food (f_id)
);


CREATE TABLE delivery_partner(
partner_id INT PRIMARY KEY,
partner_Name VARCHAR(30)
);


CREATE TABLE orders(
order_id INT PRIMARY KEY,
user_id INT,
restaurant_id INT,
partner_id INT,
date date,
delivery_time INT,
delivery_rating INT,
restaurant_rating INT,
amount INT,
FOREIGN KEY (user_id) REFERENCES customers (user_id),
FOREIGN KEY (restaurant_id) REFERENCES restaurants (r_id),
FOREIGN KEY (partner_id) REFERENCES delivery_partner (partner_id)
);

CREATE TABLE order_details(
id INT PRIMARY KEY,
order_id INT,
food_id INT,
FOREIGN KEY (food_id) REFERENCES food (f_id)
);

-- import data
-- Add foreign key to order_details referencing orders table

ALTER TABLE order_details ADD CONSTRAINT FOREIGN KEY (order_id) REFERENCES orders (order_id);

SELECT * FROM customers;
SELECT * FROM delivery_partner;
SELECT * FROM food;
SELECT * FROM menu;
SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM restaurants;


-- -----------------------------------------------------------------------------

-- Q1. Find customers who have never ordered

SELECT name FROM customers
WHERE user_id NOT IN (SELECT distinct user_id from orders);


-- Q2. Find average price per dish

SELECT f.f_name, ROUND(AVG(price), 2) AS avg_price
FROM menu m
JOIN food f 
ON f.f_id = m.food_id
GROUP BY f.f_name
ORDER BY avg_price;

-- Q3. Find top restaurant in terms of number of orders for a given July month.

SELECT r.r_name, COUNT(*) as Orders
FROM orders o 
JOIN restaurants r
ON r.r_id = o.restaurant_id
WHERE MONTHNAME(date) like 'July'
GROUP BY r.r_name
ORDER BY Orders DESC
LIMIT 1;


-- Q4. Find names of restaurants with monthly sales greater than 800

SELECT DISTINCT r_name FROM (
SELECT r.r_name, MONTH(o.date) AS months, SUM(o.amount) AS revenue
FROM orders o
JOIN restaurants r
ON r.r_id = o.restaurant_id
GROUP BY r.r_name, months
HAVING  revenue > 800) rest;


-- Q5. Show all the orders with order details for a particular customer between 10th Jun and 10th July 2022.
-- Customer : Ankit

SELECT o.order_id, o.amount, 
	   r.r_name as 'Restaurant',
       f.f_name as food
FROM orders o
JOIN restaurants r
ON r.r_id = o.restaurant_id
JOIN order_details od
ON od.order_id = o.order_id
JOIN food f
ON f.f_id = od.food_id
WHERE o.user_id = (SELECT user_id FROM customers WHERE name = 'Ankit')
AND o.date between '2022-06-10' AND '2022-7-10';


-- Q6. Find restaurant with maximum repeated customers

SELECT r_name AS Restaurant, COUNT(*) AS Orders
FROM  
	(SELECT r.r_name, user_id, COUNT(*) as Orders
    FROM orders o 
    JOIN restaurants r
	ON r.r_id = o.restaurant_id
	GROUP BY r.r_name, o.user_id
	HAVING orders > 1
	) custom
GROUP BY Restaurant
ORDER BY Orders DESC
LIMIT 1;


-- Q7. Show month over month revenue growth.

SELECT month_name, CONCAT(ROUND(((revenue - prev_revenue) / prev_revenue ) * 100, 2), "%") AS growth_rate
FROM 
(
WITH sales AS
(
	SELECT MONTHNAME(date) AS month_name, MONTH(date) AS months, SUM(amount) AS revenue
	FROM orders
	GROUP BY month_name, months
)
SELECT month_name, revenue, LAG(revenue) OVER(ORDER BY months) AS prev_revenue FROM sales
)t;


-- Q8. Show month over month revenue growth for Dominos.

SELECT month_name, CONCAT(ROUND(((revenue - prev_revenue) / prev_revenue ) * 100, 2), '%') AS growth_rate
FROM 
(
WITH dominos AS
(
SELECT MONTH(date) as months, MONTHNAME(date) AS month_name, SUM(amount) AS revenue
FROM orders 
WHERE restaurant_id = (SELECT r_id FROM restaurants WHERE r_name LIKE 'dominos')
GROUP BY months, month_name
)
SELECT month_name, revenue, LAG(revenue) OVER(ORDER BY months) AS prev_revenue
FROM dominos
)t;


-- Q9. Show every customers favorite food with the number of times they have ordered it.

WITH temp AS 
(
	SELECT c.name, f.f_name, COUNT(*) AS frequency
	FROM orders o
	JOIN customers c
	ON c.user_id = o.user_id
	JOIN order_details od
	ON od.order_id = o.order_id
	JOIN food f
	ON f.f_id = od.food_id
	GROUP BY c.name, f.f_name
)
SELECT * FROM temp t1 
WHERE t1.frequency = (
	SELECT MAX(frequency) FROM temp t2
    WHERE t1.name = t2.name
);
