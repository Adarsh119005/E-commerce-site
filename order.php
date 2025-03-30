<?php
session_start();
include 'connection.php';

// Check if user is logged in
if (!isset($_SESSION["user_id"])) {
    echo "<script>alert('Please log in to view your orders.'); window.location.href='Login.php';</script>";
    exit;
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['cancel'])) {
    $cancel = $_POST['cancel'];

    // Use a prepared statement to prevent SQL injection
    $sql = "UPDATE Orders SET order_status = ?, payment_status = ?, updated_at = NOW() WHERE order_id = ?";
    $stmt = $conn->prepare($sql);
    $order_status = "Canceled";
    $payment_status = "Returned"; 

    $stmt->bind_param("ssi", $order_status, $payment_status, $cancel);

    $sql1 = "UPDATE Payment SET payment_status = ? WHERE order_id = ?";
    $stmt1 = $conn->prepare($sql1);
    $payment = "Failed"; 
    $stmt1->bind_param("si", $payment, $cancel);
    
    if ($stmt->execute() && $stmt1->execute()) {
        echo "<script>alert('Order Canceled Successfully!'); window.location.href='order.php';</script>";
        exit();
    } else {
        echo "<script>alert('Error: " . $stmt->error . "');</script>";
    }
}

$user_id = $_SESSION['user_id'];
$order_id = isset($_GET['order_id']) ? $_GET['order_id'] : null;

if (!$order_id) {
    echo "<script>alert('Invalid Order ID.'); window.location.href='orders.php';</script>";
    exit;
}

// Fetch order details
$order_query = "SELECT * FROM Orders WHERE order_id = ? AND user_id = ?";
$stmt = $conn->prepare($order_query);
$stmt->bind_param("ii", $order_id, $user_id);
$stmt->execute();
$order_result = $stmt->get_result();
$order = $order_result->fetch_assoc();

if (!$order) {
    echo "<script>alert('Order not found.'); window.location.href='orders.php';</script>";
    exit;
}

// Fetch ordered products
$products_query = "SELECT p.pro_name, p.image_url, p.pro_price, oi.quantity, p.pro_id 
                   FROM Order_Item oi 
                   JOIN product_discounts p ON oi.pro_id = p.pro_id
                   WHERE oi.order_id = ?";
$stmt = $conn->prepare($products_query);
$stmt->bind_param("i", $order_id);
$stmt->execute();
$products_result = $stmt->get_result();

// Fetch shipping details
$shipping_query = "SELECT shipping_method, estimate_delivery_date, shipping_status, shipping_address
                   FROM Shipping WHERE order_id = ?";
$stmt = $conn->prepare($shipping_query);
$stmt->bind_param("i", $order_id);
$stmt->execute();
$shipping_result = $stmt->get_result();
$shipping = $shipping_result->fetch_assoc();

$total_price = 0;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link rel="stylesheet" href="order.css">
</head>
<body>

<div id="navbar-container"><?php include 'load.php'; ?></div>

<div class="order-container">
    <h2>Order Details</h2>
    <div class="order-summary">
        <p><strong>Order ID:</strong> <?php echo $order['order_id']; ?></p>
        <p><strong>Order Date:</strong> <?php echo date("d M Y", strtotime($order['created_at'])); ?></p>
        <p><strong>Status:</strong> <span class="status"><?php echo ucfirst($order['order_status']); ?></span></p>
    </div>

    <div class="order-summary">
        <p><strong>Shipping Method:</strong> <?php echo !empty($shipping['shipping_method']) ? $shipping['shipping_method'] : "Not Assigned"; ?></p>
        <p><strong>Expected Delivery Date:</strong> 
           <?php echo !empty($shipping['estimate_delivery_date']) ? date("d M Y", strtotime($shipping['estimate_delivery_date'])) : "Not Available"; ?>
        </p>
        <p><strong>Shipping Status:</strong> 
           <span class="status"><?php echo !empty($shipping['shipping_status']) ? ucfirst($shipping['shipping_status']) : "Pending"; ?></span>
        </p>
    </div>

    <div class="items-section">
        <h3>Ordered Items</h3>
        <?php while ($row = $products_result->fetch_assoc()): 
            $total_price += $row['pro_price'] * $row['quantity']; ?>
            <div class="item">
                <img src="<?php echo $row['image_url']; ?>" alt="<?php echo $row['pro_name']; ?>">
                <div class="item-details">
                    <h4><?php echo $row['pro_name']; ?></h4>
                    <p>Price: ₹<?php echo number_format($row['pro_price'], 2); ?></p>
                    <p>Quantity: <?php echo $row['quantity']; ?></p>
                </div>
            </div>
        <?php endwhile; ?>
    </div>

    <div class="price-summary">
        <h3>Price Summary</h3>
        <p><strong>Subtotal:</strong> ₹<?php echo number_format($total_price, 2); ?></p>
        <p><strong>Delivery Charge:</strong> <span style="color: green;">Free</span></p>
        <hr>
        <p class="total"><strong>Total:</strong> ₹<?php echo number_format($total_price, 2); ?></p>
    </div>

    <!-- Cancel Order Button -->
    <?php if ($order['order_status'] !== "Canceled") : ?>
        <form method="POST">
            <input type="hidden" name="cancel" value="<?php echo $order['order_id']; ?>">
            <button type="submit" class="cancel-button">Cancel Order</button>
        </form>
    <?php else: ?>
        <p style="color: red;">This order has been canceled.</p>
    <?php endif; ?>

</div>

</body>
</html>
