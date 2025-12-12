DROP DATABASE IF EXISTS db;
CREATE DATABASE db WITH ENCODING="WIN1251" TEMPLATE="template0";

\c db

CREATE TABLE students (
	id	SERIAL PRIMARY KEY,
	name	VARCHAR(64),
	email	VARCHAR(64) UNIQUE,
	year	INT
);

CREATE TABLE courses (
	id		SERIAL PRIMARY KEY,
	name		VARCHAR(64),
	credits		INT CHECK (credits > 0)
);

CREATE TABLE enrollments (
	student_id	INT REFERENCES students(id) ON DELETE cascade,
	course_id	INT REFERENCES courses(id) ON DELETE cascade,
	grade		VARCHAR(1),
	PRIMARY KEY	(student_id, course_id)
);

INSERT INTO students
(name,              email,                    year) VALUES
('Алексей Смирнов', 'alekseysmirnov@mail.ru', 2021),
('Елена Кузнецова', 'elenakuznecova@mail.ru', 2022),
('Дмитрий Новиков', 'dmitrynovikov@mail.ru',  2021),
('Ольга Морозова',  'olgamorozova@mail.ru',   2023);

INSERT INTO courses
(name,                          credits) VALUES
('Введение в программирование', 5), 
('Базы данных',                 4), 
('Веб-технологии',              4);

INSERT INTO enrollments VALUES 
(1, 2, 'A'),
(2, 2, 'B'),
(2, 3, 'A'),
(3, 1, NULL),
(3, 2, NULL),
(3, 3, NULL);

UPDATE students    SET email = 'elena.kuznetsova@newmail.com' WHERE id = 2;
UPDATE enrollments SET grade = 'A' WHERE student_id = 3 AND course_id = 1;

DELETE FROM students WHERE id = 4;

\c postgres
