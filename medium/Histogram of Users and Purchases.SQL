/*Assume you're given a table on Walmart user transactions. Based on their most recent transaction date, write a query that retrieve the users along with the number of products they bought.

Output the user's most recent transaction date, user ID, and the number of products, sorted in chronological order by the transaction date.

user_transactions Table:
Column Name	Type
product_id	integer
user_id	integer
spend	decimal
transaction_date	timestamp
user_transactions Example Input:
product_id	user_id	spend	transaction_date
3673	123	68.90	07/08/2022 12:00:00
9623	123	274.10	07/08/2022 12:00:00
1467	115	19.90	07/08/2022 12:00:00
2513	159	25.00	07/08/2022 12:00:00
1452	159	74.50	07/10/2022 12:00:00
Example Output:
transaction_date	user_id	purchase_count
07/08/2022 12:00:00	115	1
07/08/2022 12:00:000	123	2
07/10/2022 12:00:00	159	1*/
Solution
WITH most_recent AS(
        SELECT transaction_date,
        user_id,RANK() OVER( 
           PARTITION BY user_id 
           ORDER BY transaction_date DESC) AS ranking
        FROM user_transactions) 
SELECT transaction_date,
user_id ,COUNT(*) AS purchase_count
FROM most_recent
WHERE ranking =1
GROUP BY transaction_date ,user_id
ORDER BY transaction_date ,purchase_count;
