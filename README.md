# Aquabay - E-commerce Website

## Project Overview
Aquabay is a basic e-commerce website developed as an academic project. It includes features like product listings, a shopping cart, and user authentication. However, it does not include a payment gateway, order tracking, recommendation system, or OTP verification.

## Technologies Used
- **Frontend:** HTML, CSS, JavaScript
- **Backend:** PHP
- **Database:** MySQL

## Installation Guide
### Prerequisites
- A web server (Apache recommended)
- PHP installed on the server
- MySQL database

### Steps to Set Up the Project
1. **Clone the repository**
   ```sh
   git clone https://github.com/Adarsh119005/E-commerce-site.git
   cd aquabay
   ```

2. **Import the Database**
   - Open MySQL and create a database (e.g., `aquabay`)
   - Import the provided database file:
     ```sh
     mysql -u root -p aquabay < aquabay_database.sql
     ```

3. **Update Database Connection**
   - Navigate to `config/connection.php`
   - Update the database credentials:
     ```php
     <?php
     $servername = "localhost";
     $username = "your_db_user";
     $password = "your_db_password";
     $dbname = "aquabay";

     $conn = new mysqli($servername, $username, $password, $dbname);

     if ($conn->connect_error) {
         die("Connection failed: " . $conn->connect_error);
     }
     ?>
     ```

4. **Serve the Project**
   - Place the project files inside the web server directory (`htdocs` for XAMPP, `www` for WAMP, etc.)
   - Start the Apache and MySQL services
   - Access the website in your browser at:
     ```
     http://localhost/aquabay
     ```

## Features
- User authentication (login & registration)
- Product catalog
- Shopping cart
- Order placement (without payment integration)

## Notes
- Ensure that PHP and MySQL are properly configured on your server.
- The project is designed for academic purposes and is not production-ready.

## License
This project is for educational purposes only.

## Author
Adarsh Upadhyay

