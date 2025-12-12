DROP DATABASE IF EXISTS db;
CREATE DATABASE db WITH ENCODING="WIN1251" TEMPLATE="template0";

\c db

CREATE TABLE authors (
	id	SERIAL PRIMARY KEY,
	name	VARCHAR(64)
);

CREATE TABLE books (
	id		SERIAL PRIMARY KEY,
	title		VARCHAR(64),
	author_id	INT REFERENCES authors(id),
	year		INT
);

ALTER TABLE books ADD COLUMN genre TYPE VARCHAR(100);
ALTER TABLE books ADD CHECK (year <= 2025);

ALTER TABLE books DROP COLUMN author_id;
CREATE TABLE book_authors (
	book_id	INT REFERENCES books(id),
	author_id	INT REFERENCES authors(id),
	PRIMARY KEY	(book_id, author_id)
);

\c postgres
