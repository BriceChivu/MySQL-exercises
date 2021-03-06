-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.


-- Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.


drop table if exists products;
drop table if exists result;

CREATE TABLE Products (
  `product_id` INTEGER,
  `new_price` INTEGER,
  `change_date` DATETIME
);

INSERT INTO Products
  (`product_id`, `new_price`, `change_date`)
VALUES
  ('1', '20', '2019-08-14'),
  ('2', '50', '2019-08-14'),
  ('1', '30', '2019-08-15'),
  ('1', '35', '2019-08-16'),
  ('2', '65', '2019-08-17'),
  ('3', '20', '2019-08-18');

CREATE TABLE Result (
  `product_id` INTEGER,
  `price` INTEGER
);

INSERT INTO Result
  (`product_id`, `price`)
VALUES
  ('2', '50'),
  ('1', '35'),
  ('3', '10');
  
#SOLUTION 1:

with dis as (
select distinct product_id
from products)

select product_id, price
from(
select dis.product_id, ifnull(new_price,10) as price, change_date, dense_rank() over (partition by product_id order by change_date desc) as rankk
from dis
left join (select product_id, new_price, change_date
from products p
where change_date <= '2019-08-16') as cte on cte.product_id=dis.product_id) as tmp
where rankk = 1
order by price desc;

#SOLUTION 2:
with tmp as (
select product_id, new_price as last_price, change_date,
dense_rank() over(partition by product_id order by change_date desc) as ranking
from Products
where change_date <= '2019-08-16')
,
tmp2 as (
select product_id, last_price
from tmp
where ranking = 1)

select distinct p.product_id, 
case when last_price is not null then last_price else 10 end as updated_price
from Products p
left join tmp2 on p.product_id = tmp2.product_id

#SOLUTION 3:
with updated as (
select product_id, new_price as updated_price
from products 
where (product_id, change_date) in
 (select product_id, max(change_date) as change_date
 from products
 where change_date<='2019-08-16'
 group by product_id))
 
 select distinct p.product_id, 
 case when updated_price is null then 10 else updated_price end as updated_price
 from products p
 left join updated u on p.product_id = u.product_id;

