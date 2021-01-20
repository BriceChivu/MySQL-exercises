-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | sale_date     | date    |
-- | fruit         | enum    | 
-- | sold_num      | int     | 
-- +---------------+---------+
-- (sale_date,fruit) is the primary key for this table.
-- This table contains the sales of "apples" and "oranges" sold each day.
-- Write an SQL query to report the difference between number of apples and oranges sold each day.


drop table if exists sales;
drop table if exists result;

CREATE TABLE Sales (
  `sale_date` DATETIME,
  `fruit` VARCHAR(7),
  `sold_num` INTEGER
);

INSERT INTO Sales
  (`sale_date`, `fruit`, `sold_num`)
VALUES
  ('2020-05-01', 'apples', '10'),
  ('2020-05-01', 'oranges', '8'),
  ('2020-05-02', 'apples', '15'),
  ('2020-05-02', 'oranges', '15'),
  ('2020-05-03', 'apples', '20'),
  ('2020-05-03', 'oranges', '0'),
  ('2020-05-04', 'apples', '15'),
  ('2020-05-04', 'oranges', '16');

CREATE TABLE Result (
  `sale_date` DATETIME,
  `diff` INTEGER
);

INSERT INTO Result
  (`sale_date`, `diff`)
VALUES
  ('2020-05-01', '2'),
  ('2020-05-02', '0'),
  ('2020-05-03', '20'),
  ('2020-05-04', '-1');
  
select s1.sale_date, s1.sold_num-s2.sold_num as diff
from sales s1
inner join sales s2 on s1.sale_date=s2.sale_date and s1.fruit<s2.fruit;

select sale_date, sum(case when fruit='apples' then sold_num else -sold_num end) as diff
from Sales
group by sale_date