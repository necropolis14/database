drop database db;
create database db;

\c db

create table customers (
  id			serial primary key,
  name			varchar(128),
  email			varchar(128) unique,
  registration_date	date,
  recommended_by	int references customers(id)
);

create table products (
  id		serial primary key,
  title		varchar(128),
  category	varchar(128),
  price 	money
);

create table orders (
  id		serial primary key,
  customer_id	int references customers(id),
  order_date	date,
  status	varchar(20)
);

create table order_items (
  id 			serial primary key,
  order_id		int references orders(id),
  product_id		int references products(id),
  quantity		int,
  price_per_unit	money
);

insert into customers
  (name,              email,                       registration_date, recommended_by)
values
  ('Иван Иванов',     'ivan.ivanov@example.com',   '2023-01-15',      NULL),
  ('Мария Петрова',   'maria.petrova@example.com', '2023-02-20',      1),
  ('Алексей Смирнов', 'alex.smirnov@example.com',  '2023-03-10',      1),
  ('Елена Васильева', 'elena.v@example.com',       '2023-04-01',      2),
  ('Андрей Николаев', 'andrey.n@example.com',      '2023-05-01',      NULL);

insert into products
  (title,                category,          price)
values
  ('Смартфон',           'Электроника',     70000.00),
  ('Ноутбук',            'Электроника',     120000.00),
  ('Кофемашина',         'Бытовая техника', 25000.00),
  ('Книга "Основы SQL"', 'Книги',           1500.00),
  ('Фен',                'Бытовая техника', 4500.00),
  ('Пылесос',            'Бытовая техника', 15000.00);

insert into orders
  (customer_id, order_date,   status)
values
  (1,           '2024-05-10', 'Доставлен'),
  (2,           '2024-05-12', 'В обработке'),
  (1,           '2024-05-15', 'Отправлен'),
  (3,           '2024-05-16', 'Доставлен');

insert into order_items
  (order_id, product_id, quantity, price_per_unit)
values
  (1,        1,          1,        70000.00),
  (1,        4,          2,        1400.00),
  (2,        2,          1,        120000.00),
  (3,        3,          1,        25000.00),
  (4,        1,          1,        70000.00),
  (4,        5,          1,        4500.00);

\c postgres
