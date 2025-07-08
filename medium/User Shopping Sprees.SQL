/*In an effort to identify high-value customers, Amazon asked for your help to obtain data about users who go on shopping sprees. A shopping spree occurs when a user makes purchases on 3 or more consecutive days.

List the user IDs who have gone on at least 1 shopping spree in ascending order.

transactions Table:
Column Name	Type
user_id	integer
amount	float
transaction_date	timestamp
transactions Example Input:
user_id	amount	transaction_date
1	9.99	08/01/2022 10:00:00
1	55	08/17/2022 10:00:00
2	149.5	08/05/2022 10:00:00
2	4.89	08/06/2022 10:00:00
2	34	08/07/2022 10:00:00
Example Output:
user_id
2*/
Solution
WITH high_value_cust AS( 
        SELECT user_id ,
          ROW_NUMBER() OVER(
             PARTITION BY user_id 
             ORDER BY date_trunc('day',transaction_date)) AS ranking 
          FROM transactions)
SELECT user_id
FROM high_value_cust
WHERE ranking>=3
ORDER BY user_id ASC;
