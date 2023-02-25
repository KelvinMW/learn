<?php
// Get the course IDs from user input
$course1_id = $_POST['course1_id'];
$course2_id = $_POST['course2_id'];
$course3_id = $_POST['course3_id'];
$course4_id = $_POST['course4_id'];
$course5_id = $_POST['course5_id'];

// Connect to the database
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "database";
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Prepare the SQL query
$query = "
  SET @course1_id = ?;
  SET @course2_id = ?;
  SET @course3_id = ?;
  SET @course4_id = ?;
  SET @course5_id = ?;
  PREPARE stmt FROM '
    SELECT s.id AS StudentID, s.name AS StudentName,
      AVG(CASE WHEN e.course_id = ? THEN sc.score END) AS Course1Score,
      AVG(CASE WHEN e.course_id = ? THEN sc.score END) AS Course2Score,
      AVG(CASE WHEN e.course_id = ? THEN sc.score END) AS Course3Score,
      AVG(CASE WHEN e.course_id = ? THEN sc.score END) AS Course4Score,
      AVG(CASE WHEN e.course_id = ? THEN sc.score END) AS Course5Score,
      SUM(sc.score) AS TotalScore,
      AVG(sc.score) AS AverageScore
    FROM students s
    INNER JOIN enrolment e ON s.id = e.student_id
    INNER JOIN scores sc ON e.id = sc.enrolment_id
    WHERE e.course_id IN (?, ?, ?, ?, ?)
    GROUP BY s.id WITH ROLLUP
  ';
  EXECUTE stmt USING @course1_id, @course2_id, @course3_id, @course4_id, @course5_id, @course1_id, $course2_id, $course3_id, $course4_id, $course5_id;
  DEALLOCATE PREPARE stmt;
";

// Run the SQL query
$stmt = mysqli_prepare($conn, $query);
mysqli_stmt_bind_param($stmt, "iiiii", $course1_id, $course2_id, $course3_id, $course4_id, $course5_id);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

// Display the results in a table
echo "<table>";
echo "<tr><th>Student ID</th><th>Student Name</th><th>Course 1 Score</th><th>Course 2 Score</th><th>Course 3 Score</th><th>Course 4 Score</th><th>Course 5 Score</th><th>Total Score</th><th>Average Score</th></tr>";
while ($row = mysqli_fetch_assoc($result)) {
  echo "<tr>";
  echo "<td>" . $row['StudentID'] . "</td>";
  echo "<td>" . $row['StudentName'] . "</td>";
  echo "<td>" . $row['Course1Score'] . "</td>";
  echo "<td>" . $row['Course2Score'] . "</td>";
  echo "<td>" . $row['Course3Score'] . "</td>";
  echo "<td>" . $row['Course4Score'] . "</td>";
  echo "<td>" . $row['Course5Score'] . "</td>";
  echo "<td>" . $row['TotalScore'] . "</td>";
  echo "<td>" . $
