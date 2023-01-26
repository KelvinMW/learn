SELECT
gibbonSchoolYear.name as schoolYear,
gibbonYearGroup.name AS yearGroup,
surname, preferredName,
COUNT(DISTINCT attainmentValue) + COUNT(DISTINCT effortValue) as `gradeCount`,
SUM(attainmentValue + effortValue) as `gradeTotal`,
ROUND(SUM(attainmentValue + effortValue) / (COUNT(DISTINCT attainmentValue) + COUNT(DISTINCT effortValue)), 2) as `gradeAverage`
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
