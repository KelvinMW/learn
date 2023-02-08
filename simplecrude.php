```php
<?php
//establishing connection
$con = mysqli_connect("localhost","username","password","database_name");

//Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

//creating the CRUDE app
if (isset($_POST['create'])) {
    //sql query to create table
    $sql = "CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `email` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";
    
    //Execute query
    if (mysqli_query($con,$sql)){
        echo "Table myTable created successfully";
    } else {
        echo "Error creating table: " . mysqli_error($con);
    }
}

if (isset($_POST['insert'])) {
    //sql query to insert value
    $sql = "INSERT INTO `users` (`name`, `email`)
    VALUES ('John', 'john@example.com');";
    
    //Execute query
    if (mysqli_query($con,$sql)){
        echo "Value inserted successfully";
    } else {
        echo "Error inserting value: " . mysqli_error($con);
    }
}

if (isset($_POST['update'])) {
    //sql query to update value
    $sql = "UPDATE `users` SET `name` = 'Steve' WHERE `id` = 1;";
    
    //Execute query
    if (mysqli_query($con,$sql)){
        echo "Value updated successfully";
    } else {
        echo "Error updating value: " . mysqli_error($con);
    }
}

if (isset

