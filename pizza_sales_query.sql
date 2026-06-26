create database pizza_marketing;
use pizza_marketing;

create table pizza_saleing(
pizza_id integer primary key,
order_id integer,
pizza_name_id text,
quantity integer,
order_date date,
order_time time,
unit_price numeric,
total_price numeric,
pizza_size varchar(10),
pizza_cetagory varchar(50),
pizza_ingredients text,
pizza_name text);

select * from pizza_saleing;


-- KPI 
-- 1. Total Revenue 
select sum(total_price) as total_revenue  from pizza_sales;


-- 2. Total Orders
select count(distinct order_id) as total_orders from pizza_sales;

-- 3.Avg order Value 
select cast(cast(sum(total_price) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as AVG_order_value
from pizza_sales;

-- 4.Total Pizza Sold 
select sum(quantity) as total_pizza_sold from pizza_sales;

-- 5.Average pizzas per oder
select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))
as avg_pizzas_per_order from pizza_sales; 


-- Analysis

-- 1. monthly trend for total revenue
SELECT DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%M') AS order_month, SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%M');

-- 2. Daily trend for total orders 
SELECT DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));

-- 3 Percentage of sales by pizza category
SELECT pizza_category,SUM(total_price) AS total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category;

-- 4 percatege of sales by pizza size 
select pizza_size,sum(total_price) as total_revenue,cast(sum(total_price)*100/
(select sum(total_price) from pizza_sales) as decimal (10,2)) as PCT from pizza_sales
group by pizza_size;

-- 5.total pizza sales by pizza size and category
select pizza_size,sum(quantity) as total_pizza_sold from pizza_sales 
group by pizza_size;

select pizza_category,sum(quantity) as total_pizza_sold from pizza_sales
group by pizza_category;

-- 6. Revenue by pizza name 
select pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name 
order by total_revenue ASC
limit 5;


-- TOP & BOTTOM ANALYSIS
-- 1. top pizza by revenue 
select pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name 
order by total_revenue desc
limit 5;

-- 2.bottom pizza by revenue
select pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name 
order by total_revenue ASC
limit 5; 

-- 3. top pizza by order 
select pizza_name,count(distinct order_id) as total_order from pizza_sales
group by pizza_name 
order by total_order desc 
limit 5;

-- 4  bottom price by order 
select pizza_name,count(distinct order_id) as total_order from pizza_sales
group by pizza_name 
order by total_order  
limit 5;

-- 5. top pizza by quantity sold 
select pizza_name, sum(quantity) as total_quantity_sold from pizza_sales
group by pizza_name 
order by total_quantity_sold  desc
limit 5;

-- 6. bottom pizza by quantity sold
select pizza_name, sum(quantity) as total_quantity_sold from pizza_sales
group by pizza_name 
order by total_quantity_sold  
limit 5;