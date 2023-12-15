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
