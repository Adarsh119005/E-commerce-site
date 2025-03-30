<?php
session_start(); // Start the session at the top

include 'connection.php';

// Store the previous page before login
if (!isset($_SESSION['previous_page']) && isset($_SERVER['HTTP_REFERER'])) {
    $_SESSION['previous_page'] = $_SERVER['HTTP_REFERER'];
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $mobile = $_POST["mobile"];
    $password = $_POST["passwd"];
    
    // Check if mobile and password are not empty
    if (empty($mobile) || empty($password)) {
        echo "<p style='color:red;'>Please enter both mobile number and password.</p>";
        exit();
    }

    // Query to fetch the user by mobile number
    $sql = "SELECT user_id, user_name, Gender, user_email, user_pass, user_phonenumber FROM Users WHERE user_phonenumber = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $mobile);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        // Bind the result variables
        $stmt->bind_result($id, $name, $gender, $emailid, $hashed_password, $mobileno);
        $stmt->fetch();

        // Verify password
        if (password_verify($password, $hashed_password)) {
            // Set session variables
            $_SESSION["user_id"] = $id;
            $_SESSION["mobile"] = $mobileno;
            $_SESSION["name"] = $name;
            $_SESSION["gender"] = $gender;
            $_SESSION["email"] = $emailid;
            $_SESSION["password"] = $password;

            // Redirect user to the previous page or index.php
            $redirect_page = $_SESSION['previous_page'] ?? 'index.php';
            unset($_SESSION['previous_page']); // Clear session variable

            header("Location: " . $redirect_page);
            exit();
        } else {
            echo "<p style='color:red;'>Incorrect password!</p>";
        }
    } else {
        echo "<p style='color:red;'>No user found with this mobile number.</p>";
    }

    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log In</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="sign.css">
</head>
<body>
    <div class="sign">
        <h1>Log In</h1><br>

        <form method="post" action="">
            <label>Mobile No.</label><br>
            <input class="info" type="number" placeholder="Mobile no." name="mobile" required><br><br>

            <label>Password</label><br>
            <input class="info" type="password" placeholder="Password" name="passwd" required><br><br>
            <div class="forgot-password">
                <a class="forg" href="#">Forgot Password?</a>
            </div>

            <button id="sub" type="submit">Log In</button><br><br>

            <hr>
            <div class="btn-container">
                <button class="ch1"><i class="fa-brands fa-google"></i></button>
                <button class="ch2"><i class="fa-brands fa-facebook"></i></button>
                <button class="ch3"><i class="fa-brands fa-twitter"></i></button>
            </div>
            
            <div class="btn-container">
                
                <a id="log" href="/sign_up.php">Sign Up</a>
            </div>
        </form>
    </div>
</body>
</html>
