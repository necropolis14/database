\c db

select * from students;

select courses.name, courses.credits from courses;

select * from students where year = 2021;

select * from courses where credits > 4;

select * from students where email = 'elena.kuznetsova@newmail.com';

select * from students where name like '%Дмитрий%';

select * from enrollments where grade is null;

select * from courses order by name;

select * from students order by year, name;

select * from students order by year desc limit 2;

\c postgres
