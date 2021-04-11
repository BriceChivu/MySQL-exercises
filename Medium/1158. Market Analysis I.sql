-- 1158. Market Analysis I
-- Table: Users

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | user_id        | int     |
-- | join_date      | date    |
-- | favorite_brand | varchar |
-- +----------------+---------+
-- user_id is the primary key of this table.
-- This table has the info of the users of an online shopping website where users can sell and buy items.
-- Table: Orders

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | order_id      | int     |
-- | order_date    | date    |
-- | item_id       | int     |
-- | buyer_id      | int     |
-- | seller_id     | int     |
-- +---------------+---------+
-- order_id is the primary key of this table.
-- item_id is a foreign key to the Items table.
-- buyer_id and seller_id are foreign keys to the Users table.
-- Table: Items

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | item_id       | int     |
-- | item_brand    | varchar |
-- +---------------+---------+
-- item_id is the primary key of this table.
--  

-- Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.

-- The query result format is in the following example:

-- Users table:
-- +---------+------------+----------------+
-- | user_id | join_date  | favorite_brand |
-- +---------+------------+----------------+
-- | 1       | 2018-01-01 | Lenovo         |
-- | 2       | 2018-02-09 | Samsung        |
-- | 3       | 2018-01-19 | LG             |
-- | 4       | 2018-05-21 | HP             |
-- +---------+------------+----------------+

-- Orders table:
-- +----------+------------+---------+----------+-----------+
-- | order_id | order_date | item_id | buyer_id | seller_id |
-- +----------+------------+---------+----------+-----------+
-- | 1        | 2019-08-01 | 4       | 1        | 2         |
-- | 2        | 2018-08-02 | 2       | 1        | 3         |
-- | 3        | 2019-08-03 | 3       | 2        | 3         |
-- | 4        | 2018-08-04 | 1       | 4        | 2         |
-- | 5        | 2018-08-04 | 1       | 3        | 4         |
-- | 6        | 2019-08-05 | 2       | 2        | 4         |
-- +----------+------------+---------+----------+-----------+

-- Items table:
-- +---------+------------+
-- | item_id | item_brand |
-- +---------+------------+
-- | 1       | Samsung    |
-- | 2       | Lenovo     |
-- | 3       | LG         |
-- | 4       | HP         |
-- +---------+------------+

-- Result table:
-- +-----------+------------+----------------+
-- | buyer_id  | join_date  | orders_in_2019 |
-- +-----------+------------+----------------+
-- | 1         | 2018-01-01 | 1              |
-- | 2         | 2018-02-09 | 2              |
-- | 3         | 2018-01-19 | 0              |
-- | 4         | 2018-05-21 | 0              |
-- +-----------+------------+----------------+

drop table if exists Users;
drop table if exists Orders; 
drop table if exists Items;
drop table if exists Result;

CREATE TABLE Users (
  `user_id` INTEGER,
  `join_date` DATETIME,
  `favorite_brand` VARCHAR(7)
);

INSERT INTO Users
  (`user_id`, `join_date`, `favorite_brand`)
VALUES
  ('1', '2018-01-01', 'Lenovo'),
  ('2', '2018-02-09', 'Samsung'),
  ('3', '2018-01-19', 'LG'),
  ('4', '2018-05-21', 'HP');

CREATE TABLE Orders (
  `order_id` INTEGER,
  `order_date` DATETIME,
  `item_id` INTEGER,
  `buyer_id` INTEGER,
  `seller_id` INTEGER
);

INSERT INTO Orders
  (`order_id`, `order_date`, `item_id`, `buyer_id`, `seller_id`)
VALUES
  ('1', '2019-08-01', '4', '1', '2'),
  ('2', '2018-08-02', '2', '1', '3'),
  ('3', '2019-08-03', '3', '2', '3'),
  ('4', '2018-08-04', '1', '4', '2'),
  ('5', '2018-08-04', '1', '3', '4'),
  ('6', '2019-08-05', '2', '2', '4');

CREATE TABLE Items (
  `item_id` INTEGER,
  `item_brand` VARCHAR(7)
);

INSERT INTO Items
  (`item_id`, `item_brand`)
VALUES
  ('1', 'Samsung'),
  ('2', 'Lenovo'),
  ('3', 'LG'),
  ('4', 'HP');

CREATE TABLE Result (
  `buyer_id` INTEGER,
  `join_date` DATETIME,
  `orders_in_2019` INTEGER
);

INSERT INTO Result
  (`buyer_id`, `join_date`, `orders_in_2019`)
VALUES
  ('1', '2018-01-01', '1'),
  ('2', '2018-02-09', '2'),
  ('3', '2018-01-19', '0'),
  ('4', '2018-05-21', '0');

#Solution 1:
with tmp as (
select u.user_id, count(u.user_id) as cnt
from Users u 
inner join Orders o on u.user_id=o.buyer_id
where extract(year from o.order_date)=2019
group by user_id)

select u.user_id, u.join_date, ifnull(cnt,0) as orders_in_2019
from Users u
left join tmp on u.user_id=tmp.user_id;

#Solution 2:
select u.user_id as buyer_id, u.join_date,
sum(case when extract(year from order_date)=2019 then 1 else 0 end)as orders_in_2019
from Users u
inner join Orders o on u.user_id=o.buyer_id
group by u.user_id, u.join_date
order by u.user_id