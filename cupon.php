<?php
session_start(); // Start session on every page using session data
include 'connection.php';

// Check if the user is logged in
if (!isset($_SESSION["user_id"])) {
    echo "<script>alert('Please log in to access your cupons.'); window.location.href='Login.php';</script>";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coupons</title>
<style>
    body {
    font-family: Arial, sans-serif;
    background-color: #f1f3f6;
    margin: 0;
    padding: 0;
}

.coupon-container {
    width: 50%;
    margin: 50px auto;
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    color: #333;
}

.coupon-card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #fff;
    padding: 15px;
    margin: 10px 0;
    border-radius: 8px;
    border: 2px dashed #2874f0;
    cursor: pointer;
    transition: 0.3s;
}

.coupon-card:hover {
    background: #f5faff;
}

.coupon-left h3 {
    margin: 0;
    color: #2874f0;
}

.coupon-left p {
    margin: 5px 0 0;
    font-size: 14px;
    color: #666;
}

.coupon-right button {
    background: #ff9f00;
    border: none;
    padding: 8px 15px;
    border-radius: 5px;
    cursor: pointer;
    color: white;
    font-weight: bold;
}

.cart-summary {
    margin-top: 20px;
    padding: 15px;
    border-top: 1px solid #ddd;
    text-align: center;
}

.cart-summary p {
    font-size: 18px;
    margin: 5px 0;
}

.cart-summary strong {
    color: #333;
}

</style>
</head>
<body>

<div id="navbar-container"><?php include 'load.php'; ?></div><br>


<div class="coupon-container">
    <h2>Available Coupons</h2>
    
    <div class="coupon-card" onclick="applyCoupon('FLAT50', 50)">
        <div class="coupon-left">
            <h3>FLAT ₹50 OFF</h3>
            <p>Valid on orders above ₹499</p>
        </div>
        <div class="coupon-right">
            <button>Apply</button>
        </div>
    </div>

    <div class="coupon-card" onclick="applyCoupon('DISCOUNT10', 10)">
        <div class="coupon-left">
            <h3>10% OFF</h3>
            <p>Valid on all orders above ₹999</p>
        </div>
        <div class="coupon-right">
            <button>Apply</button>
        </div>
    </div>

    <div class="coupon-card" onclick="applyCoupon('FREESHIP', 0)">
        <div class="coupon-left">
            <h3>FREE SHIPPING</h3>
            <p>On all prepaid orders</p>
        </div>
        <div class="coupon-right">
            <button>Apply</button>
        </div>
    </div>

    <div class="cart-summary">
        <h2>Cart Summary</h2>
        <p><strong>Subtotal:</strong> ₹<span id="subtotal">1200</span></p>
        <p><strong>Discount:</strong> ₹<span id="discount">0</span></p>
        <p><strong>Total:</strong> ₹<span id="total">1200</span></p>
    </div>
</div>

<script>
    let subtotal = 1200;

    function applyCoupon(code, discount) {
        let discountAmount = 0;

        if (code === "FLAT50" && subtotal >= 499) {
            discountAmount = 50;
        } else if (code === "DISCOUNT10" && subtotal >= 999) {
            discountAmount = subtotal * 0.1;
        } else if (code === "FREESHIP") {
            alert("Free shipping applied!");
            return;
        } else {
            alert("Coupon not applicable!");
            return;
        }

        document.getElementById("discount").innerText = discountAmount.toFixed(2);
        document.getElementById("total").innerText = (subtotal - discountAmount).toFixed(2);
        alert(`Coupon "${code}" applied successfully!`);
    }
</script>

</body>
</html>
