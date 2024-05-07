use sql_and_tableau;

select *,case
when (days_for_completion = 0) then 'Same day'
when (days_for_completion>=1 and days_for_completion<=7) then '1 to 7 days' 
when (days_for_completion>=8 and days_for_completion<=30) then '8 to 30 days' 
when (days_for_completion>=31 and days_for_completion<=60) then '31 to 60 days' 
when (days_for_completion>=61 and days_for_completion<=90) then '61 to 90 days' 
when (days_for_completion>=91 and days_for_completion<=365) then '91 to 365 days' 
when (days_for_completion>365) then '366+ days' 
end as completion_bucket from (select row_number() over(order by  s.student_id,s.track_id) as student_track_id,s.student_id,t.track_name,s.date_enrolled,
case 
when s.date_completed is not NULL then 1
when s.date_completed is NULL then 0
end as track_completed,
datediff(s.date_completed,s.date_enrolled) as days_for_completion
from career_track_student_enrollments s join career_track_info t on s.track_id=t.track_id) a; 
