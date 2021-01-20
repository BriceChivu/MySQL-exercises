/* Write a SQL query that reports the device that is first logged in for each player.

+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-05-28 | 5            |
| 1         | 5         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+ */

drop table if exists device;

create table if not exists device(
player_id int,
device_id int, 
event_date date,
games_played int);

insert into device values
(1, 2, '2016-05-28', 5),
(1, 5, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);


select player_id, device_id
from(
	select *, dense_rank() over (partition by player_id order by event_date) as seq
	from device) as cte
where seq=1;
