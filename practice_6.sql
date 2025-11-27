drop database db;
create database db;

\c db

create table students (
  id	serial primary key,
  name	varchar(64),
  email	varchar(64) unique,
  year	int
);

create table courses (
  id		serial primary key,
  name		varchar(64),
  credits	int check (credits > 0)
);

create table enrollments (
  student_id	int references students(id) on delete cascade,
  course_id	int references courses(id) on delete cascade,
  grade		varchar(1),
  primary key	(student_id, course_id)
);

insert into students
  (name, email, year)
values
  ('Алексей Смирнов', 'alekseysmirnov@mail.ru', 2021),
  ('Елена Кузнецова', 'elenakuznecova@mail.ru', 2022),
  ('Дмитрий Новиков', 'dmitrynovikov@mail.ru',  2021),
  ('Ольга Морозова',  'olgamorozova@mail.ru',   2023);

insert into courses
  (name, credits)
values
  ('Введение в программирование', 5), 
  ('Базы данных',                 4), 
  ('Веб-технологии',              4);

insert into enrollments values 
  (1, 2, 'A'),
  (2, 2, 'B'),
  (2, 3, 'A'),
  (3, 1, null),
  (3, 2, null),
  (3, 3, null);

update students    set email = 'elena.kuznetsova@newmail.com' where id = 2;
update enrollments set grade = 'A' where student_id = 3 and course_id = 1;

delete from students where id = 4;

\c postgres
