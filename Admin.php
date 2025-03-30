<?php
session_start();
include 'connection.php';

// Check if user is logged in
if (!isset($_SESSION["mobile"]) || !isset($_SESSION["password"])) {
    header("Location: Login.php");
    exit();
}

$tab_name = "";
$columns = [];
$result1 = null;

// Handle Fetch Request
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST["form-type"]) && $_POST["form-type"] == "fetch") {
    if (isset($_POST["tbl_name"])) {
        $tab_name = $_POST['tbl_name'];
        $sql1 = "SELECT * FROM `$tab_name`";
        $stmt1 = $conn->prepare($sql1);
        $stmt1->execute();
        $result1 = $stmt1->get_result();

        // Fetch column types
        $sql2 = "SHOW COLUMNS FROM `$tab_name`";
        $result2 = $conn->query($sql2);
        while ($col = $result2->fetch_assoc()) {
            $columns[$col["Field"]] = $col["Type"];
        }
    }
}

// Fetch Table Names
$sql = "SHOW TABLES";
$result = $conn->query($sql);

// Function to determine input type
function getInputType($columnType) {
    if (strpos($columnType, 'int') !== false) return 'number';
    if (strpos($columnType, 'varchar') !== false || strpos($columnType, 'text') !== false) return 'text';
    if (strpos($columnType, 'date') !== false) return 'date';
    if (strpos($columnType, 'timestamp') !== false || strpos($columnType, 'datetime') !== false) return 'datetime-local';
    if (strpos($columnType, 'email') !== false) return 'email';
    if (strpos($columnType, 'boolean') !== false || strpos($columnType, 'tinyint(1)') !== false) return 'checkbox';
    return 'text';
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Wishlist</title>
    <link rel="stylesheet" href="Admin.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="navbar-container"><?php include 'load.php' ?></div><br>

<div class="whole">
    <div class="user">
        <ul>
            <li><img src="https://www.xtechzplus.com/cdn/shop/files/EDA006126501A_c288e9a0-9dc2-405a-8b3e-a9e8acc9c0db.jpg?v=1705649036" alt="..">&nbsp;&nbsp;Hello, <b>ADARSH</b></li>
        </ul><br>
        <ul>
            <li><i class="fa-solid fa-user"></i>&nbsp;&nbsp; <b>Account Setting</b></li>
            <?php if ($result->num_rows > 0) { ?>
                <ul>
                    <?php while ($row = $result->fetch_row()) { ?>
                        <form method="post">
                            <input type="hidden" name="form-type" value="fetch">
                            <li class="side1">
                                <button id="table" name="tbl_name" type="submit" value="<?php echo $row[0]; ?>"><?php echo $row[0]; ?></button>
                            </li>
                            <hr>
                        </form>
                    <?php } ?>
                </ul>
            <?php } else { echo "No tables found."; } ?>
        </ul>
    </div>

    <div class="wishlist-container">
        <div class="data">
            <?php if ($result1) { ?>
                <table border="1" id="data-table">
                    <tr>
                        <?php foreach ($columns as $colName => $colType) { ?>
                            <th><?php echo $colName; ?></th>
                        <?php } ?>
                        <th>Action</th>
                    </tr>
                    
                    <?php while ($row = $result1->fetch_assoc()) { ?>
                        <tr>
                            <?php foreach ($row as $colName => $value) { ?>
                                <td><input type="<?php echo getInputType($columns[$colName]); ?>" value="<?php echo htmlspecialchars($value); ?>"></td>
                            <?php } ?>
                            <td><button class="save-btn">Save</button></td>
                        </tr>
                    <?php } ?>
                    
                    <!-- Empty Row for New Data -->
                    <tr id="new-row">
                        <?php foreach ($columns as $colName => $colType) { ?>
                            <td>
                                <input type="<?php echo getInputType($colType); ?>" name="<?php echo $colName; ?>" placeholder="Enter <?php echo $colName; ?>">
                            </td>
                        <?php } ?>
                        <td><button class="insert-btn">Insert</button></td>
                    </tr>
                </table>
            <?php } ?>
        </div>
    </div>
</div>

<script>
$(document).ready(function(){
    $(".insert-btn").click(function(){
        var table = "<?php echo $tab_name; ?>";
        var values = {};

        $("#new-row input").each(function(){
            var colName = $(this).attr("name");
            var colValue = $(this).val();
            values[colName] = colValue;
        });

        $.ajax({
            url: "insert.php",
            type: "POST",
            data: {table: table, values: values},
            success: function(response){
                alert(response);
                location.reload()
            }
        });
    });
});
</script>

</body>
</html>
