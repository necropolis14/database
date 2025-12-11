\c db

SELECT * FROM students;

SELECT courses.name, courses.credits FROM courses;

SELECT * FROM students WHERE year = 2021;

SELECT * FROM courses WHERE credits > 4;

SELECT * FROM students WHERE email = 'elena.kuznetsova@newmail.com';

SELECT * FROM students WHERE name LIKE '%Дмитрий%';

SELECT * FROM enrollments WHERE grade IS NULL;

SELECT * FROM courses ORDER BY name;

SELECT * FROM students ORDER BY year, name;

SELECT * FROM students ORDER BY year DESC LIMIT 2;

\c postgres
