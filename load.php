<?php
session_start();

// Check if user is logged in
if (isset($_SESSION["mobile"]) || isset($_SESSION["password"])) {
    $name_parts = explode(" ", trim($_SESSION['name']));
    $first_name = $name_parts[0]; // Redirect to login if not logged in
    
}
 else{
    $first_name = 'User';
 }

?>






<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Navbar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="load.css">
</head>
<body>
    <!-- Topmost Menu -->
    <div class="topmost-menu">
        <div class="truck"><i class="fa-solid fa-truck-fast"></i>FREE Express Shipping On Orders $570+</div>
        <div>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-facebook"></i></a>
        </div>
    </div>
    
    <!-- Main Navbar -->
    <nav class="main-navbar">
        <a class="navbar-brand text-dark" href="#">
            <h4>AquaBey</h4>
        </a>
        <form class="search-bar" role="search" action="search.php" method="GET">
            <input class="form-control" type="search" name="search" placeholder="Search for Products..." aria-label="Search">
            <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
        </form>
        <div class="account-info">
            <a href="/profile.php"><i class="fa-regular fa-user"></i>&nbsp;&nbsp;&nbsp;<b>Hello,</b><h4><?php echo $first_name; ?></h4></a>
            <a href="/wishlist.php"><i class="fa-regular fa-heart"></i></a>
            <a href="/cart.php"><i class="fa-solid fa-bag-shopping"></i></a>
        </div>
    </nav>
    
    <!-- Secondary Navbar -->
    <nav class="navbar navbar-expand-lg secondary-navbar">
        <div class="container">
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">All Categories</a>
                        <ul class="dropdown-menu">
                            <form metho="get" action="search.php">
                            <li><button type="submit" name="cat_id" value="C001" class="dropdown-item" >Electronics</button></li>
                            <li><button type="submit" name="cat_id" value="C003" class="dropdown-item" >Books</button></li>
                            <li><button type="submit" name="cat_id" value="C004" class="dropdown-item" >Home Appliances</button></li>
                            </form>
                        </ul>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="/index.php">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="/cupon.php">Coupons</a></li>
                    <li class="nav-item"><a class="nav-link" href="order_list.php">Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="https://adarsh119005.github.io/webpage/" target="_blink">Portfolio</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.php">Logout</a></li>
                </ul>
            </div>
            <div class="helpline"><i class="fa-solid fa-phone-volume"></i>&nbsp;&nbsp;Hotline<br>&nbsp;&nbsp;+(406) 205 345 45</div>
        </div>
        
    </nav>
    
    
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
