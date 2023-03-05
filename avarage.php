//step 6 Calculate total score for each student
if (!isset($totals[$studentID])) {
    $totals[$studentID] = 0;
    $counters[$studentID] = 0;
}
$totals[$studentID] += $attainmentValue;
$counters[$studentID]++;

// Calculate total score for each course
if (!isset($totals[$courseID])) {
    $totals[$courseID] = 0;
    $counters[$courseID] = 0;
}
$totals[$courseID] += $attainmentValue;
$counters[$courseID]++;

// Step 7: Calculate and display average score for each course
$courseAverage = [];
foreach ($courseNames as $courseName) {
    $totalScore = 0;
    $count = 0;
    foreach ($tableData as $data) {
        if ($data['courseName'] == $courseName) {
            $totalScore += $data['attainmentValue'];
            $count++;
        }
    }
    $averageScore = $count > 0 ? round($totalScore / $count, 2) : 0;
    $courseAverage[$courseName] = $averageScore;
}

$table .= '<tfoot><tr>';
$table .= '<td colspan="7">Average Score:</td>';
foreach ($courseNames as $courseName) {
    $table .= '<td>'.$courseAverage[$courseName].'</td>';
}
$table .= '</tr></tfoot>';
$table .= '</table>';

echo $table;
