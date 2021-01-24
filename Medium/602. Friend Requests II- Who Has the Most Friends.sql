drop table if exists request_accepted;
drop table if exists result;

CREATE TABLE request_accepted (
  `requester_id` INTEGER,
  `accepter_id` INTEGER,
  `accept_date` VARCHAR(10)
);

INSERT INTO request_accepted
  (`requester_id`, `accepter_id`, `accept_date`)
VALUES
  ('1', '2', '2016_06-03'),
  ('1', '3', '2016-06-08'),
  ('2', '3', '2016-06-08'),
  ('3', '4', '2016-06-09');

CREATE TABLE Result (
  `id` INTEGER,
  `num` INTEGER
);

INSERT INTO Result
  (`id`, `num`)
VALUES
  ('3', '3');
  

select id, count(id) as num
from(
select requester_id as id
from request_accepted
union all
select accepter_id as id
from request_accepted) as cte
group by id
order by num desc
limit 1;