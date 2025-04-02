SELECT
    sy.name AS school_year,
    sy.gibbonSchoolYearID AS school_year_id,
    c.name AS course_name,
    c.gibbonCourseID AS course_id,
    cc.name AS class_name,
    cc.gibbonCourseClassID AS class_id,
    iac.name AS assessment_name,
    iac.gibbonInternalAssessmentColumnID AS assessment_id,
    iac.completeDate AS assessment_date,
    COUNT(DISTINCT iae.gibbonPersonIDStudent) AS students_assessed,
    AVG(CAST(iae.attainmentValue AS DECIMAL(10, 2))) AS average_score
FROM
    gibbonInternalAssessmentEntry AS iae
JOIN
    gibbonInternalAssessmentColumn AS iac
    ON iae.gibbonInternalAssessmentColumnID = iac.gibbonInternalAssessmentColumnID
JOIN
    gibbonCourseClass AS cc
    ON iac.gibbonCourseClassID = cc.gibbonCourseClassID
JOIN
    gibbonCourse AS c
    ON cc.gibbonCourseID = c.gibbonCourseID
JOIN
    gibbonSchoolYear AS sy
    ON c.gibbonSchoolYearID = sy.gibbonSchoolYearID
WHERE
    -- Filter for numeric values for averaging
    iae.attainmentValue IS NOT NULL
    AND iae.attainmentValue != ''
    AND iac.attainment = 'Y' -- Consider only columns marked for attainment calculation
GROUP BY
    sy.name,
    sy.gibbonSchoolYearID,
    c.name,
    c.gibbonCourseID,
    cc.name,
    cc.gibbonCourseClassID,
    iac.name,
    iac.gibbonInternalAssessmentColumnID,
    iac.completeDate
ORDER BY
    sy.name,
    c.name,
    cc.name,
    iac.completeDate ASC;
