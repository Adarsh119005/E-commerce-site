
<?php
include 'connection.php'; // Include the connection file


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}





if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user_name = $_POST["name"];
    $gender = $_POST["gender"];
    $user_email = $_POST["email"];
    $user_pass = password_hash($_POST["passwd"], PASSWORD_DEFAULT); // Secure password hashing
    $user_phonenumber = $_POST["mobile"];
    $created_at = date("Y-m-d H:i:s");
    $updated_at = date("Y-m-d H:i:s");

    // Generate custom user_id


    if (strlen((string)$user_phonenumber) == 10) {

        $sql = "INSERT INTO Users ( user_name, Gender, user_email, user_pass, user_phonenumber, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sssssss",$user_name, $gender, $user_email, $user_pass, $user_phonenumber, $created_at, $updated_at);
        
        if ($stmt->execute()) {
            header("Location: Login.php");
            exit();
        } else {
            echo "Error: " . $stmt->error;
        }
        
        $stmt->close();
    }

    else {
        echo "<h1> You Enter Wrong Mobile No.</h1>";
        exit();
    }
    


    
}

$conn->close();


?>



<!--End php code here--->


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign up</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <link rel="stylesheet" href="sign.css">
</head>
<body>
    <div class="sign">
        <h1>Sign Up</h1><br>

        <form method="POST" action="">
            <lable>Name:</lable><br>
            <input class="info" type="text" name="name" placeholder="👤Enter your Name"><br><br>

            <lable>Gender</lable><br>
            <input type="radio" name="gender" value="Male">Male&nbsp;&nbsp;
            <input type="radio" name="gender" value="Female">Female<br><br>

            <lable>Email ID:</lable><br>
            <input class="info" type="email" name="email" placeholder="Email"><br><br>

            <lable>Mobile No.</lable><br>
            <input class="info" type="number"  placeholder="Mobile no." name="mobile"><br><br>

            <lable>Password</lable><br>
            <input class="info" type="password" placeholder="Password" name="passwd"><br><br>

            

            <button id="sub" type="submit">Submit</button><br><br>
            </form>



            <hr>
            <div class="btn-container">
                <button class="ch1"><i class="fa-brands fa-google"></i></button>
                <button class="ch2"><i class="fa-brands fa-facebook"></i></button>
                <button class="ch3"><i class="fa-brands fa-twitter"></i></button>
            </div>



        
    </div>
</body>
</html>