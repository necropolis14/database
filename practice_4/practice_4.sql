DROP DATABASE IF EXISTS db;
CREATE DATABASE db WITH ENCODING="WIN1251" TEMPLATE="template0";

\c db

CREATE TABLE customers (
	id	SERIAL PRIMARY KEY,
	name	VARCHAR(64),
	email	VARCHAR(64)
);

CREATE TABLE products (
	id	SERIAL PRIMARY KEY,
	title	VARCHAR(64),
	price	MONEY
);

CREATE TABLE order_products (
	order_id	INT REFERENCES orders(id),
	product_id	INT REFERENCES products(id),
	quantity	INT,
	PRIMARY KEY	(order_id, product_id)
);

CREATE TABLE orders (
	id		SERIAL PRIMARY KEY,
	customer_id	INT REFERENCES customer(id),
);

\c postgres
