/*
Zomato is a leading online food delivery service that connects users with various restaurants and cuisines, allowing them to browse menus, place orders, and get meals delivered to their doorsteps.

Recently, Zomato encountered an issue with their delivery system. Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID and item.

If the last item has an odd order ID, it should remain as the last item in the corrected data. For example, if the last item is Order ID 7 Tandoori Chicken, then it should remain as Order ID 7 in the corrected data.

In the results, return the correct pairs of order IDs and items.

orders Schema:
column_name	type	description
order_id	integer	The ID of each Zomato order.
item	string	The name of the food item in each order.
orders Example Input:
Here's a sample of the initial incorrect data:

order_id	item
1	Chow Mein
2	Pizza
3	Pad Thai
4	Butter Chicken
5	Eggrolls
6	Burger
7	Tandoori Chicken
orders Example Output:
The corrected data should look like this:

corrected_order_id	item
1	Pizza
2	Chow Mein
3	Butter Chicken
4	Pad Thai
5	Burger
6	Eggrolls
7	Tandoori Chicken
*/


Solution
WITH swapping_orders AS(
  SELECT order_id,
        item AS only_item,
        LAG(item) OVER(ORDER BY order_id) even_orders,
        LEAD(item) OVER(ORDER BY order_id) odd_orders
  FROM orders
  
)
SELECT order_id AS corrected_order_id,
    CASE
    WHEN order_id%2 =0 THEN even_orders 
    WHEN order_id%2 =1 AND odd_orders IS NOT NULL THEN odd_orders
    ELSE only_item
    END AS item
FROM swapping_orders;
  
