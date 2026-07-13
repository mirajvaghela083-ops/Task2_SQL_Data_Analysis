-- Student Management Database
-- SQL Data Analysis Internship - Task 2
-- PostgreSQL
-- Created by: Miraj Vaghela

-- STEP 1: Create Table

CREATE TABLE Students (
StudentID SERIAL PRIMARY KEY,
StudentName VARCHAR(100) NOT NULL,
Gender CHAR(1) CHECK (Gender IN('M', 'F')),
Age INT CHECK (Age BETWEEN 15 AND 30),
Grade VARCHAR(2) NOT NULL,
MathScore INT CHECK (MathScore BETWEEN 0 AND 100),
ScienceScore INT CHECK (ScienceScore BETWEEN 0 AND 100),
EnglishScore INT CHECK (EnglishScore BETWEEN 0 AND 100)
);

CREATE TABLE courses (
  id SERIAL PRIMARY KEY,  
  name VARCHAR(50) NOT NULL
);

CREATE TABLE enrollments (
  student_id INT,
  course_id INT,
  grade INT,
  FOREIGN KEY (student_id) REFERENCES students(studentsid),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);


-- STEP 2: Insert Data

INSERT INTO Students (StudentName, Gender, Age, Grade, MathScore, ScienceScore, EnglishScore)
VALUES
('Aarav Patel','M',18,'A',95,91,89),
('Diya Shah','F',17,'A',88,92,94),
('Vivaan Mehta','M',19,'B',76,81,79),
('Ananya Joshi','F',18,'A',91,87,93),
('Krish Desai','M',17,'C',64,71,68),
('Riya Patel','F',18,'B',83,85,88),
('Aditya Singh','M',19,'B',79,82,75),
('Meera Nair','F',18,'A',96,95,98),
('Rahul Verma','M',20,'C',58,63,61),
('Sneha Kapoor','F',19,'B',84,80,86),
('Yash Patel','M',18,'A',90,89,87),
('Kavya Sharma','F',17,'A',93,94,91),
('Arjun Rao','M',18,'B',72,74,70),
('Ishita Gupta','F',19,'A',89,90,92),
('Vaghela Miraj','M',18,'A',92,94,90);

INSERT INTO courses (name)
VALUES
('Mathematics'),
('Science'),
('English'),
('Computer'),
('Physics');

INSERT INTO enrollments (student_id, course_id, grade)
VALUES
(1,1,90),
(1,2,85),
(1,3,88),

(2,1,76),
(2,2,80),
(2,4,91),

(3,1,45),
(3,3,60),
(3,5,70),

(4,2,35),
(4,3,55),
(4,4,65),

(5,1,92),
(5,4,89),
(5,5,94),

(6,2,41),
(6,3,38),
(6,5,52),

(7,1,83),
(7,2,79),
(7,4,86),

(8,3,90),
(8,4,95),
(8,5,88),

(9,1,28),
(9,2,33),
(9,3,40),

(10,4,75),
(10,5,81),
(10,1,69);

-- QUERY 1 List all students enrolled in each course

SELECT s.StudentName,
       c.name AS CourseName,
	   e.grade
FROM enrollments e
JOIN students s
ON e.student_id = s.studentsid
JOIN courses c
ON e.course_id = c.id
ORDER BY c.name,s.studentName;

-- QUERY 2 Average grade per course

SELECT c.name AS CourseName, 
       ROUND(AVG(e.grade), 2) AS avg_grade
FROM enrollments e 
JOIN courses c
ON e.course_id = c.id 
GROUP BY  c.name 
ORDER BY avg_grade DESC;

-- QUERY 3 Top 3 students overall

SELECT
    s.StudentName,
    AVG(e.grade) AS AverageGrade
FROM enrollments e
JOIN students s
ON e.student_id = s.studentsid
GROUP BY s.StudentName
ORDER BY AverageGrade DESC
LIMIT 3;

-- QUERY 4 Count students who failed

SELECT
    COUNT(DISTINCT student_id) AS FailedStudents
FROM enrollments
WHERE grade < 40;