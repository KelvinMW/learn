SELECT 
    s.name AS student_name,
    c.name AS course_name,
    et.name AS exam_type,
    sc.score,
    SUM(sc.score) OVER (PARTITION BY s.id) AS total_score,
    AVG(sc.score) OVER (PARTITION BY s.id) AS average_score
FROM 
    students s
    INNER JOIN enrolment e ON s.id = e.student_id
    INNER JOIN courses c ON e.course_id = c.id
    INNER JOIN exam_types et ON c.id = et.course_id
    INNER JOIN scores sc ON e.id = sc.enrolment_id
ORDER BY 
    s.name, c.name, et.name;









SELECT s.id AS StudentID, s.name AS StudentName, 
  AVG(CASE WHEN e.course_id = 1 THEN sc.score END) AS Course1Score,
  AVG(CASE WHEN e.course_id = 2 THEN sc.score END) AS Course2Score,
  AVG(CASE WHEN e.course_id = 3 THEN sc.score END) AS Course3Score,
  AVG(CASE WHEN e.course_id = 4 THEN sc.score END) AS Course4Score,
  AVG(CASE WHEN e.course_id = 5 THEN sc.score END) AS Course5Score
FROM students s
INNER JOIN enrolment e ON s.id = e.student_id
INNER JOIN scores sc ON e.id = sc.enrolment_id
GROUP BY s.id
WITH ROLLUP;
