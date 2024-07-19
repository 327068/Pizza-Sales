CREATE DATABASE pizzahut;
USE pizzahut;
DROP TABLE orders;
CREATE TABLE orders(
	order_id INT NOT NULL PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL
);

CREATE TABLE order_details(
	order_details_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id VARCHAR(20) NOT NULL,
    quantity INT NOT NULL
);








