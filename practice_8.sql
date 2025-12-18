DROP DATABASE IF EXISTS db;
CREATE DATABASE db WITH ENCODING="WIN1251" TEMPLATE="template0";

\c db

CREATE TABLE customers (
	id			SERIAL PRIMARY KEY,
	name			VARCHAR(64),
	email			VARCHAR(64) UNIQUE,
	registration_date	DATE,
	recommended_by		INT REFERENCES customers(id)
);

CREATE TABLE products (
	id		SERIAL PRIMARY KEY,
	title		VARCHAR(64),
	category	VARCHAR(64),
	price		MONEY
);

CREATE TABLE orders (
	id		SERIAL PRIMARY KEY,
	customer_id	INT REFERENCES customers(id),
	order_date	DATE,
	status		VARCHAR(64)
);

CREATE TABLE order_items (
	order_id		INT REFERENCES orders(id),
	product_id		INT REFERENCES products(id),
	quantity		INT,
	price_per_unit		MONEY
);

INSERT INTO customers
(name,              email,                       registration_date, recommended_by) VALUES
('Иван Иванов',     'ivan.ivanov@example.com',   '2023-01-15',      NULL),
('Мария Петрова',   'maria.petrova@example.com', '2023-02-20',      1),
('Алексей Смирнов', 'alex.smirnov@example.com',  '2023-03-10',      1),
('Елена Васильева', 'elena.v@example.com',       '2023-04-01',      2),
('Андрей Николаев', 'andrey.n@example.com',      '2023-05-01',      NULL);

INSERT INTO products
(title,                category,          price) VALUES
('Смартфон',           'Электроника',     70000.00),
('Ноутбук',            'Электроника',     120000.00),
('Кофемашина',         'Бытовая техника', 25000.00),
('Книга "Основы SQL"', 'Книги',           1500.00),
('Фен',                'Бытовая техника', 4500.00),
('Пылесос',            'Бытовая техника', 15000.00);

INSERT INTO orders
(customer_id, order_date,   status) VALUES
(1,           '2024-05-10', 'Доставлен'),
(2,           '2024-05-12', 'В обработке'),
(1,           '2024-05-15', 'Отправлен'),
(3,           '2024-05-16', 'Доставлен');

INSERT INTO order_items
(order_id, product_id, quantity, price_per_unit) VALUES
(1,        1,          1,        70000.00),
(1,        4,          2,        1400.00),
(2,        2,          1,        120000.00),
(3,        3,          1,        25000.00),
(4,        1,          1,        70000.00),
(4,        5,          1,        4500.00);

SELECT c.name, o.order_date FROM customers c JOIN orders o ON c.id = o.customer_id;

SELECT c.name FROM customers c LEFT OUTER JOIN orders o ON c.id = o.customer_id WHERE o.id IS NULL;

SELECT p.title, oi.quantity, oi.price_per_unit FROM products p INNER JOIN order_items oi ON p.id = oi.product_id WHERE oi.order_id = 1;

SELECT c.name FROM customers c WHERE c.id IN (SELECT o.customer_id FROM orders o WHERE o.id IN (SELECT oi.order_id FROM order_items oi WHERE oi.product_id IN (SELECT p.id FROM products p WHERE title = 'Смартфон')));

SELECT p.title FROM products p WHERE p.price::numeric > (SELECT AVG(p.price::numeric) FROM products p);

SELECT o.id FROM orders o WHERE (SELECT SUM(oi.quantity * oi.price_per_unit) FROM order_items oi WHERE o.id = oi.order_id)::numeric > 100000;

SELECT DISTINCT c.name FROM customers c LEFT OUTER JOIN orders o ON c.id = o.customer_id LEFT OUTER JOIN order_items oi ON o.id = oi.order_id LEFT OUTER JOIN products p ON p.id = oi.product_id WHERE p.title != 'Ноутбук' OR o.id IS NULL;
SELECT c.name FROM customers c WHERE c.id NOT IN (SELECT o.customer_id FROM orders o WHERE o.id IN (SELECT oi.order_id FROM order_items oi WHERE oi.product_id IN (SELECT p.id FROM products p WHERE title = 'Ноутбук')));

SELECT p.title FROM products p WHERE p.id NOT IN (SELECT DISTINCT p.id FROM products p RIGHT OUTER JOIN order_items oi ON p.id = oi.product_id);

SELECT c.name, p.title, o.id FROM customers c FULL OUTER JOIN orders o ON c.id = o.customer_id FULL OUTER JOIN order_items oi ON o.id = oi.order_id FULL OUTER JOIN products p ON p.id = oi.product_id;

SELECT c.name FROM customers c INNER JOIN orders o ON c.id = o.customer_id INNER JOIN order_items oi ON o.id = oi.order_id INNER JOIN products p ON p.id = oi.product_id WHERE p.price::numeric = (SELECT MAX(p.price::numeric) FROM products p);
SELECT c.name FROM customers c WHERE c.id IN (SELECT o.customer_id FROM orders o WHERE o.id IN (SELECT oi.order_id FROM order_items oi WHERE oi.product_id IN (SELECT p.id FROM products p WHERE p.price::numeric IN (SELECT MAX(p.price::numeric) FROM products p))));

SELECT c.name, p.title FROM customers c CROSS JOIN products p;

SELECT n.name, c.name FROM customers n LEFT OUTER JOIN customers c ON n.recommended_by = c.id;

\c postgres
