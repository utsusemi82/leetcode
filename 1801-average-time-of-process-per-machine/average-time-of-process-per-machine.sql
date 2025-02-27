# Write your MySQL query statement below
select machine_id, round(avg(time_lapse), 3) as processing_time
from
(select machine_id, process_id,
max(timestamp) over (partition by machine_id, process_id) - min(timestamp) over (partition by machine_id, process_id) 
as time_lapse from Activity) temp
group by machine_id