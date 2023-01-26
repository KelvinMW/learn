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