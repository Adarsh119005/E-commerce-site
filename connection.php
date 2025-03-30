<?php
// Database credentials
$servername = "localhost"; // Replace with your database server (e.g., "127.0.0.1")
$username = "root";        // Replace with your database username
$password = "Adarsh#1234";            // Replace with your database password
$dbname = "e_site"; // Replace with your database name

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Close the connection when done (optional, for proper resource cleanup)
// $conn->close();
?>
