drop database db;
create database db;

\c db

create table authors (
  id	serial primary key,
  name	varchar(64)
);

create table books (
  id		serial primary key,
  title		varchar(64),
  author_id	int references authors(id),
  year		int
);

alter table books add column genre type varchar(100);
alter table books add check (year <= 2025);

alter table books drop column author_id;
create table book_authors (
  book_id	int references books(id),
  author_id	int references authors(id),
  primary key	(book_id, author_id)
);

\c postgres
