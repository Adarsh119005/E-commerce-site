<?php
session_start(); // Start session on every page using session data

// Check if the user is logged in
if (isset($_SESSION["mobile"]) || isset($_SESSION["password"])) {
    $name_parts = explode(" ", trim($_SESSION['name']));
    $first_name = $name_parts[0];

} else {
    $first_name='User';
}


?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Include Navbar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- Custom Styles -->
    <link rel="stylesheet" href="index.css">


    <script>
        document.addEventListener('DOMContentLoaded', function() {
          const textElements = document.querySelectorAll('.truncated-text');
          
          textElements.forEach(function(element) {
            let text = element.innerHTML.trim();
            let words = text.split(/\s+/);  // Split the text into words
      
            // Check if the text has more than 20 words (10 at the start and 10 at the end)
            if (words.length > 5) {
              let startWords = words.slice(0, 2).join(' ');  // First 10 words
              let endWords = words.slice(-2).join(' ');  // Last 10 words
              element.innerHTML = startWords + ' ... ' + endWords;
            }
          });
        });
      </script>

</head>
<body>

    <!-- Navbar will be inserted here -->
    <div id="navbar-container"><?php include 'load.php' ?></div>
    <!-- Bootstrap JS -->
    

<div id="carouselExampleDark" class="carousel carousel-dark slide">
   
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    
    <!--https://shop.timexindia.com/cdn/shop/files/Tech-1920x822px.jpg?v=1738676100---->
    <div class="carousel-inner">
    <a href="">
      <div class="carousel-item active" data-bs-interval="10000">
        <img src="https://shop.timexindia.com/cdn/shop/files/Tech-1920x822px.jpg" class="d-block w-100" alt="...">
        <div class="carousel-caption d-none d-md-block">
          <h5>Smart Watches</h5>
          <p>Smart watch to fit your health</p>
        </div>
      </div>
    </a>
      <a href="">
          <div class="carousel-item" data-bs-interval="2000">
            <img src="https://www.wesellcomputer.com/assets/images/1NpGdell-7450.jpg" class="d-block w-100" alt="...">
            <div class="carousel-caption d-none d-md-block">
              <h5>Second slide label</h5>
              <p>Some representative placeholder content for the second slide.</p>
            </div>
          </div>
      </a>
      <a href="">
          <div class="carousel-item">
            <img src="https://i0.wp.com/www.smartprix.com/bytes/wp-content/uploads/2022/09/realme-9-SE.webp?resize=1024%2C455&ssl=1" class="d-block w-100" alt="...">
            <div class="carousel-caption d-none d-md-block">
              <h5>Third slide label</h5>
              <p>Some representative placeholder content for the third slide.</p>
            </div>
          </div>
        </a>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>


<br/>



<!--circle category add -->


<form method="get" action="search.php">
<div class="image-gallery">

    <div class="image-container">
        <button type="submit" name="search" value="headphone" class="sebtn"><img src="https://png.pngtree.com/background/20231030/original/pngtree-vibrant-headphones-set-against-a-colorful-3d-background-picture-image_5790932.jpg" alt="iPhone 15 Pro"></button>
        <p>Headphone</p>
    </div>
      
    <div class="image-container">
    <button type="submit" name="search" value="smartphone" class="sebtn"><img src="https://thecondia.com/wp-content/uploads/2024/01/01_S24Ultra-Group-KV_PC.jpg" alt="Samsung S24 Ultra"></button>
        <p>Smartphone</p>
    </div>
    <div class="image-container">
    <button type="submit" name="cat_id" value="C002" class="sebtn"><img src="https://static.vecteezy.com/system/resources/previews/022/392/293/large_2x/pretty-woman-denim-clothing-fashion-modern-style-color-background-unaltered-photo.jpg" alt="Infinix Zero Ultra"></button>
        <p>Fassion</p>
    </div>
    <div class="image-container">
    <button type="submit" name="search" value="smartwatch" class="sebtn"><img src="https://cdn.mos.cms.futurecdn.net/qDiWC728ZbsZJuP34meocG.jpg" alt="Itel S25 Ultra"></button>
        <p>Smartwatch</p>
    </div>
    <div class="image-container">
    <button type="submit" name="search" value="laptop" class="sebtn"><img src="https://png.pngtree.com/background/20230526/original/pngtree-laptop-with-multi-toned-colors-in-a-colorful-background-picture-image_2742113.jpg" alt="New Phone"></button>
        <p>Laptop</p>
    </div><br/>
  
</div>
</form>

<!--for user guidence div container-->

<div class="write">

    <a href="error.php">
    <div class="squre">
       <b><i class="fa-solid fa-truck"></i>&nbsp; &nbsp;Free Delivery</b><br><p>orders from all item</p>
    </div>
    </a>

    <a href="error.php">
        <div class="squre">
            <b><i class="fa-solid fa-dollar-sign"></i>&nbsp; &nbsp;Return & Refund</b><br><p>Money back guarantee</p>
        </div>
    </a>

    <a href="error.php">
        <div class="squre">
            <b><i class="fa-solid fa-tag"></i>&nbsp; &nbsp;Member Discount<br></b><p>On every order over rs50k</p>
        </div>
    </a>

    <a href="error.php">
        <div class="squre">
           <b><i class="fa-solid fa-headphones"></i>&nbsp; &nbsp;Support 24/7</b><br><p>Contact us 24 hour a day</p>
        </div>
    </a>
</div><br>




<?php

include 'connection.php';

$sql = "SELECT pro_name, pro_id, pro_price, image_url FROM Products WHERE pro_type = 'Laptop' LIMIT 5";
$result = $conn->query($sql);

// Step 4: Fetch Data and Use a for Loop



?>
<!---LAPTOP SHOPPING THERE-->

<h2> Laptop Shopping</h2>


<div class="product-container">
    <?php  
    if ($result->num_rows > 0) {
        $rows = $result->fetch_all(MYSQLI_ASSOC); // Fetch all rows as an associative array
        for ($i = 0; $i < count($rows); $i++) {
    ?>
  <form method="get" action="view.php">
    <div class="product-card">
        <input type="hidden" name="pro_id" value="<?php echo $rows[$i]['pro_id']; ?>">
        <button id="bat" type="submit">
            <img src="<?php echo $rows[$i]['image_url'] ?>" alt="Lenovo LOQ"><br><hr>
            <div class="product-title"><?php echo $rows[$i]['pro_name']; ?></div>
            <div class="star-rating">★★★★☆ (125)</div>
            <div class="product-price">₹<?php echo $rows[$i]['pro_price']; ?>/- Only</div>
        </button>
    </div>
  </form>
    <?php 
}
} else {
    echo "No Laptops Found.";
}

// Step 5: Close Connection
$conn->close();
?>
</div>
<br>





<?php 
include 'connection.php';

$sql = "(SELECT * FROM Products WHERE pro_type = 'Jeans' LIMIT 1)
        UNION
        (SELECT * FROM Products WHERE pro_type = 'T-Shirt' LIMIT 1)
        UNION
        (SELECT * FROM Products WHERE pro_type = 'Hoodie' LIMIT 1)
        UNION
        (SELECT * FROM Products WHERE pro_type = 'Jacket' LIMIT 1)
        UNION
        (SELECT * FROM Products WHERE pro_type = 'Formal Suit' LIMIT 1)";

$result = $conn->query($sql);

// Step 4: Fetch and Display in a `for` Loop
if ($result->num_rows > 0) {
    $rows = $result->fetch_all(MYSQLI_ASSOC);
 ?>

<!--Fassion about cloths-->


<h2>Fassion</h2>

<div class="product-container">
<?php 
   for ($i = 0; $i < count($rows); $i++) {
?>

    <form action="view.php" method="get">
      <div class="product-card">
          <input type="hidden" name="pro_id" value="<?php echo $rows[$i]['pro_id']; ?>">
          <button id="bat" type="submit">
              <img src="<?php echo $rows[$i]['image_url'] ?>" alt="..."><br><hr>
              <div class="Product-title"><?php  echo $rows[$i]['pro_name']; ?></div>
              <div class="star-rating">&#9733;&#9733;&#9733;&#9734;&#9734;</div>
              <div class="product-price">₹<?php echo $rows[$i]['pro_price'] ?>/- Only</div>
          </button>
      </div>
    </form>

    <?php 
      //  echo "Product: " . $rows[$i]['pro_name'] . " - Type: " . $rows[$i]['pro_type'] . " - Price: ₹" . $rows[$i]['pro_price'] . "<br>";
}
} else {
echo "No products found.";
}

// Step 5: Close Connection
$conn->close();

?>
</div>


<br>

<h2>Furniture</h2>


<?php 

include 'connection.php';

$sql = "SELECT * FROM Products WHERE pro_type = 'Furniture' LIMIT 5";

$result = $conn->query($sql);

// Step 4: Fetch and Display in a `for` Loop
if ($result->num_rows > 0) {
    $rows = $result->fetch_all(MYSQLI_ASSOC);
 ?>



<div class="product-container">

<?php 
   for ($i = 0; $i < count($rows); $i++) {
?>


    <form action="view.php" method="get">
      <div class="product-card">
          <input type="hidden" name="pro_id" value="<?php echo $rows[$i]['pro_id']; ?>">
          <button id="bat" type="submit">
              <img src="<?php echo $rows[$i]['image_url']; ?>" alt="..."><br><hr>
              <div class="Product-title"><?php echo $rows[$i]['pro_name']; ?></div>
              <div class="star-rating">&#9733;&#9733;&#9733;&#9734;&#9734;</div>
              <div class="product-price">₹<?php echo $rows[$i]['pro_price'] ?>/- Only</div>
           </button>
      </div>
    </form>


    <?php 
      //  echo "Product: " . $rows[$i]['pro_name'] . " - Type: " . $rows[$i]['pro_type'] . " - Price: ₹" . $rows[$i]['pro_price'] . "<br>";
}
} else {
echo "No products found.";
}

// Step 5: Close Connection
$conn->close();

?>

</div>


<!---Footer-->

<footer>
    <div class="copyright">
        <p>Copyright &copy; ID Adarsh </p>
    </div>
</footer>



</body>
</html>
