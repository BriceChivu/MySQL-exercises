-- 1070. Product Sales Analysis III
-- Table: Sales

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- sale_id is the primary key of this table.
-- product_id is a foreign key to Product table.
-- Note that the price is per unit.
-- Table: Product

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key of this table.
--  

-- Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.

-- The query result format is in the following example:

-- Sales table:
-- +---------+------------+------+----------+-------+
-- | sale_id | product_id | year | quantity | price |
-- +---------+------------+------+----------+-------+ 
-- | 1       | 100        | 2008 | 10       | 5000  |
-- | 2       | 100        | 2009 | 12       | 5000  |
-- | 7       | 200        | 2011 | 15       | 9000  |
-- +---------+------------+------+----------+-------+

-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 100        | Nokia        |
-- | 200        | Apple        |
-- | 300        | Samsung      |
-- +------------+--------------+

-- Result table:
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+ 
-- | 100        | 2008       | 10       | 5000  |
-- | 200        | 2011       | 15       | 9000  |
-- +------------+------------+----------+-------+

drop table if exists sales;
drop table if exists product;

CREATE TABLE Sales (
  `sale_id` INTEGER,
  `product_id` INTEGER,
  `year` INTEGER,
  `quantity` INTEGER,
  `price` INTEGER
);

INSERT INTO Sales
  (`sale_id`, `product_id`, `year`, `quantity`, `price`)
VALUES
  ('1', '100', '2008', '10', '5000'),
  ('2', '100', '2009', '12', '5000'),
  ('7', '200', '2011', '15', '9000');

CREATE TABLE Product (
  `product_id` INTEGER,
  `product_name` VARCHAR(7)
);

INSERT INTO Product
  (`product_id`, `product_name`)
VALUES
  ('100', 'Nokia'),
  ('200', 'Apple'),
  ('300', 'Samsung');
  
select product_id, year, quantity, price
from(
select s.product_id, year, quantity, price, dense_rank() over(partition by s.product_id order by year asc) as rankk
from Sales s
inner join Product p on s.product_id=p.product_id) as tmp
where rankk=1
 