SELECT gibbonPerson.`officialName` AS StudentName,
  AVG(CASE WHEN gibbonCourse.name = 'ENGLISH' THEN gibbonInternalAssessmentEntry.`attainmentValue` END) AS ENGLISH,
  AVG(CASE WHEN gibbonCourse.name = 'MATHEMATICS' THEN gibbonInternalAssessmentEntry.`attainmentValue` END) AS MATH,
  AVG(CASE WHEN gibbonCourse.name = 'BIOLOGY' THEN gibbonInternalAssessmentEntry.`attainmentValue` END) AS BIOLOGY,
  SUM(gibbonInternalAssessmentEntry.`attainmentValue`) AS TotalScore,
  AVG(gibbonInternalAssessmentEntry.`attainmentValue`) AS AverageScore
FROM gibbonInternalAssessmentEntry
INNER JOIN gibbonPerson ON gibbonPerson.gibbonPersonID = gibbonInternalAssessmentEntry.gibbonPersonIDStudent
INNER JOIN gibbonInternalAssessmentColumn ON gibbonInternalAssessmentColumn.gibbonInternalAssessmentColumnID= gibbonInternalAssessmentEntry.`gibbonInternalAssessmentColumnID`
INNER JOIN gibbonCourseClass ON gibbonCourseClass.gibbonCourseClassID = gibbonInternalAssessmentColumn.gibbonCourseClassID
INNER JOIN gibbonCourse ON gibbonCourse.gibbonCourseID = gibbonCourseClass.gibbonCourseID
GROUP BY StudentName WITH ROLLUP;
