-- https://www.youtube.com/watch?v=OFJIRSsoK5A&list=PLVD3APpfd1tuXrXBWAntLx4tNaONro5dA&index=6&ab_channel=TinaHuang

-- Employee Project Budgets
-- Find the top five most expensive projects by the amount of budget allocated to each employee on the project. 
-- Exclude projects with 0 employees. Assume each employee works on only one project. 
-- The output should be the project title and the budget that's allocated to each employee (i.e. a budget-to-employee ratio). 
-- Display the top 5 projects with the highest budget-to-employee ratio first.

-- Table1: ms_projects
-- columns: id, title, budget

-- Table2: ms_emp_projects
-- columns: emp_id, project_id

drop table if exists ms_projects;
drop table if exists ms_emp_projects;

create table if not exists ms_projects(
id int,
title varchar(100),
budget int);

insert into ms_projects values
(1, 'Project1', 12000),
(2, 'Project2', 1300),
(3, 'Project3', 80000),
(4, 'Project4', 5000);

create table if not exists ms_emp_projects(
emp_id int,
project_id int);

insert into ms_emp_projects values
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 4),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(11, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 3),
(20, 3),
(21, 3),
(22, 3),
(23, 3);



select title, budget/count(emp_id) as budget_ratio
from ms_projects ms
inner join ms_emp_projects mse on ms.id=mse.project_id
group by title, budget
order by budget_ratio desc
limit 5;


select title, budget/count(emp_id) as budget_ratio,
dense_rank() over(order by budget/count(emp_id) desc) as rankk
from ms_projects ms
inner join ms_emp_projects mse on ms.id=mse.project_id
group by title, budget;

