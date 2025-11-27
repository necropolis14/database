drop database db;
create database db;

\c db;

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
  student_id	int references students(id),
  course_id	int references courses(id),
  grade		varchar(1),
  primary key	(student_id, course_id)
);

insert into students values ('Алексей Смирнов', 'alekseysmirnov@mail.ru', 2021);
insert into students values ('Елена Кузнецова', 'elenakuznecova@mail.ru', 2022);
insert into students values ('Дмитрий Новиков', 'dmitrynovikov@mail.ru',  2021);
insert into students values ('Ольга Морозова',  'olgamorozova@mail.ru',   2023);

insert into cources values ('Введение в программирование', 5);
insert into cources values ('Базы данных',                 4);
insert into cources values ('Веб-технологии',              4);

insert into enrollments values (, ,'A');
insert into enrollments values (, ,'B');
insert into enrollments values (, ,'A');
insert into enrollments values (, , );
