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
*,
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

    FROM gibbonInternalAssessmentEntry

    JOIN gibbonStudentEnrolment ON (gibbonStudentEnrolment.gibbonPersonID=gibbonInternalAssessmentEntry.gibbonPersonIDStudent)
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