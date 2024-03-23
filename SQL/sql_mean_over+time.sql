SELECT
    sy.name AS SchoolYearName,
    yg.name AS YearGroupName,
    c.name AS CourseName,
    AVG(e.attainmentValue) AS AverageGrade
FROM
    gibbonInternalAssessmentEntry e
JOIN gibbonInternalAssessmentColumn col ON e.gibbonInternalAssessmentColumnID = col.gibbonInternalAssessmentColumnID
JOIN gibbonCourseClass cc ON col.gibbonCourseClassID = cc.gibbonCourseClassID
JOIN gibbonCourse c ON cc.gibbonCourseID = c.gibbonCourseID
JOIN gibbonStudentEnrolment se ON e.gibbonPersonIDStudent = se.gibbonPersonID
JOIN gibbonYearGroup yg ON se.gibbonYearGroupID = yg.gibbonYearGroupID
JOIN gibbonSchoolYear sy ON se.gibbonSchoolYearID = sy.gibbonSchoolYearID
GROUP BY
    sy.name, yg.name, c.name
