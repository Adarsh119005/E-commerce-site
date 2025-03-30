<?php
session_start(); // Start session on every page using session data
include 'connection.php';

// Check if the user is logged in
if (!isset($_SESSION["user_id"])) {
    echo "<script>alert('Please log in to access your cart.'); window.location.href='Login.php';</script>";
    exit;
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (!empty($_POST['user_id']) && !empty($_POST['addr']) && !empty($_POST['pro_id'])) {
        $user_id = $_POST['user_id'];
        $add_id = $_POST['addr'];
        $pro_ids = $_POST['pro_id'];
        $discount = $_POST['discount'];
        $total_amount = $_POST['total_amount']; // Corrected: Removed []
        $price_amount = $_POST['tota']; 
        $payment_method = $_POST['gpay'];
        $shipping_address = $_POST['full_address'];

        // Debugging: Print values
       /* echo "User ID: " . htmlspecialchars($user_id) . "<br>";
        echo "Address ID: " . htmlspecialchars($add_id) . "<br>";
        echo "Discount: " . htmlspecialchars($discount) . "<br>";
        echo "Total: " . htmlspecialchars($total_amount) . "<br>";
        echo "Payment_method: " . htmlspecialchars($payment_method) . "<br>";
        echo "Shipping_address: " . htmlspecialchars($shipping_address) . "<br>";*/
        // Loop through product IDs (since it's an array)
// Default when an order is placed
foreach ($pro_ids as $index => $pro_id) {
        $order_query = "INSERT INTO Orders (user_id, add_id, order_status, total_amount, payment_status, created_at, updated_at) 
                VALUES (?, ?, ?, ?, 'Pending', NOW(), NOW())";
        $stmt = mysqli_prepare($conn, $order_query);

        // Fix: Corrected the data type string to "iisds" (integer, integer, string, double, string)
        $order_status = 'Confirmed'; // Defined separately
        mysqli_stmt_bind_param($stmt, "iisd", $user_id, $add_id, $order_status, $total_amount,);
        mysqli_stmt_execute($stmt);
        $order_id = mysqli_insert_id($conn); // Get the last inserted order ID

if ($order_id) {
    echo "Order Created Successfully. Order ID: " . $order_id . "<br>"; 

    // Insert each product into Order_Item table
        $order_item_query = "INSERT INTO Order_Item (order_id, pro_id, quantity, price, discount) 
                            VALUES (?, ?, ?, ?, ?)";
        $stmt_item = mysqli_prepare($conn, $order_item_query);

        // Fix: Ensure variables are correctly bound for Order_Item
        foreach ($cart_items as $item) {
            mysqli_stmt_bind_param($stmt_item, "iiidd", $order_id, $item['pro_id'], $item['quantity'], $item['price'], $item['discount']);
            mysqli_stmt_execute($stmt_item);
        }

    // Insert into Payment table
    
        $payment_query = "INSERT INTO Payment (order_id, payment_method, payment_status, transaction_id, payment_date, amount) 
                        VALUES (?, ?, ?, ?, NOW(), ?)";
        $stmt_pay = mysqli_prepare($conn, $payment_query);
        
        $payment_status = 'Pending';
        $transaction_id = ''; // No transaction ID yet
        mysqli_stmt_bind_param($stmt_pay, "issss", $order_id, $payment_method, $payment_status, $transaction_id, $total_amount);
        mysqli_stmt_execute($stmt_pay);

        // Calculate expected delivery date
        $processing_time = 2; // Processing time in days
        $shipping_time = 3;   // Shipping time in days
        $total_days = $processing_time + $shipping_time;
        $expected_delivery_date = date('Y-m-d', strtotime("+$total_days days")); // Format: YYYY-MM-DD

        // Insert into Shipping table
        $shipping_query = "INSERT INTO Shipping (order_id, shipping_address, shipping_method, shiping_cost, estimate_delivery_date, shipping_status) 
                        VALUES (?, ?, ?, ?, ?, ?)";
        $stmt_ship = mysqli_prepare($conn, $shipping_query);

        $shipping_method = 'express'; 
        $shipping_cost = 0.00;
        $shipping_status = 'pending';

        // Fix: Correct parameter types and values
        mysqli_stmt_bind_param($stmt_ship, "issdss", $order_id, $shipping_address, $shipping_method, $shipping_cost, $expected_delivery_date, $shipping_status);
        mysqli_stmt_execute($stmt_ship);

        
        
            $quantity = $_POST['quantity'][$index]; // Assuming quantity is an array
            $price_discount = $_POST['discounted_price'][$index]; // Assuming discounted price is passed

          /*  echo "Quantity: " . htmlspecialchars($quantity) . "<br>";
            echo "Price_discount: " . htmlspecialchars($price_discount) . "<br>";
            echo "Product Id: " . htmlspecialchars($pro_id) . "<br>";*/
            mysqli_stmt_bind_param($stmt_item, "iiidd", $order_id, $pro_id, $quantity, $price_amount,$discount);
            mysqli_stmt_execute($stmt_item);
            $update_stock_query = "UPDATE Products SET stock_quantity = stock_quantity - ? WHERE pro_id = ?";
            $stmt_stock = mysqli_prepare($conn, $update_stock_query);
            mysqli_stmt_bind_param($stmt_stock, "ii", $quantity, $pro_id);
            mysqli_stmt_execute($stmt_stock);

            echo "Added Product ID: " . htmlspecialchars($pro_id) . " (Qty: $quantity, Price: $price_discount)<br>";
            }
        }

       echo "<script>alert('Order placed successfully!'); window.location.href='order_list.php?order_id=$order_id';</script>";
    }else {
        echo "<script>alert('Failed to place order.'); window.location.href='cart.php';</script>";
        }
    } else {
        echo "Error: Missing required form data.";
    }

if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['buy']) && isset($_GET['quantity'])) {
    $quantity = $_GET['quantity'];
    $pro_id = $_GET['buy'];
    $user_id = $_SESSION['user_id'];
// Fetch user's address (Modify this query as per your database structure)
    $address_query = "SELECT * FROM Address WHERE user_id = '$user_id'";
    $address_result = mysqli_query($conn, $address_query);

    $cart_query = "SELECT * FROM product_discounts WHERE pro_id = $pro_id";
    $cart_result = mysqli_query($conn, $cart_query);
    $total_items = mysqli_num_rows($cart_result);
    $total_price = 0;
  
} elseif ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['cart'])) {
    $user_id = $_SESSION['user_id'];
    // Fetch user's address (Modify this query as per your database structure)
    $address_query = "SELECT * FROM Address WHERE user_id = '$user_id'";
    $address_result = mysqli_query($conn, $address_query);


    // Fetch cart items
    $cart_query = "SELECT c.quantity, p.pro_id, p.pro_name, p.pro_price, p.dis_percentage, p.image_url FROM Cart c LEFT JOIN product_discounts p ON c.pro_id = p.pro_id WHERE c.user_id = '$user_id'";
    $cart_result = mysqli_query($conn, $cart_query);
    $total_items = mysqli_num_rows($cart_result);
    $total_price = 0;
    // Data from cart (redirected purchase)
    echo "<h2>This data comes from cart".$_POST['cart']."</h2>";
}


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm</title>
    <link rel="stylesheet" href="buy.css">
</head>
<body>
<div id="navbar-container"><?php include 'load.php'; ?></div><br>

<form method="post">

    <div class="cart">

   
        <div class="cart-container">
      
            <div class="login">
                <h3 style="color:red;">Login &nbsp;&nbsp;&nbsp;&nbsp;  <b class="big-text">&#x1F5F8;</b></h3><hr>
                <div class="address-card">
                    <div class="address-details">
                        <input type="hidden" name="user_id" value="<?php echo $_SESSION['user_id']; ?>">
                        <div class="logname"> <?php echo $_SESSION['name'] ?> - <span class="phone"><?php echo $_SESSION['mobile'] ?></span></div>
                    </div>
                </div>
            </div>


            <div class="address">
                <h3 style="color:blue;">Choose Address;</b></h3><hr>
                <?php while ($address = mysqli_fetch_assoc($address_result)): 
                ?>
                <div class="address-card">
                    <div class="address-details">
                    <?php if ($address): ?>
                    
                        <div class="logname">    <input type="radio" name="addr" value ="<?php echo $address['add_id'] ?>" required> <?php echo $address['delivery_name'] ?> - <span class="phone"><?php echo $address['delivery_mobnumber'] ?></span></div>
                        <input type="hidden" name="full_address" 
                        value="<?php echo $address['delivery_address'] . ", " . $address['landmark'] . ", "
                        . $address['delivery_city'] . ", " . $address['state'] . " - " . $address['delivery_zipcode']; ?>">
                            <p><?php echo $address['delivery_address'] . ", " . $address['landmark'].",". $address['delivery_city']; ?><br>
                            <?php echo $address['state'] . ", " . $address['delivery_zipcode']; ?> </p>
                            
                        <?php else: ?>
                            <p>No address found. <a href="add_address.php">Add Address</a></p>
                        <?php endif; ?>
                    </div>
                </div><br><br>
                <?php endwhile; ?>
            </div>
            
            <?php if ($total_items > 0): ?>
                
                <div class="address">
                    <h3 style="color:rgb(216, 0, 0);">Your Item</h3><hr>
                <?php 
                $total_price = 0;
                while ($row = mysqli_fetch_assoc($cart_result)): 
                    $discounted_price = $row['pro_price'] - ($row['pro_price'] * $row['dis_percentage'] / 100);
                    $item_quantity = isset($quantity) ? $quantity : $row['quantity']; 
    
                    $total_price += $discounted_price * $item_quantity;
                ?>
                    <div class="cart-item">
                    <input type="hidden" name="pro_id[]" value="<?php echo $row['pro_id']; ?>">
                        <img src="<?php echo $row['image_url']; ?>" alt="<?php echo $row['pro_name']; ?>">
                        <div class="cart-details">
                            <h3><?php echo $row['pro_name']; ?></h3>
                            <p class="price">₹<?php echo number_format($discounted_price, 2); ?> <span class="old-price">₹<?php echo number_format($row['pro_price'], 2); ?></span> <?php echo $row['dis_percentage']; ?>% Off</p>
                        </div>
                        <div class="cart-actions">

                        <button type="button" class="crease" id="crease_<?php echo $row['pro_id']; ?>" 
                        onclick="decreaseQuantity(<?php echo $row['pro_id']; ?>)">-</button>

                            <input type="number" class="quantity" id="quantity_<?php echo $row['pro_id']; ?>" 
                            name="quantity[]" value="<?php echo $item_quantity; ?>" min="1">

                        <button type="button" class="crease" id="crease_<?php echo $row['pro_id']; ?>" 
                                onclick="increaseQuantity(<?php echo $row['pro_id']; ?>)">+</button>

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
                <?php endwhile; ?>
                </div>


                <div class="login">
                    <h3 style="color:red;">Payment &nbsp;&nbsp;&nbsp;&nbsp; </h3><hr>
                    <div class="address-card">
                        <div class="address-details">
                            <div class="busy"><input type="radio" name="gpay" value="upi" required disabled>&nbsp;&nbsp; <img id="small" src="https://img.icons8.com/color/512/google-pay.png">&nbsp;&nbsp;&nbsp;&nbsp;Pay by Upi&nbsp;&nbsp;&nbsp;
                            </span></div>
                        </div>
                        <div class="address-details">
                            <div class="busy"><input type="radio" name="gpay" value="paytm" required disabled>&nbsp;&nbsp;
                            &nbsp;<img id="small" src="https://wpblogassets.paytm.com/paytmblog/uploads/2022/09/Paytm-800x500-1.png">&nbsp;Paytm &nbsp;&nbsp;&nbsp;&nbsp;
                           </span></div>
                        </div>
                        <div class="address-details">
                            <div class="busy"><input type="radio" name="gpay" value="Net banking" required disabled>&nbsp;&nbsp; <img id="small" src="https://img.icons8.com/color/512/google-pay.png">&nbsp;Net Banking&nbsp;&nbsp;&nbsp;
                            </span></div>
                        </div>
                        <div class="address-details">
                            <div class="busy"><input type="radio" name="gpay" required value="COD">&nbsp;&nbsp; <i class="fa-solid fa-money-bill-1-wave"></i>&nbsp;Cash on Delivery &nbsp;&nbsp;&nbsp;
                            </span></div>
                        </div>
                    </div><br><br>
                </div>





            <?php else: ?>
                <div class="not">
                    <div class="show">
                        <img src="cart_empty.png" alt="Empty Cart">
                        <h1>Your cart is empty</h1>
                        <p>Looks like you haven't added anything yet.</p>
                    </div>
                </div>
            <?php endif; ?>
        </div>
        
        <?php if ($total_items > 0): ?>
            <div class="price-summary">
                <h2>PRICE DETAILS</h2>
                <p>Price (<?php echo $total_items; ?> items): ₹<input type="number" name="tota" value="<?php echo round($total_price, 2); ?>"step="0.01" readonly 
                style="border: none; background: transparent; color: black; width: 80px;"></p>
                <p>Discount: <span style="color: green;">- ₹<input type="number" value="<?php echo round($total_price * 0.05, 2); ?>" 
           name="discount" step="0.01" readonly 
           style="border: none; background: transparent; color: green; width: 60px;"></span></p>
                <p>Delivery Charges: <span style="color: green;">Free</span></p>
                <hr>
                <p class="total-amount">Total Amount: ₹<input type="number" value="<?php echo round($total_price * 0.95, 2); ?>" 
           name="total_amount" step="0.01" readonly 
           style="border: none; background: transparent; color: black; width: 80px;"></p>
              <div class="place-order"> <button>PLACE ORDER</button></div>
            </div>
        
        <?php endif; ?>
     
    </div>

        </form>    

    <script>
        function updateQuantity(productId, action) {
            // Add AJAX request to update quantity in the database
            alert(`Updating quantity for product ${productId}: ${action}`);
        }
    </script>
</body>
</html>
