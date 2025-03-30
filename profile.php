<?php
session_start();

include 'connection.php';

// Check if user is logged in
if (!isset($_SESSION["mobile"]) || !isset($_SESSION["password"])) {
    header("Location: Login.php"); // Redirect to login if not logged in
    exit();
}

?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
   
   
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Wishlist</title>
    <link rel="stylesheet" href="profile.css">
 
</head>
<body>
     <!-- Navbar will be inserted here -->
     <div id="navbar-container"><?php include 'load.php' ?></div>


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

     <div class="wishlist-container">
       <div class="personal">
        <!--Personal Information-->
        <b>Personal Information</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="personal-edit-btn" class="baty">Edit</button><br><br>
        <input type="text" id="personal-input" class="p1" placeholder="<?php echo $_SESSION['name'] ?>" disabled>&nbsp; &nbsp;

        <p>Your Gender&nbsp;&nbsp;&nbsp;
        <button id="personal-edit-btn" class="baty">Edit</button></p>
        <input type="radio" id="personal-input" value="Male" <?php if ($_SESSION['gender'] == 'Male') echo 'checked'; ?> disabled>&nbsp; &nbsp;Male&nbsp; &nbsp;&nbsp; &nbsp;
        <input type="radio" id="personal-lastname" value="Female" <?php if ($_SESSION['gender'] == 'Female') echo 'checked'; ?> disabled>&nbsp; &nbsp;Female <br><br>
         <!--Email-->
        <b>Email Address</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button id="email-edit-btn" class="baty">Edit</button><br><br>
        <input type="text" id="email-input" class="p1" placeholder="<?php echo $_SESSION['email'] ?>" disabled>&nbsp; &nbsp;<br><br>


        <!--Mobile No.-->
        <b>Mobile Number</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button id="mobile-edit-btn" class="baty">Edit</button><br><br>
        <input type="number" id="mobile-input" class="p1" placeholder="<?php echo $_SESSION['mobile'] ?>" disabled>&nbsp; &nbsp;

       </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
    // Function to enable editing
    function enableEditing(section) {
        let inputField = document.querySelector(`#${section}-input`);
        let button = document.querySelector(`#${section}-edit-btn`);

        // Enable input field
        inputField.removeAttribute("disabled");
        inputField.focus();

        // Change button text to "Save"
        button.innerText = "Save";
        button.classList.add("save-btn");

        // Change button function to save the input
        button.onclick = function () {
            saveData(section);
        };
    }

    // Function to save data (simulation)
    function saveData(section) {
        let inputField = document.querySelector(`#${section}-input`);
        let button = document.querySelector(`#${section}-edit-btn`);

        // Disable input field again
        inputField.setAttribute("disabled", "true");

        // Change button text back to "Edit"
        button.innerText = "Edit";
        button.classList.remove("save-btn");

        // Reset button function to enable editing again
        button.onclick = function () {
            enableEditing(section);
        };

        // Simulating saving process
        alert(`${section.replace("-", " ")} updated to: ${inputField.value}`);
    }

    // Attach event listeners
    document.querySelector("#personal-edit-btn").addEventListener("click", function () {
        enableEditing("personal");
    });

    document.querySelector("#email-edit-btn").addEventListener("click", function () {
        enableEditing("email");
    });

    document.querySelector("#mobile-edit-btn").addEventListener("click", function () {
        enableEditing("mobile");
    });
});

    </script>
</div>
</body>
</html>