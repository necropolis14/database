drop database db;
create database db;

\c db;

create table customers (
  id	serial primary key,
  name	varchar(64),
  email	varchar(64)
);

create table products (
  id	serial primary key,
  title	varchar(64),
  price	money
);

create table order_products (
  order_id	integer references orders(id),
  product_id	integer references products(id),
  quantity	integer,
  primary key	(order_id, product_id)
);

create table orders (
  id		serial primary key,
  customer_id	integer references customer(id),
);

\c postgres
