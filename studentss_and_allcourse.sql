--MYSQL ERROR--
SELECT
gibbonPerson.officialName as 'FullName',
gibbonCourse.name as 'Course Name',
gibbonInternalAssessmentEntry.attainmentValue as 'Score',

SUM(gibbonInternalAssessmentEntry.attainmentValue) OVER (PARTITION BY gibbonPerson.officialName) as 'Total Score',
AVG(gibbonInternalAssessmentEntry.attainmentValue) OVER (PARTITION BY gibbonPerson.officialName) as 'Average Score'

FROM gibbonPerson

LEFT JOIN gibbonStudentEnrolment ON gibbonStudentEnrolment.gibbonPersonID=gibbonPerson.gibbonPersonID
LEFT JOIN gibbonCourseClassPerson ON gibbonCourseClassPerson.gibbonPersonID=gibbonStudentEnrolment.gibbonPersonID
LEFT JOIN gibbonCourseClass ON gibbonCourseClass.gibbonCourseClassID=gibbonCourseClassPerson.gibbonCourseClassID
LEFT JOIN gibbonCourse ON gibbonCourse.gibbonCourseID=gibbonCourseClass.gibbonCourseID
LEFT JOIN gibbonInternalAssessmentColumn ON gibbonInternalAssessmentColumn.gibbonCourseID=gibbonCourse.gibbonCourseID
LEFT JOIN gibbonInternalAssessmentEntry ON gibbonInternalAssessmentEntry.gibbonInternalAssessmentColumnID=gibbonInternalAssessmentColumn.gibbonInternalAssessmentColumnID
WHERE gibbonCourse.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID
AND gibbonPerson.status='Full'
AND gibbonCourse.gibbonSchoolYearID=:schoolYear
GROUP BY gibbonPerson.officialName, gibbonCourse.name, gibbonInternalAssessmentEntry.attainmentValue