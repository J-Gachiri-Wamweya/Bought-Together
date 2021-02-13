-- COMMONLY PURCHASED TOGETHER

-- Using the following two tables, 
-- write a query to return the names and purchase frequency of the top three pairs of products most often bought together.
-- The names of both products should appear in one column

create database if not exists practicedb;
use practicedb;

create table if not exists orders_p (
order_id integer not null, 
customer_id integer, 
product_id integer);

create table if not exists products (
id integer not null, 
name varchar(20));
/*
insert into orders_p (order_id, customer_id, product_id) 
VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);
insert into products (id, name) 
VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');
*/

select * from orders_p;
select * from products;
with t1 as(
select a.product_id as pair_a, b.product_id as pair_b 
from orders_p a 
join orders_p b 
on a.order_id = b.order_id 
and a.product_id < b.product_id
order by pair_a,pair_b
),
t2 as(
select concat(a.name," ",b.name) as product_pair  
from t1 
join products a 
on a.id = pair_a 
join products b 
on b.id = pair_b
)
select distinct product_pair , count(*)over(partition by product_pair) as purchase_freq 
from t2 
order by purchase_freq desc,product_pair 
limit 3;
