-- https://www.hackerrank.com/challenges/the-pads/problem

drop table if exists occupations;

create table if not exists occupations(
Name varchar(100),
Occupation varchar(100));

insert into occupations values
('Samantha', 'Doctor'),
('Julia', 'Actor'),
('Maria', 'Actor'),
('Meera', 'Singer'),
('Ashely', 'Professor'),
('Ketty', 'Professor'),
('Christeen', 'Professor'),
('Jane', 'Actor'),
('Jenny', 'Doctor'),
('Priya', 'Singer');



SELECT
CONCAT('There are a total of ', COUNT(Occupation),' ', LOWER(Occupation), 's.')
FROM Occupations
GROUP BY Occupation;

