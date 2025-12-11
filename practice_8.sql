DROP DATABASE db;
CREATE DATABASE db;

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
	id 			SERIAL PRIMARY KEY,
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

SELECT name order_date FROM customers c JOIN orders o ON c.id = o.customer_id

\c postgres
