-- 614. Second Degree Follower
-- In facebook, there is a follow table with two columns: followee, follower.

-- Please write a sql query to get the amount of each follower’s follower if he/she has one.

-- For example:

-- +-------------+------------+
-- | followee    | follower   |
-- +-------------+------------+
-- |     A       |     B      |
-- |     B       |     C      |
-- |     B       |     D      |
-- |     D       |     E      |
-- +-------------+------------+
-- should output:
-- +-------------+------------+
-- | follower    | num        |
-- +-------------+------------+
-- |     B       |  2         |
-- |     D       |  1         |
-- +-------------+------------+
-- Explaination:
-- Both B and D exist in the follower list, when as a followee, B's follower is C and D, and D's follower is E. A does not exist in follower list.

drop table if exists follow;

CREATE TABLE follow (
  `followee` VARCHAR(1),
  `follower` VARCHAR(1)
);

INSERT INTO follow
  (`followee`, `follower`)
VALUES
  ('A', 'B'),
  ('B', 'C'),
  ('B', 'D'),
  ('D', 'E');

select followee, count(followee)
from follow
where followee in (select distinct follower from follow)
group by followee
order by followee;