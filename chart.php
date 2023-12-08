//new1
foreach ($courseNames as $index => $courseName): ?>
  <?php if (array_key_exists($index % count($colors), $colors) && array_key_exists($index % count($borderColors), $borderColors)): ?>
    {
      label: '<?php echo $courseName; ?>',
      data: [<?php echo implode(',', $meanScores[$index]); ?>],
      backgroundColor: colors[<?php echo $index % count($colors); ?>],
      borderColor: borderColors[<?php echo $index % count($borderColors); ?>],
      borderWidth: 1
    },
  <?php else: ?>
    console.error('Invalid array index for colors or borderColors');
  <?php endif; ?>
<?php endforeach; ?>
//new
if (!empty($colors) && !empty($borderColors)): ?>
<?php foreach ($courseNames as $index => $courseName): ?>
  {
    label: '<?php echo $courseName; ?>',
    data: [<?php echo implode(',', $meanScores[$index]); ?>],
    backgroundColor: colors[<?php echo $index % count($colors); ?>],
    borderColor: borderColors[<?php echo $index % count($borderColors); ?>],
    borderWidth: 1
  },
<?php endforeach; ?>
<?php else: ?>
  console.error('Colors arrays cannot be empty');
<?php endif; ?>

