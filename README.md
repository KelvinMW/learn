# learn
simple learn


I have four related tables: table 1 has students records, table 2 has students enrolment to different courses, table 3 has scores of the students on the different enrolled courses and table 4 has groupings of the scores per exam. show me example sql to display 10 students, the score for 5 different enrolled courses, total score for each student, average for each student and mean average for each course column to display at the bottom of the course column for the different exam groups.

I have five related tables: table 1 has students records, table 2 is courses table with courses names, table 3 has students enrolment to different courses from courses table, table 4 has exam grouping names for the courses, table 5 scores of the students on the different enrolled courses for all the exam groupings. show me example sql to display 10 students, the score for 5 different enrolled courses, total score for each student, average for each student and mean average for each school course column to display at the bottom of the course column for the different exam groups. Show the SQL command, the four tables and expected result output.



mean average for each school course column to display at the bottom of the course column for the different exam groups. Show the SQL command, the four tables and expected result output.





I have five related tables: table 1 has students records, table 2 is courses table with courses names, table 3 has students enrolment to different courses from courses table, table 4 has exam grouping names for the courses, table 5 scores of the students on the different enrolled courses for all the exam groupings. show me example sql to display : the student's score for each enrolled course, the total score for each student from all courses, the average score for each student on the courses taken in one table with student name column, each course column, total score column, average score column and differentiated by the different exam group.



I have five related tables: table 1 has students records, table 2 is courses table with courses names, table 3 has students enrolment to different courses from courses table, table 4 has exam type names for the courses, table 5 has scores of the students on the different enrolled courses for all the exam types. show me example sql to display the following in one table: the student's score for each enrolled course, the total score for each student from all courses, the average score for each student. each course column, total score column, average score column and differentiated by the different exam group.

You can use the following SQL query to display the student's score for each enrolled course, the total score for each student from all courses, and the average score for each student in one table:

```SQL
SELECT s.name AS Student, c.name AS Course, 
       e.name AS Exam_Type, t.score AS Score, 
       SUM(t.score) AS Total_Score,
       AVG(t.score) AS Average_Score
FROM students s 
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
JOIN scores t ON t.student_id = s.student_id 
              AND t.exam_type_id = e.exam_type_id
GROUP BY s.name, c.name, e.name
ORDER BY s.name;
```

The output of this query will look like this:

| Student | Course | Exam_Type | Score | Total_Score | Average_Score | 
| --- | --- | --- | --- | --- | --- |
| John | Maths | Test1 | 90 | 360 | 90.00 |
| John | English | Test2 | 90 | 360 | 90.00 |
| John | Physics | Test3 | 90 | 360 | 90.00 |
| John | Chemistry | Test4 | 90 | 360 | 90.00 |
| Jane | Maths | Test1 | 80 | 320 | 80.00 |
| Jane | English | Test2 | 80 | 320 | 80.00 |
| Jane | Physics | Test3 | 80 | 320 | 80.00 |
| Jane | Chemistry | Test4 | 80 | 320 | 80.00 |

Written by Chatsonic