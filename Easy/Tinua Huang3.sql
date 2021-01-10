select date,
sum(case when paying_customer = 'False' then downloads else 0 end ) as non_paid_download,
sum(case when paying_customer = 'True' then downloads else 0 end) as paid_download
from ms_download_facts d
inner join ms_user_dimension u on d.user_id = u.user_id
inner join ms_acc_dimension a on u.acc_id=a.acc_id
group by date
having non_paid_download>paid_download
order by date;

