<?php
session_start();
include 'connection.php';

// Check if user is logged in
if (!isset($_SESSION["user_id"])) {
    echo "<script>alert('Please log in to view your orders.'); window.location.href='Login.php';</script>";
    exit;
}

$user_id = $_SESSION['user_id'];

// Fetch orders
$order_query = "SELECT 
    o.order_id, 
    o.created_at, 
    o.order_status, 
    o.total_amount, 
    GROUP_CONCAT(oi.pro_id) AS product_ids, 
    GROUP_CONCAT(p.image_url) AS product_images
FROM Orders o
LEFT JOIN Order_Item oi ON o.order_id = oi.order_id
LEFT JOIN Products p ON oi.pro_id = p.pro_id
WHERE o.user_id = ?
GROUP BY o.order_id
ORDER BY o.created_at DESC
";
$stmt = mysqli_prepare($conn, $order_query);
mysqli_stmt_bind_param($stmt, "i", $user_id);
mysqli_stmt_execute($stmt);
$orders_result = mysqli_stmt_get_result($stmt);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <link rel="stylesheet" href="order_list.css">
</head>
<body>

<div id="navbar-container"><?php include 'load.php'; ?></div><br>


<h1 style="color:skyblue;"> My Orders </h1>
<center>
<div class="cart-container">
<?php while ($order = mysqli_fetch_assoc($orders_result)): ?>
    <form method="get" action="order.php">
        <div class="cart-item">
            <input type="hidden" name="order_id" value="<?php echo $order['order_id'] ?>">
            <img src="<?php echo $order['product_images']; ?>"  alt="Laptop">
            <button type="submit">
                <div class="cart-details">
                    <h3>Order ID: <?php echo $order['order_id'] ?></h3>
                    <p>Order_date:<?php echo date("d M Y", strtotime($order['created_at'])); ?></p>
                    <p class="price">Total Amount:&nbsp; ₹<?php echo number_format($order['total_amount'], 2); ?></p>
                </div>
           </button>
        </div>
</form>
        <?php endwhile; ?>
 </div>
</center>


</body>
</html>
