<!DOCTYPE html>
<html>
<head>
	<title>Submit Data to Different Databases</title>
</head>
<body>
	<h2>Submit Data to Different Databases</h2>
	<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
		<label for="database">Select a database:</label>
		<select name="database">
			<option value="database1">Database 1</option>
			<option value="database2">Database 2</option>
			<option value="database3">Database 3</option>
		</select>
		<br><br>
		<label for="name">Enter your name:</label>
		<input type="text" name="name" required>
		<br><br>
		<label for="email">Enter your email:</label>
		<input type="email" name="email" required>
		<br><br>
		<input type="submit" value="Submit">
	</form>

	<?php
		if ($_SERVER["REQUEST_METHOD"] == "POST") {
			$database = $_POST["database"];
			$name = $_POST["name"];
			$email = $_POST["email"];

			// Connect to the selected database
			if ($database == "database1") {
				$conn = mysqli_connect("database1.example.com", "username", "password", "database1");
			} elseif ($database == "database2") {
				$conn = mysqli_connect("database2.example.com", "username", "password", "database2");
			} elseif ($database == "database3") {
				$conn = mysqli_connect("database3.example.com", "username", "password", "database3");
			}

			// Check connection
			if (!$conn) {
				die("Connection failed: " . mysqli_connect_error());
			}

			// Insert data into the selected database
			$sql = "INSERT INTO users (name, email) VALUES ('$name', '$email')";

			if (mysqli_query($conn, $sql)) {
				echo "Data submitted successfully to $database!";
			} else {
				echo "Error: " . $sql . "<br>" . mysqli_error($conn);
			}

			mysqli_close($conn);
		}
	?>
</body>
</html>
