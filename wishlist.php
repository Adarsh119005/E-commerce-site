<?php
session_start(); // Start session on every page using session data

// Check if the user is logged in
if (isset($_SESSION["mobile"]) || isset($_SESSION["password"])) {
    $name_parts = explode(" ", trim($_SESSION['name']));
    $first_name = $name_parts[0];

} else {
    $first_name='User';
}

include 'connection.php';

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST["remove"])) {
        if (isset($_SESSION['user_id']) && isset($_POST['remove'])) {
            $user_id = $_SESSION['user_id'];  // Assuming 'name' is used as user_id
            $pro_id = $_POST['remove'];
            $sql1 = "DELETE FROM Wishlist WHERE user_id = ? AND pro_id=?";
            $stmt1 = $conn->prepare($sql1);
            if ($stmt1) {
                $stmt1->bind_param("si", $user_id, $pro_id); // "s" for string, "i" for integer
                if ($stmt1->execute()) {
                    echo "Product removed from wishlist successfully!";
                } else {
                    echo "Error: " . $stmt1->error;
                }
            } else {
                echo "Error in SQL statement.";
            }
        }

    }
}




?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
   
    <title>Wishlist</title>
    <link rel="stylesheet" href="wishlist.css">
</head>
<body>
     <!-- Navbar will be inserted here -->
     <div id="navbar-container"><?php include 'load.php'?></div>


<?php

if(isset($_SESSION['user_id'])){
    $sql="SELECT * FROM Wishlist WHERE user_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('i', $_SESSION['user_id']);
    $stmt->execute();
    $results = $stmt->get_result();
    ?>
<div class="whole">
        <div class="user">
            <ul>
                <li><img src="https://t4.ftcdn.net/jpg/02/54/21/61/360_F_254216141_ZIWWpUlP2I5sAVpUDvhCAXVs5eBEKHoj.jpg" alt="..">&nbsp;&nbsp;Hello, <b>ADARSH</b></li>
            </ul><br>
            <ul>
                <li><i class="fa-solid fa-user"></i>&nbsp;&nbsp; <b>Account Setting</b></li>
                <li class="side1"><a href="/profile.php">Profile Information</a></li>
                <li class="side1"><a href="/address.php">Manage Address</a></li>
                <hr>
                <li><i class="fa-solid fa-folder"></i>&nbsp;&nbsp;&nbsp;<b>My Stuff</b></li>
                <li class="side1"><a href="/cupon.php">My Coupons</a></li>
                <li class="side1"><a href="">My Reviews & Rating</a></li>
                <li class="side1"><a href="">All Notification</a></li>
                <li class="side1"><a href="/wishlist.php">My Wishlist</a></li>
            </ul>
     </div>

     <div class="wishlist-container">
        <!-- Wishlist Header -->
        <div class="wishlist-header">My Wishlist (<?php echo $results->num_rows; ?>)</div>
      <?php 
       while($row = $results->fetch_assoc()){
            $sql1="SELECT * FROM Products WHERE pro_id = ?";
            $stmt1 = $conn->prepare($sql1);
            $stmt1->bind_param('i', $row['pro_id']);
            $stmt1->execute();
            $result = $stmt1->get_result();
            while($rows = $result->fetch_assoc()) {   
                $new_price = $rows['pro_price'] - $rows['discount']; ?>

        <!-- Wishlist Item -->
        <a href="" style="text-decoration: none;">
            <div class="wishlist-item">
                <div class="wishlist-content">
                    <img src="<?php echo $rows['image_url']; ?>" alt="T-Shirt">
                    <div class="product-info">
                        <div class="product-name"><?php echo $rows['pro_name']; ?></div>
                        <div class="product-name"><?php echo $rows['description']; ?></div>
                        <div class="product-price">
                        ₹<?php echo $new_price ?> <span class="old-price">₹<?php echo $rows['pro_price']; ?></span> <span class="discount"><?php echo $rows['discount']; ?>off</span>
                        </div>
                    </div>
                </div>
                <form method="POST">
                <input type="hidden" name="remove" value="<?php echo $rows['pro_id']; ?>">
                <button type="submit"><i class="fas fa-trash remove-item"></i></button>
            </form>
            </div><br>
        </a>
        <?php        
    }
}


?>
    </div>

</div>
<?php
}
else {
    ?>

<div class="not">
        <div class="show">
            <img src="https://img.freepik.com/free-vector/user-blue-gradient_78370-4692.jpg?semt=ais_hybrid" alt="Laptop"><br><br><br>
            <h1> Login into your Account </h1>      
         
        </div>
        <a href="Login.php"><div class="log-in">Log-In</div></a>
            
</div>
<?php } ?>
</body>
</html>