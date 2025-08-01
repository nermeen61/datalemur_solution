/*Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

Notes:

Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.
Effective April 15th, 2023, the solution has been updated and optimised.

activities Table
Column Name	Type
activity_id	integer
user_id	integer
activity_type	string ('send', 'open', 'chat')
time_spent	float
activity_date	datetime
activities Example Input
activity_id	user_id	activity_type	time_spent	activity_date
7274	123	open	4.50	06/22/2022 12:00:00
2425	123	send	3.50	06/22/2022 12:00:00
1413	456	send	5.67	06/23/2022 12:00:00
1414	789	chat	11.00	06/25/2022 12:00:00
2536	456	open	3.00	06/25/2022 12:00:00
age_breakdown Table
Column Name	Type
user_id	integer
age_bucket	string ('21-25', '26-30', '31-25')
age_breakdown Example Input
user_id	age_bucket
123	31-35
456	26-30
789	21-25
Example Output
age_bucket	send_perc	open_perc
26-30	65.40	34.60
31-35	43.75	56.25*/
Solution
WITH snapchat_prec AS(
              SELECT age_breakdown.age_bucket,
                 SUM(CASE WHEN activities.activity_type='open'
                   THEN activities.time_spent ELSE 0 END) AS opening_snapchat,
                 SUM(CASE WHEN activities.activity_type='send'
                   THEN activities.time_spent ELSE 0 END) AS sending_snapchat
                   ,SUM(activities.time_spent) AS total_time_spent
              FROM activities
             JOIN age_breakdown
                on activities.user_id=age_breakdown.user_id
              WHERE activities.activity_type in('open','send')
              group by age_bucket)

      SELECT 
          age_bucket,
         ROUND((100.0*sending_snapchat/total_time_spent),2) AS send_perc,
         ROUND((100.0*opening_snapchat/total_time_spent),2) AS open_perc
      FROM snapchat_prec
      ORDER BY age_bucket ASC;
 
