<?php
include 'connection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (!isset($_POST["table"]) || !isset($_POST["values"])) {
        die("Missing table name or values.");
    }

    $table = $_POST["table"];
    $values = $_POST["values"];

    // Validate table name (prevent SQL injection)
    $table = preg_replace("/[^a-zA-Z0-9_]/", "", $table);

    // Fetch column names
    $sql = "SHOW COLUMNS FROM `$table`";
    $result = $conn->query($sql);
    
    if (!$result) {
        die("Error fetching table columns: " . $conn->error);
    }

    $columns = [];
    $types = "";
    $filteredValues = [];

    while ($row = $result->fetch_assoc()) {
        $columns[] = $row["Field"];

        // Determine data type for binding
        if (strpos($row["Type"], "int") !== false) {
            $types .= "i"; // Integer
        } elseif (strpos($row["Type"], "double") !== false || strpos($row["Type"], "float") !== false || strpos($row["Type"], "decimal") !== false) {
            $types .= "d"; // Double/Float
        } elseif (strpos($row["Type"], "blob") !== false) {
            $types .= "b"; // Blob
        } else {
            $types .= "s"; // String (default)
        }
    }

    // Ensure the number of values matches the number of columns
    if (count($columns) != count($values)) {
        die("Error: Column count does not match value count.");
    }

    // Prepare SQL statement
    $placeholders = implode(',', array_fill(0, count($values), '?'));
    $sql = "INSERT INTO `$table` (" . implode(',', $columns) . ") VALUES ($placeholders)";
    $stmt = $conn->prepare($sql);

    if (!$stmt) {
        die("Error preparing statement: " . $conn->error);
    }

    // Convert values to an array of references for bind_param()
    $stmt->bind_param($types, ...array_values($values));

    // Execute and handle response
    if ($stmt->execute()) {
        echo "Data inserted successfully!";
        exit();
    } else {
        echo "Error inserting data: " . $stmt->error;
    }

    // Close statement and connection
    $stmt->close();
    $conn->close();
}
?>
