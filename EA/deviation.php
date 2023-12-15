https://lh3.googleusercontent.com/bard/APmgjFtDyAFPQbIsO50L7p0JtWWLZwNUMtTaqRKUsjR6cRQT02oO3eqe5K5T4bkbQzVyHj5yZDv0VXacfKorfEul5XUF9Mr5CBfBXTA_gNMm4UzZ52G2RwJMxqMTj12RmbhRGhTpUXgX2YqLfrNmfJVN51hsLwqGcbJgMVops6lAxg902X8mTkyG-ayM2-yONOd87mjuCMr64EGkVKySmch8xzEXps_Zv50zXgTaGmmirx41JXPOIw_weZ_p3eZjbrjmnlibsCMpvD8ICO3g8qrekysbKAZZ-A
$sqlResult = $result->fetchAll(PDO::FETCH_ASSOC); // Assuming $result stores your query results

foreach ($sqlResult as &$row) {
  $values = array_column($sqlResult, 'mean_score'); // Extract all mean scores
  $row['standard_deviation'] = number_format(sqrt(array_sum(array_map(function ($v) { return pow($v - $row['mean_score'], 2); }, $values)) / (count($values) - 1)), 2); // Calculate and format standard deviation
}

unset($row); // Unset reference to avoid data duplication


SELECT c.name AS CourseName, fg.name AS FormGroupName, iac.type AS exam_type, AVG(e.attainmentValue) AS mean_score
FROM gibbonCourse AS c
INNER JOIN gibbonCourseClass AS cc ON c.gibbonCourseID = cc.gibbonCourseID
INNER JOIN gibbonInternalAssessmentColumn AS iac ON cc.gibbonCourseClassID = iac.gibbonCourseClassID
INNER JOIN gibbonInternalAssessmentEntry AS e ON iac.gibbonInternalAssessmentColumnID = e.gibbonInternalAssessmentColumnID
INNER JOIN gibbonStudentEnrolment AS se ON e.gibbonPersonIDStudent = se.gibbonPersonID
INNER JOIN gibbonFormGroup AS fg ON se.gibbonFormGroupID = fg.gibbonFormGroupID
WHERE sy.gibbonSchoolYearID = :gibbonSchoolYearID
AND iac.type IN (:examTypes)
AND c.gibbonCourseID IN (:courses)
AND fg.gibbonFormGroupID = :formGroup
GROUP BY c.name, fg.name, iac.type

<?php foreach ($formattedData as $row): ?>
<tr>
  <td><?php echo $row['CourseName']; ?></td>
  <td><?php echo $row['FormGroupName']; ?></td>
  <td><?php echo $row['exam_type']; ?></td>
  <td><?php echo $row['mean_score']; ?></td>
  <td><?php echo $row['standard_deviation']; ?></td>
</tr>
<?php endforeach; ?>



<table class="table">
  <thead>
    <tr>
      <th>Course Name</th>
      <th>Form Group</th>
      <th>Exam Type</th>
      <th>Mean Score</th>
      <th>Standard Deviation</th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($formattedData as $row): ?>
    <tr>
      <td><?php echo $row['CourseName']; ?></td>
      <td><?php echo $row['FormGroupName']; ?></td>
      <td><?php echo $row['exam_type']; ?></td>
      <td><?php echo number_format($row['mean_score'], 2); ?></td>
      <td><?php echo number_format($row['standard_deviation'], 2); ?></td>
    </tr>
    <?php endforeach; ?>
  </tbody>
</table>
