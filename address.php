<?php


session_start(); // Start session on every page using session data

// Check if the user is logged in
if (isset($_SESSION["mobile"]) && isset($_SESSION["password"])) {
    $name_parts = explode(" ", trim($_SESSION['name']));
    $first_name = $name_parts[0];
} else {
    $first_name='User';
}

include 'connection.php';



if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (isset($_POST["form_type"])) {
    if ($_POST["form_type"] == "address") {
      $name = $_POST['name'];
      $mobile = $_POST['mobile'];
      $pincode = $_POST['pincode'];
      $locality = $_POST['locality'];
      $landmark = $_POST['landmark'];
      $area = $_POST['area'];
      $city = $_POST['city'];
      $state = $_POST['state'];


      if (isset($_SESSION['user_id'])) {
        $user_id = $_SESSION['user_id'];
      } else {
          echo "User ID not set!";
          exit(); // Prevent further execution
      }
    


      

    

      if (strlen((string)$mobile) == 10 and strlen((string)$pincode) == 6) {


        $sql = "INSERT INTO Address (user_id, delivery_name, delivery_mobnumber, delivery_address, landmark, delivery_city, delivery_zipcode, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ssssssss", $user_id, $name, $mobile, $area, $landmark, $city, $pincode, $state );
        
        if ($stmt->execute()) {
          header('Location: address.php');       
          exit();
        } else {
            echo "Error: " . $stmt->error;
        }
        
        $stmt->close();
      }

      else{
        echo "You Entered Wrong MObile no. or Pincode" ;
        exit();
      }
    } 
    
    elseif ($_POST["form_type"] == "delete") {
      if (isset($_POST['del'])) {
        require 'connection.php';

        $remove = $_POST['del'];

        $sql = "DELETE FROM Address WHERE add_id= ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('s',$remove);
        if ($stmt->execute()) {
          header('Location: address.php');
        } else {
            echo "Error deleting address: " . $stmt->error;
        }
    
        $stmt->close();
        $conn->close();
      
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
    <link rel="stylesheet" href="address.css">
</head>
<body>
     <!-- Navbar will be inserted here -->
     <div id="navbar-container"><?php include 'load.php' ?></div><br>
     <!-- Bootstrap JS -->
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>



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


     <div class="address-container">
    <h2>Manage Addresses</h2><hr><br>

    <div class="add-address">
        <button type="button" class="butt" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">+ Add new Address</button>

    </div>
    <?php 
       $user_id = $_SESSION['user_id'];
       $sql = "SELECT * FROM Address WHERE user_id = ?";
       $stmt = $conn->prepare($sql);
       $stmt->bind_param("s", $user_id);
       $stmt->execute();
       $result = $stmt->get_result();
       
       // Check if rows are found
       if ($result->num_rows > 0) {

        while ($row = $result->fetch_assoc()) {
?>
    <div class="address-card">
        <div class="address-details">
            <span class="home-badge">HOME</span>
            <div class="name"><?php echo $row['delivery_name']; ?>&nbsp;- &nbsp; <span class="phone"><?php echo $row['delivery_mobnumber']; ?></span></div>
            <div class="address"><?php echo $row['delivery_address'].'&nbsp;&nbsp;  '. $row['landmark'].'&nbsp;&nbsp;  '. $row['delivery_city'].' &nbsp;&nbsp; '. $row['state'].' &nbsp;&nbsp; ' ?><b>211008</b></div>
        </div>
        <form method="post">
          <input type='hidden' name='form_type' value="delete">
        <div class="options"><button id="remove" name="del" value="<?php echo $row['add_id'] ?>" type="submit"><i class="fas fa-trash remove-item"></i></button></div>
        </form>
    </div>
<?php
                   
       }
       } else {
       echo "No addresses found.";
       }
       
       // Close connection
       $stmt->close();
       $conn->close();
    ?>
    </div>


    <!--modal start-->
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Add New Address</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form method="post" action="">
        <input type='hidden' name='form_type' value="address">
          <div class="row">
              <div class="col-md-6">
                  <div class="input-container">
                      <input type="text" id="name" name="name" placeholder=" " required>
                      <label for="name">Name</label>
                  </div>
              </div>
              <div class="col-md-6">
                  <div class="input-container">
                      <input type="number" id="mobile" name="mobile" placeholder=" " required>
                      <label for="mobile">10 Digit Mobile No.</label>
                  </div>
              </div>
              <div class="col-md-6">
                  <div class="input-container">
                      <input type="number" id="email" name="pincode" placeholder=" " required>
                      <label for="email">PINCODE</label>
                  </div>
              </div>
              <div class="col-md-6">
                  <div class="input-container">
                      <input type="text" id="password" name="locality" placeholder=" " required>
                      <label for="password">Locality</label>
                  </div>
              </div>


              <div class="input-container">
                      <textarea class="form-control" name="area" id="message-text"></textarea>
                      <label for="message-text" class="col-form-label">Area (Area and Street)</label>
              </div>

              <div class="col-md-6">
                  <div class="input-container">
                      <input type="text" id="name" name="city" placeholder=" " required>
                      <label for="name">City/District/Town</label>
                  </div>
              </div>

              <div class="col-md-6">
                  <div class="input-container">
                      <input type="text" id="name" name="state" placeholder=" " required>
                      <label for="name">State</label>
                  </div>
              </div>

              <div class="col-md-6">
                  <div class="input-container">
                      <input type="text" id="name" name="landmark" placeholder=" ">
                      <label for="name">Landmark(optional)</label>
                  </div>
              </div>

              
          </div>
          <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Save</button>
      </div>
      </form>
        
      </div>
     
    </div>
  </div>
  
</div>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!--end modal-->



</div>

</div>
</body>
</html>