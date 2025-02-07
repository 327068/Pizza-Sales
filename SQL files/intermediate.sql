-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category, SUM(order_details.quantity) AS total 
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY total DESC;


-- Determine the distribution of orders by hour of the day.
SELECT HOUR(order_time) AS hour, COUNT(order_id) as total_order
FROM orders
GROUP BY HOUR(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, COUNT(name) as number_of_pizzas
FROM pizza_types
GROUP BY category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(q_order),0) AS Avg_orders_per_day
FROM
(SELECT orders.order_date, SUM(order_details.quantity) AS q_order
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) AS order_quantity;


--  Determine the top 3 most ordered pizza types based on revenue.
SELECT pizza_types.name, ROUND(SUM(pizzas.price * order_details.quantity), 0) as revenue
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id 
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;
	



















































