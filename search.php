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

//Wishlist fill pro

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["fill"])) {
        if ($_POST["fill"] == "empty") {
            if (isset($_SESSION['user_id']) && isset($_POST['prod'])) {
                $user_id = $_SESSION['user_id'];  // Assuming 'name' is used as user_id
                $pro_id = $_POST['prod'];
            
                // Prepare the SQL statement
                $sql = "INSERT INTO Wishlist (user_id, pro_id) VALUES (?, ?)";
                $stmt = $conn->prepare($sql);
                
                if ($stmt) {
                    $stmt->bind_param("si", $user_id, $pro_id); // "s" for string, "i" for integer
                    if ($stmt->execute()) {
                        echo "Product added to wishlist successfully!";
                    } else {
                        echo "Error: " . $stmt->error;
                    }
                    
                } else {
                    echo "Error in SQL statement.";
                }
            } else {
                echo "Invalid request.";
            }
        }
        elseif ($_POST["fill"] == "filled") {
            if (isset($_SESSION['user_id']) && isset($_POST['prod'])) {
                $user_id = $_SESSION['user_id'];  // Assuming 'name' is used as user_id
                $pro_id = $_POST['prod'];
            
                // Prepare the SQL statement
                $sql = "DELETE FROM Wishlist WHERE user_id = ? AND pro_id = ?";
                $stmt = $conn->prepare($sql);

                if ($stmt) {
                    $stmt->bind_param("si", $user_id, $pro_id); // "s" for string, "i" for integer
                    if ($stmt->execute()) {
                        echo "Product removed from wishlist successfully!";
                    } else {
                        echo "Error: " . $stmt->error;
                    }
                } else {
                    echo "Error in SQL statement.";
                }
            }
        }
    }
}





if(isset($_GET['search'])) {
    $search = strtolower(trim($_GET['search'])); // Convert to lowercase and trim spaces

    // Normalize the search term for variations of "t-shirt"
    $search = preg_replace('/\s?(\b(tshirt|t\s?shirt)\b)\s?/', ' t-shirt ', $search);  // Remove spaces
    if ($normalized_search === "tshirt" || $normalized_search === "t shirt") {
        $search = "t-shirt";  // Normalize to 't-shirt'
    }

    $search = preg_replace('/\bmobile\b/', 'smartphone', $search);

    // If the search term is exactly "mobile", change it to "smartphone"
    if ($search === "mobile") {
        $search = "smartphone";
    }


    $price_condition = "";  // To store price filter (if any)
    $keywords = [];         // To store extracted product keywords

    // Regular expression to detect price filters (e.g., "under 1500", "above 30000")
    if (preg_match('/(under|below)\s*(\d+)/', $search, $matches)) {
        $max_price = (int)$matches[2]; 
        $price_condition = "AND pro_price <= $max_price"; 
        // Remove price-related terms from the search string for keyword matching
        $search = preg_replace('/(under|below)\s*\d+/', '', $search);
    }
    if (preg_match('/(above|over)\s*(\d+)/', $search, $matches)) {
        $min_price = (int)$matches[2]; 
        $price_condition = "AND pro_price >= $min_price"; 
        // Remove price-related terms from the search string for keyword matching
        $search = preg_replace('/(above|over)\s*\d+/', '', $search);
    }

    // Clean up search text for keyword matching
    $search = trim($search);

    // Extract main keywords (e.g., "laptop", "mobile", "t-shirt")
    $common_keywords = ['laptop', 'mobile', 't-shirt', 'headphones', 'shoes', 'tablet', 'watch'];
    foreach ($common_keywords as $word) {
        if (strpos($search, $word) !== false) {
            $keywords[] = $word;
        }
    }

    // Construct the keyword condition for SQL query
    if (empty($keywords)) {
        $keyword_condition = "LOWER(pro_name) LIKE LOWER('%$search%') 
                              OR LOWER(pro_type) LIKE LOWER('%$search%') 
                              OR LOWER(description) LIKE LOWER('%$search%')";
    } else {
        $keyword_condition = "LOWER(pro_type) LIKE '%" . implode("%' OR LOWER(pro_name) LIKE '%", $keywords) . "%'";
    }

    // Final SQL query with price condition
    $sql = "SELECT * FROM Products WHERE ($keyword_condition) $price_condition";
    
    // DEBUGGING: Print the query for testing

    $result = $conn->query($sql);

    // If no results found, show related items (remove price condition)
    if ($result->num_rows == 0) {
        $sql = "SELECT * FROM Products WHERE $keyword_condition"; // Remove price condition
        $result = $conn->query($sql);
    }
} elseif(isset($_GET['cat_id'])) {
    $cat_id = $_GET['cat_id'];
    $sql = "SELECT * FROM Products WHERE cat_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('s',$cat_id);
    $stmt->execute();
    $result = $stmt->get_result();
}


$sql1 = "SELECT * FROM Wishlist WHERE user_id = ?";
$stmt1 = $conn->prepare($sql1);
$stmt1->bind_param("s", $_SESSION['user_id']);
$stmt1->execute();
$results = $stmt1->get_result();
$wishlist_items = [];
while ($wishlist_row = $results->fetch_assoc()){
    $wishlist_items[] = $wishlist_row['pro_id'];
}



?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
   
    <title>Search=<?php echo $search ?></title>
    <link rel="stylesheet" href="search.css">
</head>
<body>
     <!-- Navbar will be inserted here -->
     <div id="navbar-container"><?php include 'load.php'; ?></div><br>

<div class="whole">
        <div class="user">
            <ul>
                <li><img src="https://t4.ftcdn.net/jpg/02/54/21/61/360_F_254216141_ZIWWpUlP2I5sAVpUDvhCAXVs5eBEKHoj.jpg" alt="..">&nbsp;&nbsp;Hello, <b>ADARSH</b></li>
            </ul><br>
            <ul>
                <li><i class="fa-solid fa-user"></i>&nbsp;&nbsp; <b>Account Setting</b></li>
                <li class="side1"><a href="">Profile Information</a></li>
                <li class="side1"><a href="">Manage Address</a></li>
                <hr>
                <li><i class="fa-solid fa-folder"></i>&nbsp;&nbsp;&nbsp;<b>My Stuff</b></li>
                <li class="side1"><a href="/cupon.php">My Coupons</a></li>
                <li class="side1"><a href="">My Reviews & Rating</a></li>
                <li class="side1"><a href="">All Notification</a></li>
                <li class="side1"><a href="/wishlist.html">My Wishlist</a></li>
            </ul>
     </div>

     <div class="wishlist-container">
        <!-- Wishlist Header -->
        <div class="wishlist-header"><h3>Search : <?php echo $search ?> &nbsp;(<?php echo $result->num_rows; ?>)</h3></div>

        <!-- Wishlist Item -->
         <?php 
         if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
        
                //wishlist data fetch
                    
        
                $new_price = $row['pro_price'] - $row['discount']; ?>

                <form method="GET" action="view.php">
                    <input type="hidden" name="pro_id" value="<?php echo $row['pro_id']; ?>">
        
           
                <div class="wishlist-item">
                <button type="submit">
                    <div class="wishlist-content">
                        <img src="<?php echo $row['image_url']; ?>" alt="T-Shirt">
                        <div class="product-info">
                            <div class="product-name"><?php echo $row['pro_name']; ?></div>
                            <div class="product-name"><?php echo $row['description']; ?></div><br>
                            <div class="product-price">
                                ₹<?php echo $new_price; ?> <span class="old-price">₹<?php echo $row['pro_price']; ?></span> <span class="discount"><?php echo $row['discount']; ?> off</span>
                            </div>
                        </div>
                    </div></button></form>
                    <form method="POST">
                        <input type="hidden" name="prod" value="<?php echo $row['pro_id']; ?>">
                        <?php if (in_array($row['pro_id'], $wishlist_items)) { ?>
                            <input type="hidden" name="fill" value="filled">
                            <button type="submit" name="remove"><i class="fa-solid fa-heart remove-item"></i></button> <!-- Filled heart for wishlist items -->
                        <?php } else { ?>
                            <input type="hidden" name="fill" value="empty">
                            <button type="submit" name="add"><i class="fa-regular fa-heart remove-item"></i></button> <!-- Empty heart for non-wishlist items -->
                        <?php } ?>
                    </form>
                </div><br><hr>
           <?php
    } 
        } 
        else{
            echo "<h1>No Resule found</h1>";
        }?>
    </div>

</div>
</body>
</html>