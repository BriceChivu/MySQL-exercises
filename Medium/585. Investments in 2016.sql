-- Write a query to print the sum of all total investment values in 2016 (TIV_2016), to a scale of 2 decimal places, for all policy holders who meet the following criteria:

-- Have the same TIV_2015 value as one or more other policyholders.
-- Are not located in the same city as any other policyholder (i.e.: the (latitude, longitude) attribute pairs must be unique).
-- Input Format:
-- The insurance table is described as follows:

-- | Column Name | Type          |
-- |-------------|---------------|
-- | PID         | INTEGER(11)   |
-- | TIV_2015    | NUMERIC(15,2) |
-- | TIV_2016    | NUMERIC(15,2) |
-- | LAT         | NUMERIC(5,2)  |
-- | LON         | NUMERIC(5,2)  |
-- where PID is the policyholder's policy ID, TIV_2015 is the total investment value in 2015, TIV_2016 is the total investment value in 2016, LAT is the latitude of the policy holder's city, and LON is the longitude of the policy holder's city.



drop table if exists insurance;
drop table if exists result;

CREATE TABLE insurance (
  `PID` INTEGER,
  `TIV_2015` INTEGER,
  `TIV_2016` INTEGER,
  `LAT` INTEGER,
  `LON` INTEGER
);

INSERT INTO insurance
  (`PID`, `TIV_2015`, `TIV_2016`, `LAT`, `LON`)
VALUES
  ('1', '10', '5', '10', '10'),
  ('2', '20', '20', '20', '20'),
  ('3', '10', '30', '20', '20'),
  ('4', '10', '40', '40', '40');

CREATE TABLE Result (
  `TIV_2016` INTEGER,
  `ignore` VARCHAR(1)
);

INSERT INTO Result
  (`TIV_2016`, `ignore`)
VALUES
  ('45.00', '_');
  
#Solution 1:  
with same_TIV as(
select tiv_2015, count(tiv_2015) as cnt_tiv
from insurance
group by tiv_2015
having cnt_tiv > 1),
city as (
select lat, lon, count(*) as cnt
from insurance
group by lat, lon
having cnt = 1)


select sum(tiv_2016)
from insurance
where tiv_2015 in (select tiv_2015 from same_TIV) and 
(lat, lon)  in (select lat, lon from city);

#Solution 2:
SELECT SUM(TIV_2016) AS TIV_2016 FROM insurance WHERE
TIV_2015 IN (SELECT TIV_2015 FROM insurance GROUP BY TIV_2015 HAVING COUNT(*) > 1) AND
(LAT, LON) IN (SELECT LAT, LON FROM insurance GROUP BY LAT, LON HAVING COUNT(*) = 1);