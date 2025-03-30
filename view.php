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


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if(isset($_POST['cart'])) {
        if (isset($_SESSION["mobile"]) || isset($_SESSION["password"])) {
            $user_id = $_SESSION['user_id'];
            $cart = $_POST['cart'];
            $quantity = $_POST['quantity'];
            $sql = "INSERT INTO Cart ( user_id, pro_id, quantity) VALUES ( ?, ?, ?)";
            $stmt=$conn->prepare($sql);
            $stmt->bind_param('sss',$user_id, $cart, $quantity);
            if ($stmt->execute()) {
                header("Location: cart.php");
                exit();
            } else {
                echo "Error: " . $stmt->error;
            }

        }

        else{
            header("Location: cart.php");
        }

    }
}

if(isset($_GET['pro_id'])) {
    
    $sql = "SELECT * FROM product_discounts WHERE pro_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('s',$_GET['pro_id']);
    $stmt->execute();
    $result = $stmt->get_result();
    while($row = $result->fetch_assoc()){
        $new_price = $row['pro_price'] - $row['discount'];

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Page</title>
    <link rel="stylesheet" href="view.css">
</head>
<body>
<div id="navbar"><?php include 'load.php' ?></div><br>
<div class="wether">
    <div class="left-column">
        <div class="main-image">
            <img id="displayedImage" src="<?php echo $row['image_url'] ?>" alt="Product Image">
        </div>
        <div class="thumbnail-container">
            <img class="thumbnail" src="<?php echo $row['image_url'] ?>" onclick="changeImage(this)">
            <img class="thumbnail" src="https://jamesandco.in/wp-content/uploads/2025/01/VIVO-MOBILE-V40-GANGES-BLUE-12GB512GB-4.png" onclick="changeImage(this)">
            <img class="thumbnail" src="https://vasanthandco.in/UploadedFiles/productimages/20240829120636-179190102913%20(5).png" onclick="changeImage(this)">
            <img class="thumbnail" src="https://www.top10mobileshop.com/images/top10mobiles.com/thumbnail/product/2024/08/516082550202408141000.jpg" onclick="changeImage(this)">
        </div>
    </div>
    <div class="right-column">
        <h2><?php echo $row['pro_name']; ?></h2>
        <h6><?php echo $row['description']; ?></h6>
        <p class="rating">⭐ 4.4 | 1,087 Ratings & 71 Reviews</p>
        <h3 class="price">₹<?php echo $new_price ?> &nbsp; &nbsp;<span class="old-price">₹<?php echo $row['pro_price'] ?></span>&nbsp; <span class="discount"><?php echo (int)$row['dis_percentage']; ?>% off</span></h3>
        <p class="emi">₹2,567/month (36 months EMI)</p>
        <form method="get" action="buy.php">
            <div class="quantity-container">
                <button type="button" id="crease" onclick="decreaseQuantity()">-</button>
                <input type="number" id="quantity" name="quantity" value="1" min="1">
                <button type="button" id="crease" onclick="increaseQuantity()">+</button>
            </div>
            <br>
            <button type="submit" name="buy" value="<?php echo $row['pro_id']; ?>" class="buy-btn">Buy Now</button>
        </form>
        <form method="post">
           <input type="hidden" name="quantity" value="1">
            &nbsp;&nbsp; 
            <button type="submit" name="cart" value="<?php echo $row['pro_id']?>" class="cart-btn"><i class="fa-solid fa-cart-plus"></i>&nbsp;Add Cart</button>
        </form>
    </div>
</div><br><br>

<script>
   function increaseQuantity() {
        let quantity = document.getElementById("quantity");
        if (quantity.value < <?php echo ((int)$row['quantity'] - 1); ?>) {
            quantity.value = parseInt(quantity.value) + 1;
        }
    }
    
    function decreaseQuantity() {
        let quantity = document.getElementById("quantity");
        if (quantity.value > 1) {
            quantity.value = parseInt(quantity.value) - 1;
        }
    }
</script>



<h2 style="text-decoration:underline;">Related Product</h2>

<div class="product-container">
<?php 
  
   $sql1 = "SELECT * FROM Products WHERE pro_type = ? AND pro_id != ?";
   $stmt1 = $conn->prepare($sql1);
   $stmt1->bind_param('ss',$row['pro_type'], $_GET['pro_id']);
   $stmt1->execute();
   $results=$stmt1->get_result();
   while ($rows = $results->fetch_assoc()) {
   
   

?>

    <div class="product-card">
        <form method="GET" action="view.php">
            <input type="hidden" name="pro_id" value="<?php echo $rows['pro_id'] ?>">

        <button id="bat" type="submit">
            <img src="<?php echo $rows['image_url'] ?>" alt="..."><br><hr>
            <div class="Product-title"><?php  echo $rows['pro_name']; ?></div>
            <div class="star-rating">&#9733;&#9733;&#9733;&#9734;&#9734;</div>
            <div class="product-price">₹<?php echo $rows['pro_price'] ?>/- Only</div>
        </button>
   </form>
    </div>
    <?php } ?>
</div>

<?php 
   echo  $row['cat_id'],$row['pro_type'];
   ?>


<h2 style="text-decoration:underline;">Related Product</h2>

<div class="product-container">
<?php 
  
   $sql1 = "SELECT * FROM Products WHERE cat_id = ? AND pro_type != ?";
   $stmt1 = $conn->prepare($sql1);
   $stmt1->bind_param('ss',$row['cat_id'],$row['pro_type']);
   $stmt1->execute();
   $results=$stmt1->get_result();
   while ($rows = $results->fetch_assoc()) {
   
   
   
?>

    <div class="product-card">
        <form method="GET" action="view.php">
            <input type="hidden" name="pro_id" value="<?php echo $rows['pro_id'] ?>">

        <button id="bat" type="submit">
            <img src="<?php echo $rows['image_url'] ?>" alt="..."><br><hr>
            <div class="Product-title"><?php  echo $rows['pro_name']; ?></div>
            <div class="star-rating">&#9733;&#9733;&#9733;&#9734;&#9734;</div>
            <div class="product-price">₹<?php echo $rows['pro_price'] ?>/- Only</div>
        </button>
   </form>
    </div>
    <?php } ?>
</div>


<?php
    }
}
else {
    echo "<h1>error</h1>";
}

?>
    <script>
        function changeImage(element) {
            document.getElementById("displayedImage").src = element.src;
        }
    </script>
</body>
</html>
