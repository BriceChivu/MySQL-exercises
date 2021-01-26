-- 1045. Customers Who Bought All Products
-- Table: Customer

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | customer_id | int     |
-- | product_key | int     |
-- +-------------+---------+
-- product_key is a foreign key to Product table.
-- Table: Product

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_key | int     |
-- +-------------+---------+
-- product_key is the primary key column for this table.
--  

-- Write an SQL query for a report that provides the customer ids from the Customer table that bought all the products in the Product table.

-- For example:

-- Customer table:
-- +-------------+-------------+
-- | customer_id | product_key |
-- +-------------+-------------+
-- | 1           | 5           |
-- | 2           | 6           |
-- | 3           | 5           |
-- | 3           | 6           |
-- | 1           | 6           |
-- +-------------+-------------+

-- Product table:
-- +-------------+
-- | product_key |
-- +-------------+
-- | 5           |
-- | 6           |
-- +-------------+

-- Result table:
-- +-------------+
-- | customer_id |
-- +-------------+
-- | 1           |
-- | 3           |
-- +-------------+
-- The customers who bought all the products (5 and 6) are customers with id 1 and 3.

drop table if exists Customer;
drop table if exists Product;

CREATE TABLE Customer (
  `customer_id` INTEGER,
  `product_key` INTEGER
);

INSERT INTO Customer
  (`customer_id`, `product_key`)
VALUES
  ('1', '5'),
  ('2', '6'),
  ('3', '5'),
  ('3', '6'),
  ('1', '6');

CREATE TABLE Product (
  `product_key` INTEGER,
  `ignore` VARCHAR(1)
);

INSERT INTO Product
  (`product_key`, `ignore`)
VALUES
  ('5', '_'),
  ('6', '_');

#Solution 1
select customer_id
from(
select customer_id, count(distinct product_key) as counts
from Customer 
group by customer_id) as tmp, (select distinct count(*) as cnt from Product) as cte
where counts=cnt;

#Solution 2
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING count(DISTINCT product_key)=
  (SELECT count(DISTINCT product_key)
   FROM product);