CREATE DATABASE PizzaRestaurant;

USE PizzaRestaurant;

create table Customer(
			   customer_id int NOT NULL,
               name varchar(100),
               phone_number varchar(10),
               PRIMARY KEY (customer_id)
);
  
  create table customer_order(
				order_id int NOT NULL,
                order_date_time DATETIME,
                customer_id int,
                PRIMARY KEY (order_id),
                FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

create table pizza(
			pizza_id int NOT NULL,
            pizza_type varchar(100),
            price  DECIMAL(10,2),
            PRIMARY KEY (pizza_id)
);

USE PizzaRestaurant;

CREATE TABLE order_pizza (
    order_pizza_id INT NOT NULL,
    order_id INT,
    pizza_id INT,
    quantity INT,
    PRIMARY KEY (order_pizza_id),
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizza(pizza_id)
);

INSERT INTO Customer(customer_id, name, phone_number)
values(101, 'Trevor Page', 2265554982);

INSERT INTO Customer(customer_id, name, phone_number)
values(102, 'John Doe', 5555559498);

INSERT INTO customer_order(order_id, order_date_time,customer_id)
values(1, '2023-09-10 09:47:00', 101);

INSERT INTO customer_order(order_id, order_date_time,customer_id)
values(2, '2023-09-10 01:20:00', 102);
               
INSERT INTO customer_order(order_id, order_date_time,customer_id)
values(3, '2023-09-10 09:47:00', 101);

INSERT INTO customer_order(order_id, order_date_time,customer_id)
values(4, '2023-10-10 10:37:00', 102);

INSERT INTO pizza(pizza_id, pizza_type, price)
values(1,'pepperoni & cheese', 7.99);

INSERT INTO pizza(pizza_id, pizza_type, price)
values(2, 'vegetarian', 9.99);

INSERT INTO pizza(pizza_id, pizza_type, price)
values(3, 'meat lovers', 14.99);

INSERT INTO pizza(pizza_id, pizza_type, price)
values(4, 'hawaiian', 12.99);

INSERT INTO order_pizza(order_pizza_id, order_id, pizza_id, quantity)
values
(1,1,1,1),
(2,1,3,1);

INSERT INTO order_pizza(order_pizza_id, order_id, pizza_id, quantity)
VALUES
(3, 2 , 2, 1),
(4, 2, 3, 2);

INSERT INTO order_pizza(order_pizza_id, order_id, pizza_id, quantity)
VALUES
(5,3 ,3 ,1),
(6, 3, 4, 1);

INSERT INTO order_pizza(order_pizza_id, order_id, pizza_id, quantity)
VALUES
(7, 4, 2, 3),
(8, 4, 4, 1);

USE PizzaRestaurant;

SELECT customer.customer_id, customer_order.customer_id, order_pizza.order_id, order_pizza.pizza_id
FROM customer_order
INNER JOIN customer ON customer_order.customer_id = customer.customer_id
INNER JOIN order_pizza ON customer_order.order_id = order_pizza.order_id
INNER JOIN pizza ON order_pizza.pizza_id = pizza.pizza_id;

USE PizzaRestaurant;

SELECT customer_order.order_id, customer.customer_id, order_pizza.order_pizza_id, order_pizza.order_id, order_pizza.quantity, pizza.pizza_id, pizza.pizza_type, pizza.price
FROM customer_order
INNER JOIN order_pizza ON customer_order.order_id = order_pizza.order_id
INNER JOIN pizza ON order_pizza.pizza_id = pizza.pizza_id
INNER JOIN customer ON customer_order.customer_id = customer.customer_id;

SELECT SUM(pizza.price * order_pizza.quantity), customer.customer_id
FROM order_pizza
INNER JOIN pizza ON order_pizza.pizza_id = pizza.pizza_id
INNER JOIN customer_order ON order_pizza.order_id = customer_order.order_id
INNER JOIN customer ON customer_order.customer_id = customer.customer_id
GROUP BY customer.customer_id;

SELECT customer.customer_id, SUM(pizza.price * order_pizza.quantity) AS total_spent
FROM customer
INNER JOIN customer_order ON customer.customer_id = customer_order.customer_id
INNER JOIN order_pizza ON customer_order.order_id = order_pizza.order_id
INNER JOIN pizza ON order_pizza.pizza_id = pizza.pizza_id
GROUP BY customer.customer_id;

USE PizzaRestaurant;


SELECT customer.customer_id, customer_order.order_date_time, SUM(pizza.price * order_pizza.quantity) AS total_spent
FROM customer
INNER JOIN customer_order ON customer.customer_id = customer_order.customer_id
INNER JOIN order_pizza ON customer_order.order_id = order_pizza.order_id
INNER JOIN pizza ON order_pizza.pizza_id = pizza.pizza_id
GROUP BY customer.customer_id, customer_order.order_date_time; 


SELECT Customer.name, customer.customer_id, customer_order.order_date_time, SUM(pizza.price * order_pizza.quantity) AS total_spent
FROM customer
INNER JOIN customer_order ON customer.customer_id = customer_order.customer_id
INNER JOIN order_pizza ON customer_order.order_id = order_pizza.order_id
INNER JOIN pizza ON order_pizza.pizza_id = pizza.pizza_id
GROUP BY customer.customer_id, customer_order.order_date_time; 