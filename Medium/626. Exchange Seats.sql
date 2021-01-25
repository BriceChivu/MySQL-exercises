-- 626. Exchange Seats
-- Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

-- The column id is continuous increment.
--  

-- Mary wants to change seats for the adjacent students.
--  

-- Can you write a SQL query to output the result for Mary?
--  

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Abbot   |
-- |    2    | Doris   |
-- |    3    | Emerson |
-- |    4    | Green   |
-- |    5    | Jeames  |
-- +---------+---------+
-- For the sample input, the output is:
--  

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Doris   |
-- |    2    | Abbot   |
-- |    3    | Green   |
-- |    4    | Emerson |
-- |    5    | Jeames  |
-- +---------+---------+
-- Note:
-- If the number of students is odd, there is no need to change the last one's seat.



drop table if exists seat;

CREATE TABLE seat (
  `id` INTEGER,
  `student` VARCHAR(7)
);

INSERT INTO seat
  (`id`, `student`)
VALUES
  ('1', 'Abbot'),
  ('2', 'Doris'),
  ('3', 'Emerson'),
  ('4', 'Green'),
  ('5', 'Jeames');

#Solution 1:
select k.id, case when l.students is not null then l.students
else k.student end as student
from seat k
left join 
(select a_id, students
from(
select a_id, 
case when mod(a_id,2)!=0 and b_id=a_id+1 then b_student
when mod(a_id,2)=0 and b_id=a_id-1 then b_student
else null end as students
from(
select a.id as a_id,a.student as a_student,b.id as b_id,b.student as b_student
from seat a cross join seat b
on a.id <> b.id) as cte) as tmp
where students is not null) as l on k.id=l.a_id
order by k.id;

#Solution 2:
select id,
case when mod(id,2)<>0 and lead(student,1) over (order by id) is not null then lead(student,1) over (order by id)
when mod(id,2)=0 then lag(student,1) over (order by id)
when mod(id,2)<>0 and lead(student,1) over (order by id) is null then student
else null end as students
from seat;