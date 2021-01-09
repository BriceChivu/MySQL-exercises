# https://www.youtube.com/watch?v=ZSXjj0HW6Kg&ab_channel=TinaHuang 

-- Activity Percentile
-- Find the email activity percentile for each user.
-- Email activity percentile is defined by the total number of emails sent. 
-- The user with the highest number of emails sent will have a percentile of 1, and so on.
-- Output the user, total emails, and their activity percentile, and order records by the total emails in descending order.



select user, count(*) as total_emails,
dense_rank() over(order by count(*) desc) as activity
from email
group by user
