drop database db;
create database db;

\c db;

create table authors (
  id	serial primary key,
  name	varchar(128)
);

create table books (
  id		serial primary key,
  title		varchar(256),
  author_id	integer references authors(id),
  year		integer
);

alter table books add column genre type varchar(100);
alter table books add check (year <= 2025);

alter table books drop column author_id;
create table book_authors (
  book_id	integer references books(id),
  author_id	integer references authors(id),
  primary key	(book_id, author_id)
);
