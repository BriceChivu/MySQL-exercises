-- 612. Shortest Distance in a Plane
-- Table point_2d holds the coordinates (x,y) of some unique points (more than two) in a plane.
--  

-- Write a query to find the shortest distance between these points rounded to 2 decimals.
--  

-- | x  | y  |
-- |----|----|
-- | -1 | -1 |
-- | 0  | 0  |
-- | -1 | -2 |
--  

-- The shortest distance is 1.00 from point (-1,-1) to (-1,2). So the output should be:
--  

-- | shortest |
-- |----------|
-- | 1.00     |

drop table if exists point_2d;
drop table if exists result;

CREATE TABLE point_2d (
  `x` INTEGER,
  `y` INTEGER
);

INSERT INTO point_2d
  (`x`, `y`)
VALUES
  ('-1', '-1'),
  ('0', '0'),
  ('-1', '-2');

CREATE TABLE Result (
  `shortest` INTEGER,
  `ignore` VARCHAR(1)
);

INSERT INTO Result
  (`shortest`, `ignore`)
VALUES
  ('1.00', '_');
  
select min(dist) as shortest
from(  
select sqrt(power((p1.x- p2.x),2) + power((p2.y- p1.y),2)) as dist
from point_2d p1
inner join point_2d p2 on p1.x <> p2.x or p1.y<>p2.y) as cte;

