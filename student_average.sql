--This SQL will give student average for the academic year selected [use variable "schoolYear"]--
SELECT
gibbonSchoolYear.name as schoolYear,
gibbonYearGroup.name AS yearGroup,
surname, preferredName,
COUNT(DISTINCT attainmentValue) as `gradeCount`,
SUM(attainmentValue) as `gradeTotal`,
ROUND(SUM(attainmentValue) / (COUNT(DISTINCT NULLIF(attainmentValue,''))), 2) as `gradeAverage`
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