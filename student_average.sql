--This SQL will give student average for the academic year selected [use variable "schoolYear"]--
SELECT
gibbonSchoolYear.name as schoolYear,
gibbonYearGroup.name AS yearGroup,
officialName,
COUNT(NULLIF(attainmentValue,'')) as `ExamsDone`,
SUM(attainmentValue) as `gradeTotal`,
ROUND(SUM(attainmentValue) / (COUNT(NULLIF(attainmentValue,''))), 2) as `gradeAverage`
FROM gibbonPerson
JOIN gibbonStudentEnrolment ON (gibbonStudentEnrolment.gibbonPersonID=gibbonPerson.gibbonPersonID)
JOIN gibbonYearGroup ON (gibbonStudentEnrolment.gibbonYearGroupID=gibbonYearGroup.gibbonYearGroupID)
JOIN gibbonInternalAssessmentEntry ON (gibbonInternalAssessmentEntry.gibbonPersonIDStudent=gibbonPerson.gibbonPersonID)
JOIN gibbonInternalAssessmentColumn ON (gibbonInternalAssessmentEntry.gibbonInternalAssessmentColumnID=gibbonInternalAssessmentColumn.gibbonInternalAssessmentColumnID)
JOIN gibbonCourseClass ON (gibbonInternalAssessmentColumn.gibbonCourseClassID=gibbonCourseClass.gibbonCourseClassID)
JOIN gibbonCourse ON (gibbonCourseClass.gibbonCourseID=gibbonCourse.gibbonCourseID)
JOIN gibbonSchoolYear ON (gibbonStudentEnrolment.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID)
WHERE
gibbonCourse.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID
AND gibbonPerson.status='Full'
AND gibbonCourse.gibbonSchoolYearID=:schoolYear
GROUP BY gibbonInternalAssessmentEntry.gibbonPersonIDStudent
ORDER BY
yearGroup, surname, preferredName

--This SQL will print students marks for each subject & average for the academic year selected [use variable "schoolYear"]--

SELECT
gibbonSchoolYear.name as schoolYear,
gibbonYearGroup.name AS yearGroup,
COUNT(NULLIF(attainmentValue,'')) as `ExamsDone`,
SUM(attainmentValue) as `gradeTotal`,
ROUND(SUM(attainmentValue) / (COUNT(NULLIF(attainmentValue,''))), 2) as `gradeAverage`
FROM
(
    SELECT
    gibbonPerson.gibbonPersonID,
    gibbonPerson.officialName,
    gibbonCourse.name as course_name,
    gibbonInternalAssessmentEntry.attainmentValue

    FROM gibbonPerson

    LEFT JOIN gibbonStudentEnrolment ON (gibbonStudentEnrolment.gibbonPersonID=gibbonPerson.gibbonPersonID)
    JOIN gibbonYearGroup ON (gibbonStudentEnrolment.gibbonYearGroupID=gibbonYearGroup.gibbonYearGroupID)
    JOIN gibbonInternalAssessmentColumn ON (gibbonInternalAssessmentEntry.gibbonInternalAssessmentColumnID=gibbonInternalAssessmentColumn.gibbonInternalAssessmentColumnID)
    JOIN gibbonCourseClass ON (gibbonInternalAssessmentColumn.gibbonCourseClassID=gibbonCourseClass.gibbonCourseClassID)
    JOIN gibbonCourse ON (gibbonCourseClass.gibbonCourseID=gibbonCourse.gibbonCourseID)
    JOIN gibbonSchoolYear ON (gibbonStudentEnrolment.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID) 
    WHERE gibbonCourse.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID
AND gibbonPerson.status='Full'
AND gibbonCourse.gibbonSchoolYearID=:schoolYear
)

GROUP BY gibbonInternalAssessmentEntry.gibbonPersonIDStudent
ORDER BY
yearGroup, surname, preferredName

SELECT ROUND(SUM(attainmentValue) / (COUNT(NULLIF(attainmentValue,''))), 2) as `meanAverage`
FROM gibbonStudentEnrolment
GROUP BY gibbonCourseID





--better version--

SELECT
gibbonPerson.gibbonPersonID,
gibbonPerson.officialName,
gibbonInternalAssessmentEntry.attainmentValue as Score,
gibbonInternalAssessmentColumn.





















--better 2--
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







The following SQL query will output the requested information in one table, including the student name, the enrolled courses, the total score for each student from all courses, and the average score for each student:

```SQL
SELECT s.name AS 'Student Name', c.name AS 'Course Name', ec.score AS 'Score', 
SUM(ec.score) OVER (PARTITION BY s.id) AS 'Total Score', 
AVG(ec.score) OVER (PARTITION BY s.id) AS 'Average Score'
FROM students s 
INNER JOIN enrolment ec ON s.id = ec.student_id
INNER JOIN courses c ON ec.course_id = c.id
INNER JOIN exam_types et ON ec.exam_type_id = et.id
GROUP BY s.name, c.name, ec.score
ORDER BY s.name
```

The expected output of the query is below:

| Student Name | Course Name | Score | Total Score | Average Score |
|--------------|-------------|-------|-------------|---------------|
| John Smith   | Math        | 80    | 280         | 70            |
| John Smith   | English     | 90    | 280         | 70            |
| John Smith   | Science     | 110   | 280         | 70            |
| Jane Doe     | Math        | 95    | 295         | 73.75         |
| Jane Doe     | English     | 90    | 295         | 73.75         |
| Jane Doe     | Science     | 110   | 295         | 73.75         |







The following SQL query can be used to achieve the desired output table:

```SQL
SELECT students.Name,
       c1.Name as Course1,
       s1.Score as Score1,
       c2.Name as Course2,
       s2.Score as Score2,
       c3.Name as Course3,
       s3.Score as Score3,
       SUM(s1.Score + s2.Score + s3.Score) as Total_Score,
       AVG(s1.Score + s2.Score + s3.Score) as Avg_Score
FROM students
INNER JOIN student_courses sc1 ON students.ID = sc1.Student_ID
INNER JOIN courses c1 ON sc1.Course_ID = c1.ID
INNER JOIN student_exam_scores s1 ON sc1.ID = s1.Student_Course_ID
INNER JOIN student_courses sc2 ON students.ID = sc2.Student_ID
INNER JOIN courses c2 ON sc2.Course_ID = c2.ID
INNER JOIN student_exam_scores s2 ON sc2.ID = s2.Student_Course_ID
INNER JOIN student_courses sc3 ON students.ID = sc3.Student_ID
INNER JOIN courses c3 ON sc3.Course_ID = c3.ID
INNER JOIN student_exam_scores s3 ON sc3.ID = s3.Student_Course_ID
GROUP BY students.Name
```

This query will produce an output table with the required columns and rows, including the student's name, courses and its respective scores, total score, and average score. The output table will look something like this:

| Name      | Course1 | Score1 | Course2 | Score2 | Course3 | Score3 | Total_Score | Avg_Score |
|-----------|---------|--------|---------|--------|---------|--------|-------------|-----------|
| John Doe  | Math    | 75     | English | 85     | Science | 90     | 250         | 83.33     |
| Jane Smith | Math    | 70     | English | 75     |






The following SQL query can be used to display the desired output:

```SQL
SELECT student_name, 
     SUM(CASE WHEN course_name = 'courses1' THEN score END) AS 'Course1 Score', 
     SUM(CASE WHEN course_name = 'courses2' THEN score END) AS 'Course2 Score', 
     SUM(CASE WHEN course_name = 'courses3' THEN score END) AS 'Course3 Score', 
     SUM(CASE WHEN course_name = 'courses4' THEN score END) AS 'Course4 Score', 
     SUM(score) AS total_score, 
     AVG(score) AS average_score 
FROM students_table s 
JOIN courses_table c ON s.student_id = c.student_id 
JOIN exams_table e ON c.course_id = e.course_id 
GROUP BY student_name
UNION
SELECT 'Average Scores' AS student_name, 
     AVG(score) AS 'Course1 Score', 
     AVG(score) AS 'Course2 Score', 
     AVG(score) AS 'Course3 Score', 
     AVG(score) AS 'Course4 Score', 
     AVG(score) AS total_score, 
     AVG(score) AS average_score 
FROM students_table s 
JOIN courses_table c ON s.student_id = c.student_id 
JOIN exams_table e ON c.course_id = e.course_id 
```

The expected output of the above SQL query is a table with the following columns: student name, Course1 Score, Course2 Score, Course3 Score, Course4 Score, total score, and average score. The table would contain a row for each student with the corresponding scores and a final row with the average scores of all students enrolled in each course.






```sql
SELECT
  st.Name as 'Student Name',
  c.CourseName as 'Course Name',
  es.Score as 'Score',
  SUM(es.Score) OVER (PARTITION BY st.Name) AS 'Total Score',
  AVG(es.Score) OVER (PARTITION BY st.Name) AS 'Average Score'
FROM students st
LEFT JOIN enrollments e ON st.Id = e.StudentId
LEFT JOIN courses c ON e.CourseId = c.Id
LEFT JOIN exams_scores es ON c.Id = es.CourseId
GROUP BY st.Name, c.CourseName, es.Score
```

Example Demo Data:

Table 1 (students): 

| Name | Id |
|-----|----|
| John | 1  |
| Jane | 2  |

Table 2 (courses): 

| CourseName | Id |
|------------|----|
| Maths      | 1  |
| Science    | 2  |

Table 3 (enrollments): 

| StudentId | CourseId |
|-----------|----------|
| 1         | 1        |
| 2         | 1        |
| 2         | 2        |

Table 4 (exams_type):

| CourseId  | ExamType  |
|-----------|-----------|
| 1         | Midterm   |
| 1         | Final     |
| 2         | Preliminary |

Table 5 (exams_scores): 

| CourseId | StudentId | ExamType | Score |
|----------|-----------|----------|-------|
| 1        | 1         | Midterm  | 90    |
| 1        | 1         | Final    | 80    |
| 1        | 2         | Midterm  | 80    |
| 1        | 2         | Final    | 70    |
| 2        | 2         | Preliminary | 70    |

Expected Output: 

| Student Name | Maths (Midterm) | Maths (Final) | Science (Preliminary) | Total Score | Average Score |
|--------------|-----------------|---------------|-----------------------|-------------|







Below is an example of an SQL statement that can produce the desired output, along with sample data and the expected output table result.

```SQL
SELECT 
    S.name AS 'Student Name', 
    C.name AS 'Course Name', 
    SC.score AS 'Score',
    (SELECT SUM(SC.score) 
     FROM student_courses SC 
     WHERE SC.student_id = S.student_id) as 'Total Score',
    (SELECT AVG(SC.score) 
     FROM student_courses SC 
     WHERE SC.course_id = C.course_id) as 'Average Score' 
FROM students S
INNER JOIN student_courses SC 
ON S.student_id = SC.student_id
INNER JOIN courses C 
ON SC.course_id = C.course_id
```

Sample Data:

Students Table

|student_id|name|
| -------- | -- |
| 1        | John |
| 2        | Jane |

Courses Table

|course_id|name|
| -------- | -- |
| 1        | Math |
| 2        | English |

Student_Courses Table

|student_id|course_id|score|
| -------- | ------- | ----|
| 1        | 1       | 80  |
| 1        | 2       | 90  |
| 2        | 1       | 70  |

Expected Output Table:

|Student Name|Math Score|English Score|Total Score|Average Score|Math Average|English Average|
| ---------- | -------- | ----------- | --------- | ----------- | ---------- | ------------- |
|John        |80        |90           |170        |85           |75          |80            |
|Jane        |70        |0            |70         |70           |70          |80            |






The following SQL query will generate the desired output table: 

```SQL
SELECT s.name AS Student_Name, 
       c.name AS Course_Name,
       es.score AS Course_Score, 
       SUM(es.score) OVER (PARTITION BY s.name) AS Total_Score, 
       AVG(es.score) OVER (PARTITION BY s.name) AS Average_Score
FROM students s
JOIN enrolment e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
JOIN exams_scores es ON e.id = es.enrolment_id
GROUP BY s.name, c.name, es.score
```

Example demo data for the above query:

Students (s):
+----+-------+
| id | name  |
+----+-------+
|  1 | John  |
|  2 | Jane  |
+----+-------+

Courses (c):
+----+-----------+
| id | name      |
+----+-----------+
|  1 | Math      |
|  2 | Science   |
|  3 | History   |
+----+-----------+

Enrolment (e):
+----+------------+-----------+
| id | student_id | course_id |
+----+------------+-----------+
|  1 |          1 |         1 |
|  2 |          1 |         2 |
|  3 |          1 |         3 |
|  4 |          2 |         2 |
|  5 |          2 |         3 |
+----+------------+-----------+

Exams Scores (es):
+-----+------------+---------+
| id  | enrolment_id | score  |
+-----+------------+---------+
|  1  |          1 |     5.0 |
|  2  |          2 |     8.0 |
|  3  |          3 |     7.0 |
|  4  |          4 |     9.0 |
|  5  |          5 |     6.0 |
+-----+------------+---------+

Result:

