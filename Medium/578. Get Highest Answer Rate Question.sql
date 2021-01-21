-- Get the highest answer rate question from a table survey_log with these columns: uid, action, question_id, answer_id, q_num, timestamp.

-- uid means user id; action has these kind of values: "show", "answer", "skip"; answer_id is not null when action column is "answer", while is null for "show" and "skip"; q_num is the numeral order of the question in current session.

-- Write a sql query to identify the question which has the highest answer rate.

-- Example:

-- Input:
-- +------+-----------+--------------+------------+-----------+------------+
-- | uid  | action    | question_id  | answer_id  | q_num     | timestamp  |
-- +------+-----------+--------------+------------+-----------+------------+
-- | 5    | show      | 285          | null       | 1         | 123        |
-- | 5    | answer    | 285          | 124124     | 1         | 124        |
-- | 5    | show      | 369          | null       | 2         | 125        |
-- | 5    | skip      | 369          | null       | 2         | 126        |
-- +------+-----------+--------------+------------+-----------+------------+
-- Output:
-- +-------------+
-- | survey_log  |
-- +-------------+
-- |    285      |
-- +-------------+
-- Explanation:
-- question 285 has answer rate 1/2, while question 369 has 0/1 answer rate, so output 285.
--  

-- Note: The highest answer rate meaning is: answer number's ratio in show number in the same question.


drop table if exists input;
drop table if exists result;

CREATE TABLE Input (
  `uid` INTEGER,
  `action` VARCHAR(6),
  `question_id` INTEGER,
  `answer_id` VARCHAR(6),
  `q_num` INTEGER,
  `timestamp` INTEGER
);

INSERT INTO Input
  (`uid`, `action`, `question_id`, `answer_id`, `q_num`, `timestamp`)
VALUES
  ('5', 'show', '285', Null, '1', '123'),
  ('5', 'answer', '285', '124124', '1', '124'),
  ('5', 'show', '369', Null, '2', '125'),
  ('5', 'skip', '369', Null, '2', '126');

CREATE TABLE Result (
  `survey_log` INTEGER,
  `ignore` VARCHAR(1)
);

INSERT INTO Result
  (`survey_log`, `ignore`)
VALUES
  ('285', '_');
  
  
-- SOLUTION 1:   
with total as(
select question_id, count(*) as total_cnt
from input
group by question_id),
rate as (
select question_id, count(answer_id) as cnt
from input
group by question_id)


select question_id, ratio
from(
select total.question_id, cnt/total_cnt as ratio, dense_rank() over(order by cnt/total_cnt desc) as rankk
from rate
inner join total on rate.question_id=total.question_id) as cte
where rankk=1;

-- SOLUTION 2:
select question_id
from(
select question_id, dense_rank() over(order by ratio desc) as rankk
from(
select question_id, count(answer_id)/count(*) as ratio
from input
group by question_id) tmp)
cte
where rankk = 1;