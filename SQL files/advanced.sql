-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.category, ROUND((ROUND(SUM(order_details.quantity * pizzas.price),2))/(SELECT ROUND(SUM(order_details.quantity*pizzas.price),2) AS Revenue
FROM order_details
JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id),2)*100 as total_revenue
FROM pizzas
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_revenue DESC;


-- Analyze the cumulative revenue generated over time.
SELECT order_date, SUM(revenue) over(order by order_date) as cum_revenue
FROM
(SELECT orders.order_date, ROUND(SUM(pizzas.price * order_details.quantity), 2) as revenue
FROM order_details
JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
JOIN orders
ON order_details.order_id = orders.order_id 
GROUP BY orders.order_date
order by revenue desc) as sales
order by cum_revenue  ;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT category, name, revenue,
	rank() over(partition by category order by revenue) as Ranking
FROM
(SELECT pizza_types.category, pizza_types.name, 
	SUM(order_details.quantity * pizzas.price) as revenue
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name) as a;

