-- A university uses 2 data tables, student and department, to store data about its students and the departments associated with each major.
-- Write a query to print the respective department name and number of students majoring in each department for all departments in the department table (even ones with no current students).
-- Sort your results by descending number of students; if two or more departments have the same number of students, then sort those departments alphabetically by department name.

-- The student is described as follow:
-- Column Name:	Type
-- student_id:	Integer
-- student_name:	String
-- gender:	Character
-- dept_id:	Integer

-- where student_id is the student’s ID number, student_name is the student’s name, gender is their gender, and dept_id is the department ID associated with their declared major.

-- And the department table is described as below:
-- Column Name:	Type
-- dept_id:	Integer
-- dept_name:	String

-- where dept_id is the department’s ID number and dept_name is the department name.

drop table if exists student;
drop table if exists department;
drop table if exists result;

CREATE TABLE student (
  `student_id` INTEGER,
  `student_name` VARCHAR(4),
  `gender` VARCHAR(1),
  `dept_id` INTEGER
);

INSERT INTO student
  (`student_id`, `student_name`, `gender`, `dept_id`)
VALUES
  ('1', 'Jack', 'M', '1'),
  ('2', 'Jane', 'F', '1'),
  ('3', 'Mark', 'M', '2');

CREATE TABLE department (
  `dept_id` INTEGER,
  `dept_name` VARCHAR(11)
);

INSERT INTO department
  (`dept_id`, `dept_name`)
VALUES
  ('1', 'Engineering'),
  ('2', 'Science'),
  ('3', 'Law');

CREATE TABLE Result (
  `dept_name` VARCHAR(11),
  `student_number` INTEGER
);

INSERT INTO Result
  (`dept_name`, `student_number`)
VALUES
  ('Engineering', '2'),
  ('Science', '1'),
  ('Law', '0');
  
select dept_name, count(student_id) as cnt
from department d 
left join student s on d.dept_id=s.dept_id
group by dept_name
order by cnt desc, dept_name