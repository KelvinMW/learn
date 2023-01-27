--sample-
SELECT 
    *,
    SUM(score) AS total_score,
    AVG(score) AS average_score
    FROM 
    (
        SELECT
            s.id,
            s.name,
            c.name AS course_name,
            e.score 
        FROM 
            students s
        LEFT JOIN 
            enrolment e
        ON 
            s.id = e.student_id
        LEFT JOIN 
            courses c
        ON 
            e.course_id = c.id
    ) 
GROUP BY 
   id
ORDER BY 
   total_score DESC
LIMIT 10;

SELECT 
    AVG(score) AS mean_average
FROM 
    enrolment
GROUP BY 
    course_id;






    SELECT
*,
COUNT(NULLIF(attainmentValue,'')) as `ExamsDone`,
SUM(attainmentValue) as `gradeTotal`,
ROUND(SUM(attainmentValue) / (COUNT(NULLIF(attainmentValue,''))), 2) as `gradeAverage`
FROM
(
    SELECT
   person.gibbonPersonID,
    person.officialName,
    Course.name as course_name,
    marks.attainmentValue

    FROM gibbonInternalAssessmentEntry as marks
    JOIN gibbonPerson as person
    JOIN gibbonStudentEnrolment enrolment ON (enrolment.gibbonPersonID=marks.gibbonPersonIDStudent)
    JOIN gibbonYearGroup ON (enrolment.gibbonYearGroupID=gibbonYearGroup.gibbonYearGroupID)
    JOIN gibbonInternalAssessmentColumn ON (marks.gibbonInternalAssessmentColumnID=assesmentcolumn.gibbonInternalAssessmentColumnID)
    JOIN gibbonCourseClass ON (gibbonInternalAssessmentColumn.gibbonCourseClassID=gibbonCourseClass.gibbonCourseClassID)
    JOIN gibbonCourse as Course ON (gibbonCourseClass.gibbonCourseID=gibbonCourse.gibbonCourseID)
    JOIN gibbonSchoolYear ON (gibbonStudentEnrolment.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID) 
    WHERE gibbonCourse.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID
AND gibbonPerson.status='Full'
AND gibbonCourse.gibbonSchoolYearID=:schoolYear
)

GROUP BY marks.gibbonPersonIDStudent
ORDER BY
yearGroup, surname, preferredName

SELECT ROUND(SUM(attainmentValue) / (COUNT(NULLIF(attainmentValue,''))), 2) as `meanAverage`
FROM gibbonStudentEnrolment
GROUP BY gibbonCourseID











--another sample--

SELECT s.student_id, s.name, e.course, e.exam_group, s.score AS 'Score',
  AVG(s.score) OVER (PARTITION BY e.student_id) AS 'Student Average',
  AVG(s.score) OVER (PARTITION BY e.exam_group) AS 'Course Average' 
FROM student_records s INNER JOIN student_enrolment e 
  ON s.student_id = e.student_id 
  INNER JOIN student_scores sc ON e.student_id = sc.student_id
  INNER JOIN exam_group g ON e.exam_group = g.exam_group
LIMIT 10;