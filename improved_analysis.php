<?php
// Get the input parameters from user input
$exam_type_name = $_POST['exam_type_name'];
$class_year_group = $_POST['class_year_group'];
$course_ids = explode(',', $_POST['course_ids']);

// Connect to the database
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "database";
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Build the comma-separated list of course IDs for the SQL query
$course_ids_str = implode(',', $course_ids);

// Prepare the SQL query
$query = "
  SET @exam_type_name = ?;
  SET @class_year_group = ?;
  SET @courses = ?;
  SET @sql = CONCAT('SELECT s.id AS StudentID, s.name AS StudentName, ',
    GROUP_CONCAT(
      CONCAT(
        'AVG(CASE WHEN e.course_id = ',
        c.id,
        ' THEN sc.score END) AS ',
        REPLACE(c.name, ' ', ''),
        'Score'
      )
      SEPARATOR ', '
    ),
    ', SUM(sc.score) AS TotalScore, AVG(sc.score) AS AverageScore ',
    'FROM students s ',
    'INNER JOIN enrolment e ON s.id = e.student_id ',
    'INNER JOIN courses c ON e.course_id = c.id ',
    'INNER JOIN exam_types et ON c.id = et.course_id ',
    'INNER JOIN scores sc ON e.id = sc.enrolment_id ',
    'WHERE et.name = ? AND s.class_year_group = ? AND e.course_id IN (',
    @courses
