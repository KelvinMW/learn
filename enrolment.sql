SELECT COUNT(gibbonStudentEnrolment.gibbonPersonID) as total , gibbonYearGroup.name, gibbonSchoolYear.gibbonSchoolYearID
FROM gibbonStudentEnrolment

INNER JOIN gibbonSchoolYear
ON gibbonStudentEnrolment.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID

INNER JOIN gibbonYearGroup
ON gibbonStudentEnrolment.gibbonYearGroupID=gibbonYearGroup.gibbonYearGroupID

GROUP BY gibbonYearGroup.name, gibbonSchoolYear.gibbonSchoolYearID
LIMIT 50


--CURRENT SCHOOL YEAR--
SELECT COUNT(gibbonStudentEnrolment.gibbonPersonID) as total , gibbonYearGroup.name, gibbonSchoolYear.gibbonSchoolYearID as 'Academic Year'
FROM gibbonStudentEnrolment

INNER JOIN gibbonSchoolYear
ON gibbonStudentEnrolment.gibbonSchoolYearID=gibbonSchoolYear.gibbonSchoolYearID

INNER JOIN gibbonYearGroup
ON gibbonStudentEnrolment.gibbonYearGroupID=gibbonYearGroup.gibbonYearGroupID
WHERE gibbonSchoolYear.status='Current'
GROUP BY gibbonYearGroup.name, gibbonSchoolYear.gibbonSchoolYearID
LIMIT 50