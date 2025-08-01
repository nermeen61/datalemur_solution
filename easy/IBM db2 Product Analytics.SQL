/*IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees. The objective is to generate data to populate a histogram that shows the number of unique queries run by employees during the third quarter of 2023 (July to September). Additionally, it should count the number of employees who did not run any queries during this period.

Display the number of unique queries as histogram categories, along with the count of employees who executed that number of unique queries.

queries Schema:
Column Name	Type	Description
employee_id	integer	The ID of the employee who executed the query.
query_id	integer	The unique identifier for each query (Primary Key).
query_starttime	datetime	The timestamp when the query started.
execution_time	integer	The duration of the query execution in seconds.
queries Example Input:
Assume that the table below displays all queries made from July 1, 2023 to 31 July, 2023:

employee_id	query_id	query_starttime	execution_time
226	856987	07/01/2023 01:04:43	2698
132	286115	07/01/2023 03:25:12	2705
221	33683	07/01/2023 04:34:38	91
240	17745	07/01/2023 14:33:47	2093
110	413477	07/02/2023 10:55:14	470
employees Schema:
Assume that the table below displays all employees in the table:

Column Name	Type	Description
employee_id	integer	The ID of the employee who executed the query.
full_name	string	The full name of the employee.
gender	string	The gender of the employee.
employees Example Input:
employee_id	full_name	gender
1	Judas Beardon	Male
2	Lainey Franciotti	Female
3	Ashbey Strahan	Male
Example Output:
unique_queries	employee_count
0	191
1	46
2	12
3	1*/
Solution
WITH q3_query AS(
    SELECT employee_id ,
        COUNT(DISTINCT query_id) as unique_queries
    FROM queries q
    WHERE EXTRACT(QUARTER FROM query_starttime) = 3
    group by employee_id)
,
 q3_queries_all AS(
        SELECT e.employee_id,
            COALESCE(q.unique_queries,0) as unique_queries
        FROM employees e
        LEFT JOIN q3_query q
        ON e.employee_id=q.employee_id)
SELECT unique_queries,
          count(*) as employee_count
FROM q3_queries_all
GROUP BY unique_queries
ORDER by unique_queries;
