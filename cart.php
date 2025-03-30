<?php
session_start();
include 'connection.php';

// Check if the user is logged in
if (!isset($_SESSION["user_id"])) {
    header("Location: Login.php");
    exit();
}

// Handle remove product request
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['remove'])) {
    $pro_id = $_POST['remove'];
    $sql = "DELETE FROM Cart WHERE pro_id = ? AND user_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('is', $pro_id, $_SESSION['user_id']);
    
    if ($stmt->execute()) {
        header('Location: cart.php'); // Refresh cart page after deletion
        exit();
    } else {
        echo "Error: " . $stmt->error;
    }
}

// Fetch cart items
$sql = "SELECT c.pro_id, p.pro_price, p.discount, p.dis_percentage, c.quantity, 
        p.description, p.pro_name, p.cat_id, p.image_url 
        FROM Cart c 
        LEFT JOIN product_discounts p ON c.pro_id = p.pro_id 
        WHERE c.user_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param('s', $_SESSION['user_id']);
$stmt->execute();
$result = $stmt->get_result();

$total_price = 0;
$total_discount = 0;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart</title>
    <link rel="stylesheet" href="cart.css">
</head>
<body>

<div id="navbar-container"><?php include 'load.php'; ?></div><br>

<div class="cart">
    <div class="cart-container">
        <?php 
        if ($result->num_rows > 0) {// Place Order Form Start
            while ($row = $result->fetch_assoc()) {
                $new_price = $row['pro_price'] - $row['discount'];
                $total_price += $new_price * $row['quantity'];
                $total_discount += $row['discount'] * $row['quantity'];
        ?>
        
        <!-- Cart Item -->
        <div class="cart-item">
            <img src="<?php echo $row['image_url']; ?>" alt="Product Image">
            <div class="cart-details">
                <h3><?php echo $row['pro_name']; ?></h3>
                <p class="price">₹<?php echo $new_price; ?> <span class="old-price">₹<?php echo $row['pro_price']; ?></span> <?php echo $row['dis_percentage']; ?>% Off</p>
            </div>
            <input type="hidden" name="cart_items[]" value="<?php echo $row['pro_id']; ?>">
            <div class="cart-actions">
                <!-- Quantity Increase/Decrease -->
                <button type="button" class="crease" onclick="decreaseQuantity(<?php echo $row['pro_id']; ?>)">-</button>
                <input type="number" class="quantity" id="quantity_<?php echo $row['pro_id']; ?>" 
                       name="quantity[]" value="<?php echo $row['quantity']; ?>" min="1">
                <button type="button" class="crease" onclick="increaseQuantity(<?php echo $row['pro_id']; ?>)">+</button>

                <!-- Remove Product Form (Separate from Place Order) -->
                <form method="post" action="cart.php">
                    <input type="hidden" name="remove" value="<?php echo $row['pro_id']; ?>">
                    <button type="submit">Remove</button>
                </form>
                
            </div>
        </div>

        <?php 
            }
          // Close Place Order Form
        } else {
            echo "<h2>Your cart is empty!</h2>";
        }
        ?>
    </div>

    <div class="price-summary">
        <h2>PRICE DETAILS</h2>
        <p>Price (<?php echo $result->num_rows; ?> items): ₹<?php echo $total_price; ?></p>
        <p>Discount: <span style="color: green;">- ₹<?php echo $total_discount; ?></span></p>
        <p>Delivery Charges: <span style="color: green;">Free</span></p>
        <p>Protect Promise Fee: ₹87</p>
        <hr>
        <p class="total-amount">Total Amount: ₹<?php echo $total_price - $total_discount + 87; ?></p>
        
        <!-- Place Order Button (Inside Form) -->
        <form method="get" action="buy.php">
            <?php
            $stmt->execute(); // Re-fetch data for form inputs
            $result = $stmt->get_result();
            while ($row = $result->fetch_assoc()) {
                echo '<input type="hidden" name="cart[]" value="'.$row['pro_id'].'">';
            }
            ?>
            <div class="place-order">
                <button type="submit">PLACE ORDER</button>
            </div>
        </form>

    </div>
</div>

<script>
    function increaseQuantity(pro_id) {
        let quantity = document.getElementById("quantity_" + pro_id);
        quantity.value = parseInt(quantity.value) + 1;
    }

    function decreaseQuantity(pro_id) {
        let quantity = document.getElementById("quantity_" + pro_id);
        if (quantity.value > 1) {
            quantity.value = parseInt(quantity.value) - 1;
        }
    }
</script>

</body>
</html>
