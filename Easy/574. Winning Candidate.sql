-- 574. Winning Candidate
-- Table: Candidate

-- +-----+---------+
-- | id  | Name    |
-- +-----+---------+
-- | 1   | A       |
-- | 2   | B       |
-- | 3   | C       |
-- | 4   | D       |
-- | 5   | E       |
-- +-----+---------+  
-- Table: Vote

-- +-----+--------------+
-- | id  | CandidateId  |
-- +-----+--------------+
-- | 1   |     2        |
-- | 2   |     4        |
-- | 3   |     3        |
-- | 4   |     2        |
-- | 5   |     5        |
-- +-----+--------------+
-- id is the auto-increment primary key,
-- CandidateId is the id appeared in Candidate table.
-- Write a sql to find the name of the winning candidate, the above example will return the winner B.

-- +------+
-- | Name |
-- +------+
-- | B    |
-- +------+


drop table if exists candidate;
drop table if exists vote;
drop table if exists result;

CREATE TABLE Candidate (
  `id` INTEGER,
  `Name` VARCHAR(1)
);

INSERT INTO Candidate
  (`id`, `Name`)
VALUES
  ('1', 'A'),
  ('2', 'B'),
  ('3', 'C'),
  ('4', 'D'),
  ('5', 'E');

CREATE TABLE Vote (
  `id` INTEGER,
  `CandidateId` INTEGER
);

INSERT INTO Vote
  (`id`, `CandidateId`)
VALUES
  ('1', '2'),
  ('2', '4'),
  ('3', '3'),
  ('4', '2'),
  ('5', '5');

CREATE TABLE Result (
  `Name` VARCHAR(1),
  `ignore` VARCHAR(1)
);

INSERT INTO Result
  (`Name`, `ignore`)
VALUES
  ('B', '_');

select name
from(
select candidateid, dense_rank() over(order by cnt desc) as rankk
from(
select candidateid, count(candidateid) as cnt
from vote v
group by candidateid) as cte) as tmp
inner join candidate c on tmp.candidateid=c.id
where rankk=1;

select name
from(
select name, count(*) as cnt
from vote v
inner join candidate c on v.candidateid=c.id
group by name
order by cnt desc
limit 1) tmp;
