create database sales_project;
use sales_project;
create table amazon_sales(
             transaction_id int,
             sales_date date,
             sales_time time,
             customer_id int,
             gender varchar(15),
             age int,
             category varchar(15),
             quantity int,
             price_per_unit float,
             cogs float,
             total_sales float
             );
select * from amazon_sales;
describe amazon_sales;
select count(*) from amazon_sales;
select * from amazon_sales where transaction_id is null;
select transaction_id from amazon_sales;
select count(quantity) from amazon_sales;
select * from amazon_sales where 
transaction_id is null
or
sales_date is null
or
sales_time is null
or 
customer_id is null
or
gender is null
or 
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sales is null;
-- how many sales --
select count(*) from amazon_sales;
select count(customer_id) from amazon_sales;
select count(total_sales) from amazon_sales;
select count(distinct customer_id) as unique_customers from amazon_sales;
select count(distinct category) as unique_category from amazon_sales;
select distinct category as unique_category from amazon_sales;

select * from amazon_sales where sales_date="2022-11-05";
select * from amazon_sales where category='clothing' and quantity >=4 and sales_date between '2022-11-01' and '2022-11-30';
select category,sum(total_sales) from amazon_sales group by 1;
select category,sum(total_sales) as net_sales,count(*) as nof_orders from amazon_sales group by category;
select round(avg(age),1) as avg_age from amazon_sales where category='beauty';
select * from amazon_sales;
select * from amazon_sales where total_sales >= 1000;
select category,gender,count(transaction_id) as nof_transactions from amazon_sales group by category,gender order by 1;
select  year,month,avg_sales from (
select extract(year from sales_date) as year,extract(month from sales_date) as month,avg(total_sales) as avg_sales,
rank() over(partition by extract(year from sales_date) order by avg(total_sales) desc) as rank_of_sales from amazon_sales 
  group by year,month) as t1
  where rank_of_sales=1;
select customer_id,sum(total_sales) as highest_sales from amazon_sales group by customer_id order by sum(total_sales) desc limit 5;
select category, count( distinct (customer_id)) from amazon_sales group by category;
with hourly_sales as (
 select * ,case 
               when extract(hour from sales_time)<12 then 'morning'
               when extract(hour from sales_time) between 12 and 17 then 'afternoon'
               else 'evening'
               end as shifts from amazon_sales) 
               select shifts,count(*) as nof_orders from hourly_sales group by shifts;










