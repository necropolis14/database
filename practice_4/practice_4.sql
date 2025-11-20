drop database db;
create database db;

create table customers (
  id	integer primary key,
  name	varchar(64),
  email	varchar(128)
);

create table products (
  id	integer primary key,
  title	varchar(256),
  price	money
);

create table order_products (
  id		integer,
  product_id	integer references products(id),
  quantity	integer
);

create table orders (
  id		integer primary key,
  customer_id	integer references customer(id),
  products_id	integer references order_products(id)
);
