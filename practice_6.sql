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

insert into students (name, email, year) values ('Алексей Смирнов', 'alekseysmirnov@mail.ru', 2021);
insert into students (name, email, year) values ('Елена Кузнецова', 'elenakuznecova@mail.ru', 2022);
insert into students (name, email, year) values ('Дмитрий Новиков', 'dmitrynovikov@mail.ru',  2021);
insert into students (name, email, year) values ('Ольга Морозова',  'olgamorozova@mail.ru',   2023);

insert into courses (name, credits) values ('Введение в программирование', 5);
insert into courses (name, credits) values ('Базы данных',                 4);
insert into courses (name, credits) values ('Веб-технологии',              4);

insert into enrollments values (1, 2, 'A');
insert into enrollments values (2, 2, 'B');
insert into enrollments values (2, 3, 'A');
insert into enrollments values (3, 1);
insert into enrollments values (3, 2);
insert into enrollments values (3, 3);

update students    set email = 'elena.kuznetsova@newmail.com' where id = 2;
update enrollments set grade = 'A' where student_id = 3 and course_id = 1;

delete from students where id = 4;

\c postgres
