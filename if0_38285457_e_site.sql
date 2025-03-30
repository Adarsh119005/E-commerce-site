-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: sql301.infinityfree.com
-- Generation Time: Mar 30, 2025 at 07:58 AM
-- Server version: 10.6.19-MariaDB
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `if0_38285457_e_site`
--

-- --------------------------------------------------------

--
-- Table structure for table `Address`
--

CREATE TABLE `Address` (
  `add_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `delivery_name` varchar(100) DEFAULT NULL,
  `delivery_mobnumber` bigint(20) DEFAULT NULL,
  `delivery_address` varchar(255) NOT NULL,
  `landmark` varchar(255) NOT NULL,
  `delivery_city` varchar(50) DEFAULT NULL,
  `delivery_zipcode` int(11) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Address`
--

INSERT INTO `Address` (`add_id`, `user_id`, `delivery_name`, `delivery_mobnumber`, `delivery_address`, `landmark`, `delivery_city`, `delivery_zipcode`, `state`) VALUES
(2, 1, 'anubhav', 1234567890, 'LALGANJ MEJAROAD ', '', 'MIRZAPUR', 987654, 'Uttar Pradesh'),
(3, 1, 'Adarsh Upadhyay', 1234567890, 'Naini Mirzapur Road', '', 'PRAYAGRAJ', 212207, 'Uttar Pradesh'),
(4, 2, 'Neeraj', 7310452103, 'Ssss', 'Gg', 'Gg', 211016, 'Gg');

-- --------------------------------------------------------

--
-- Table structure for table `Audit_Logs`
--

CREATE TABLE `Audit_Logs` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Cart`
--

CREATE TABLE `Cart` (
  `user_id` bigint(20) DEFAULT NULL,
  `pro_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Cart`
--

INSERT INTO `Cart` (`user_id`, `pro_id`, `quantity`) VALUES
(1, 13, 1),
(1, 34, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Categories`
--

CREATE TABLE `Categories` (
  `cat_id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Categories`
--

INSERT INTO `Categories` (`cat_id`, `name`, `created_at`, `updated_at`) VALUES
('C001', 'Electronics', '2025-02-16 14:25:00', '2025-02-16 14:25:00'),
('C002', 'Clothing', '2025-02-16 14:27:00', '2025-02-16 14:27:00'),
('C003', 'Books', '2025-02-16 14:30:00', '2025-02-16 14:30:00'),
('C004', 'Home Appliances', '2025-02-16 14:31:00', '2025-02-16 14:31:00'),
('C005', 'Sports & Fitness', '2025-02-16 14:33:00', '2025-02-16 14:33:00'),
('C006', 'Beauty & Personal Care', '2025-02-16 14:35:00', '2025-12-02 14:35:00'),
('C007', 'Toys & Games', '2025-02-16 14:37:00', '2025-02-16 14:37:00'),
('C008', 'Furniture', '2025-02-16 23:15:06', '2025-02-16 23:15:06');

-- --------------------------------------------------------

--
-- Table structure for table `Coupons`
--

CREATE TABLE `Coupons` (
  `coupon_id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount` decimal(5,2) NOT NULL,
  `discount_type` enum('percentage','fixed') NOT NULL,
  `min_purchase` decimal(10,2) DEFAULT NULL,
  `max_discount` decimal(10,2) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `used_count` int(11) DEFAULT 0,
  `status` enum('active','expired','disabled') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Coupons`
--

INSERT INTO `Coupons` (`coupon_id`, `code`, `discount`, `discount_type`, `min_purchase`, `max_discount`, `start_date`, `end_date`, `usage_limit`, `used_count`, `status`, `created_at`, `updated_at`) VALUES
(1, 'NEWUSER10', '10.00', 'percentage', '500.00', '100.00', '2024-01-01 00:00:00', '2024-12-31 23:59:59', 100, 0, 'active', '2025-02-23 20:28:50', '2025-02-23 20:28:50'),
(2, 'FESTIVE50', '50.00', 'fixed', '1000.00', NULL, '2024-11-01 00:00:00', '2024-12-31 23:59:59', 200, 0, 'active', '2025-02-23 20:28:50', '2025-02-23 20:28:50'),
(3, 'SUMMER15', '15.00', 'percentage', NULL, '200.00', '2024-06-01 00:00:00', '2024-08-31 23:59:59', 150, 0, 'active', '2025-02-23 20:28:50', '2025-02-23 20:28:50'),
(4, 'WELCOME100', '100.00', 'fixed', '1500.00', NULL, '2024-01-01 00:00:00', '2024-06-30 23:59:59', 50, 0, 'active', '2025-02-23 20:28:50', '2025-02-23 20:28:50'),
(5, 'FLASH20', '20.00', 'percentage', '200.00', '50.00', '2024-11-15 00:00:00', '2024-11-30 23:59:59', 500, 0, 'active', '2025-02-23 20:28:50', '2025-02-23 20:28:50');

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `order_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `add_id` int(11) DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`order_id`, `user_id`, `add_id`, `order_status`, `total_amount`, `payment_status`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Canceled', '1708.96', 'Returned', '2025-02-24 10:54:34', '2025-02-24 10:54:34'),
(2, 2, 4, 'Confirmed', '117805.74', 'Pending', '2025-02-24 12:14:07', '2025-02-24 12:14:07'),
(3, 1, 3, 'Confirmed', '31350.53', 'Pending', '2025-02-24 12:15:01', '2025-02-24 12:15:01');

-- --------------------------------------------------------

--
-- Table structure for table `Order_Item`
--

CREATE TABLE `Order_Item` (
  `order_id` bigint(20) DEFAULT NULL,
  `pro_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` decimal(5,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Order_Item`
--

INSERT INTO `Order_Item` (`order_id`, `pro_id`, `quantity`, `price`, `discount`) VALUES
(1, 34, 1, '1798.90', '89.95'),
(2, 1, 1, '124006.05', '999.99'),
(3, 14, 1, '33000.56', '999.99');

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE `Payment` (
  `order_id` bigint(20) DEFAULT NULL,
  `payment_method` enum('credit card','debit card','paypal','bank transfer') NOT NULL,
  `payment_status` enum('pending','completed','failed') DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Payment`
--

INSERT INTO `Payment` (`order_id`, `payment_method`, `payment_status`, `transaction_id`, `payment_date`, `amount`) VALUES
(1, '', 'failed', '', '2025-02-24 10:50:57', '1708.96'),
(2, '', 'pending', '', '2025-02-24 12:14:07', '117805.74'),
(3, '', 'pending', '', '2025-02-24 12:15:01', '31350.53');

-- --------------------------------------------------------

--
-- Table structure for table `Products`
--

CREATE TABLE `Products` (
  `pro_id` bigint(20) NOT NULL,
  `pro_name` varchar(100) NOT NULL,
  `pro_type` varchar(100) DEFAULT NULL,
  `description` text NOT NULL,
  `pro_price` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `cat_id` varchar(100) NOT NULL,
  `image_url` varchar(300) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dis_percentage` decimal(10,2) GENERATED ALWAYS AS (`discount` / `pro_price` * 100) STORED
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Products`
--

INSERT INTO `Products` (`pro_id`, `pro_name`, `pro_type`, `description`, `pro_price`, `discount`, `stock_quantity`, `cat_id`, `image_url`, `created_at`, `updated_at`) VALUES
(1, ' Samsung Galaxy S24 Ultra - ', 'Smartphones', 'Powerful Snapdragon 8 Gen 3, 200MP camera, 120Hz AMOLED display, S Pen, massive battery, and AI-powered features for ultimate performance.', '129999.00', '5999.00', 154, 'C001', 'https://m.media-amazon.com/images/I/81vxWpPpgNL.jpg', '2025-02-16 18:42:00', '2025-02-24 12:14:07'),
(2, 'Apple iPhone 15 Pro Max', 'Smartphones', 'Titanium build, A17 Pro chip, 5x periscope zoom, 120Hz ProMotion display, USB-C, iOS 17, and superior battery life.', '159900.00', '4999.00', 60, 'C001', 'https://www.designinfo.in/wp-content/uploads/2024/09/Apple-iPhone-16-Pro-128GB-Natural-Titanium-6-364x364-optimized.webp', '2025-02-16 18:43:00', '2025-02-19 22:47:04'),
(3, 'Google Pixel 8 Pro', 'Smartphones', 'Tensor G3 chip, AI-enhanced camera, 50MP primary sensor, clean Android experience, seven years of updates, and excellent low-light photography.', '106999.00', '3599.00', 14, 'C001', 'https://fdn2.gsmarena.com/vv/pics/google/google-pixel-8-pro-1.jpg', '2025-02-16 18:50:00', '2025-02-19 22:47:04'),
(4, 'OnePlus 12 Pro', 'Smartphones', 'Snapdragon 8 Gen 3, 6.82-inch 2K AMOLED, 120Hz refresh, 50MP triple camera, 100W fast charging, and OxygenOS optimizations.', '74999.00', '2400.00', 20, 'C001', 'https://zmamobile.com/wp-content/uploads/2024/01/OnePlus-12-Price-455x455.jpg', '2025-02-16 19:00:00', '2025-02-16 19:00:00'),
(5, 'Xiaomi 14 Ultra', 'Smartphone', 'Leica-powered quad-camera setup with Snapdragon 8 Gen 3.', '85999.00', '6000.00', 30, 'C001', 'https://i.gadgets360cdn.com/products/large/xiaomi-14-ultra-db-612x800-1708665175.jpg', '2025-02-16 19:04:06', '2025-02-19 22:47:04'),
(6, 'Realme GT 5 Pro', 'Smartphone', '240W fast charging with Snapdragon 8 Gen 3.', '68999.00', '4000.00', 40, 'C001', 'https://www.xtechzplus.com/cdn/shop/files/EDA006126501A_c288e9a0-9dc2-405a-8b3e-a9e8acc9c0db.jpg?v=1705649036', '2025-02-16 19:04:06', '2025-02-19 22:47:04'),
(7, 'Vivo X100 Pro', 'Smartphone', 'Zeiss optics and 50MP periscope zoom lens.', '95999.00', '2200.00', 25, 'C001', 'https://kirtisales.in/wp-content/uploads/2024/04/VIVO-X100-PRO-16-512.jpg', '2025-02-16 19:04:06', '2025-02-16 19:04:06'),
(8, 'Asus ROG Phone 8', 'Smartphone', 'Gaming beast with 165Hz AMOLED display and AirTriggers.', '104999.00', '3500.00', 18, 'C001', 'https://images-cdn.ubuy.co.in/663ac656d39472545361ef1e-asus-rog-phone-8-pro-5g-dual-physical.jpg', '2025-02-16 19:04:06', '2025-02-16 19:04:06'),
(9, 'Apple MacBook Air M2', 'Laptop', 'Sleek 13-inch Retina display, Apple M2 chip, 18-hour battery life, fanless design, ultra-lightweight, and perfect for students and professionals on the go.', '109999.00', '5000.00', 27, 'C001', 'https://www.hoxtonmacs.co.uk/cdn/shop/files/apple-macbook-air-13-inch-macbook-air-13-inch-m2-midnight-2022-fair-41944397218108_720x.jpg?v=1688460815', '2025-02-16 19:20:05', '2025-02-23 19:52:09'),
(10, 'Dell XPS 15', 'Laptop', 'Powerful 4K OLED display, Intel Core i9, RTX 4070, premium aluminum design, ultra-slim, ideal for creative professionals and gamers seeking top-tier performance.', '189999.00', '7000.00', 20, 'C001', 'https://laptopmedia.com/wp-content/uploads/2022/04/1-20-scaled.jpg', '2025-02-16 19:20:05', '2025-02-16 19:20:05'),
(11, 'HP Spectre x360', 'Laptop', 'Convertible 2-in-1 design, 4K OLED touchscreen, 11th Gen Intel Core i7, ultra-portable, perfect for students, professionals, and content creators.', '139999.00', '6000.00', 25, 'C001', 'https://ssl-product-images.www8-hp.com/digmedialib/prodimg/lowres/c08358680.png', '2025-02-16 19:20:05', '2025-02-16 19:20:05'),
(12, 'Asus ROG Zephyrus G14', 'Laptop', 'AMD Ryzen 9, RTX 4060, ultra-thin gaming laptop with 165Hz QHD display, powerful cooling system, and long battery life for pro gamers.', '159999.00', '8000.00', 15, 'C001', 'https://laptopmedia.com/wp-content/uploads/2022/01/1-46.jpg', '2025-02-16 19:20:05', '2025-02-16 19:20:05'),
(13, 'Lenovo Legion 5 Pro', 'Laptop', '16-inch 165Hz display, RTX 4070, Ryzen 7 processor, RGB keyboard, and high-performance cooling for an immersive gaming and multitasking experience.', '145999.00', '5000.00', 18, 'C001', 'https://m.media-amazon.com/images/I/81gN0vHbWGL.jpg', '2025-02-16 19:20:05', '2025-02-16 19:20:05'),
(14, 'Sony WH-1000XM5', 'Headphone', 'Industry-leading noise cancellation, 30-hour battery, ultra-comfortable design, and crystal-clear sound quality for immersive music and calls anywhere.', '34999.00', '2000.00', 48, 'C001', 'https://m.media-amazon.com/images/I/71o8Q5XJS5L._SL1500_.jpg', '2025-02-16 19:20:05', '2025-02-24 12:15:01'),
(15, 'Bose QuietComfort Ultra', 'Headphone', 'Adaptive noise cancellation, superior sound quality, 24-hour battery life, ergonomic design, and seamless Bluetooth connectivity for premium listening experience.', '39999.00', '2500.00', 35, 'C001', 'https://m.media-amazon.com/images/I/61jliAUA4dL.jpg', '2025-02-16 19:20:05', '2025-02-23 21:16:37'),
(16, 'Apple AirPods Max', 'Headphone', 'Spatial audio, active noise cancellation, premium build, powerful bass, seamless Apple ecosystem integration, and ultra-long battery life for audiophiles.', '59999.00', '3000.00', 40, 'C001', 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airpods-max-select-spacegray-202011?wid=940&hei=1112&fmt=png-alpha&.v=1604022365000', '2025-02-16 19:20:05', '2025-02-16 19:20:05'),
(17, 'Sennheiser Momentum 4', 'Headphone', 'Crystal-clear sound, 60-hour battery life, premium comfort, high-fidelity audio, and adaptive noise cancellation for an unparalleled music experience.', '34999.00', '1500.00', 20, 'C001', 'https://cdni.autocarindia.com/Utils/ImageResizerV2.ashx?n=https://cdni.autocarindia.com/Stuff/Uploads/ReviewImages/638157873351725242_Main.jpg&w=883&h=662&q=70&c=1', '2025-02-16 19:20:05', '2025-02-23 21:18:36'),
(18, 'JBL Tour One M2', 'Headphone', 'Adaptive noise canceling, Hi-Res audio support, deep bass, 50-hour battery life, and smart touch controls for effortless wireless listening.', '24999.00', '1200.00', 30, 'C001', 'https://media.croma.com/image/upload/v1682593710/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/270406_18_xmkxzn.png', '2025-02-16 19:20:05', '2025-02-23 21:18:36'),
(19, 'MSI Stealth 16', 'Laptop', '16-inch 4K OLED display, Intel Core i9, RTX 4080, ultra-thin gaming laptop with RGB keyboard and high-performance cooling system.', '219999.00', '10000.00', 12, 'C001', 'https://images-cdn.ubuy.co.in/65e4894878277c6d20514b31-msi-stealth-ai-studio-16-16-10-qhd.jpg', '2025-02-16 19:29:59', '2025-02-23 21:15:14'),
(20, 'Acer Predator Helios 16', 'Laptop', '165Hz QHD display, Intel i7, RTX 4060, advanced cooling, immersive RGB lighting, and high-end gaming performance.', '169999.00', '8000.00', 20, 'C001', 'https://images-cdn.ubuy.co.in/667b472170fde739a55c11f4-acer-predator-helios-16-16-quot-1tb.jpg', '2025-02-16 19:29:59', '2025-02-23 21:15:14'),
(21, 'Razer Blade 15', 'Laptop', 'Ultra-slim metal body, 240Hz refresh rate, RTX 4080, per-key RGB lighting, powerful cooling, and high-performance gaming experience.', '249999.00', '12000.00', 10, 'C001', 'https://images.jdmagicbox.com/quickquotes/images_main/razer-blade-15-studio-edition-laptop-intel-core-i7-9750h-nvidia-quadro-rtx-5000-15-6-es-4k-oled-touch-32gb-ram-1tb-nvme-ssd-cnc-aluminum-rgb-lighting-thunderbolt-3-mercury-white-179008606-sh4g9.jpg', '2025-02-16 19:29:59', '2025-02-23 21:15:14'),
(22, 'Beats Studio Pro', 'Headphone', 'Wireless over-ear headphones with active noise cancellation, deep bass, seamless Apple ecosystem integration, and up to 40 hours of battery life.', '27999.00', '2000.00', 30, 'C001', 'https://i.guim.co.uk/img/media/b9ae63942e511f761d76439b9d2431ca5e17e59d/0_297_5456_3273/master/5456.jpg?width=700&quality=85&auto=format&fit=max&s=677b0411fa25b7118b0809481f13fa40', '2025-02-16 19:29:59', '2025-02-23 21:19:44'),
(23, 'Anker Soundcore Space Q45', 'Headphone', '40-hour battery life, adaptive noise canceling, deep bass, lightweight comfort, and Hi-Res audio support for crystal-clear music and calls.', '14999.00', '1500.00', 25, 'C001', 'https://ankerpakistan.com/cdn/shop/files/1702650077_61rb2FQ0pCL__AC_SL1500.jpg?v=1711222054', '2025-02-16 19:29:59', '2025-02-23 21:20:46'),
(24, 'Samsung Galaxy Watch6 Classic LTE', 'Smartwatch', 'Premium rotating bezel, LTE connectivity, ECG, blood pressure monitoring.', '39999.00', '2000.00', 50, 'C001', 'https://images.samsung.com/in/galaxy-watch6-classic/feature/galaxy-watch6-classic-safety-image-main-mo.jpg', '2025-02-16 20:02:25', '2025-02-23 21:24:23'),
(25, 'Apple Watch Series 9 GPS + Cellular', 'Smartwatch', 'Always-on Retina display, advanced health tracking, crash detection, and Siri integration.', '55900.00', '2500.00', 40, 'C001', 'https://iplanet.one/cdn/shop/files/Apple_Watch_Series_9_LTE_45mm_Midnight_Aluminium_Midnight_Sport_Loop_PDP_Image_Position-1__en-IN_1291651f-f69f-40e6-89c3-0992fe79c679.jpg?v=1698865744&width=823', '2025-02-16 20:02:25', '2025-02-23 21:24:23'),
(26, 'Garmin Fenix 7X Sapphire Solar', 'Smartwatch', 'Solar-powered, GPS multi-sport tracking, heart rate monitoring, rugged design.', '98990.00', '5000.00', 30, 'C001', 'https://static.garmincdn.com/en/products/010-02541-10/g/36197-16-9bddfd1d-51b0-444e-89bc-4ef237f66301.jpg', '2025-02-16 20:02:25', '2025-02-23 21:24:23'),
(27, 'Amazfit GTR 4', 'Smartwatch', 'AMOLED display, dual-band GPS, AI fitness tracking, long battery life.', '16999.00', '1500.00', 60, 'C001', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9Se1SXhj79x1BtzLsXIW-vyBYxiUWbO6SDA&s', '2025-02-16 20:02:25', '2025-02-23 21:24:23'),
(28, 'OnePlus Watch 2', 'Smartwatch', 'Snapdragon W5 Gen 1, seamless OS integration, 14-day battery life.', '24999.00', '1800.00', 45, 'C001', 'https://m.media-amazon.com/images/I/71aBW0OfxJL.jpg', '2025-02-16 20:02:25', '2025-02-23 21:24:23'),
(29, 'JBL Charge 5', 'Bluetooth Speaker', '20-hour battery life, IP67 waterproof, powerful bass, portable design.', '14999.00', '1000.00', 70, 'C001', 'https://in.jbl.com/dw/image/v2/BFND_PRD/on/demandware.static/-/Sites-masterCatalog_Harman/default/dw915dda4b/pdp/JBL_Charge_5_Lifestyle1_904x560px.png?sw=904&sh=560', '2025-02-16 20:02:25', '2025-02-23 21:26:53'),
(30, 'Sony SRS-XB43', 'Bluetooth Speaker', 'Extra Bass, Party Connect feature, durable and waterproof build.', '18999.00', '1200.00', 55, 'C001', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY0tMD9luI--MPXv20Zllv7WPwoI_Ap19M4w&s', '2025-02-16 20:02:25', '2025-02-23 21:26:53'),
(31, 'Bose SoundLink Revolve+ II', 'Bluetooth Speaker', '360-degree sound, water-resistant, strong bass, premium design.', '29999.00', '2500.00', 35, 'C001', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY4PF11w_L14SNAEt2rfenttGMn4F22mAAxw&s', '2025-02-16 20:02:25', '2025-02-23 21:26:53'),
(32, 'Marshall Emberton II', 'Bluetooth Speaker', 'Signature Marshall sound, compact design, 30-hour playtime.', '17999.00', '1500.00', 50, 'C001', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtw3pEKWTXb5NiyTXXIM7bpM74m42wQkxWNw&s', '2025-02-16 20:02:25', '2025-02-23 21:28:05'),
(33, 'Ultimate Ears Boom 3', 'Bluetooth Speaker', '360-degree sound, Magic Button, waterproof, rugged build.', '12999.00', '900.00', 80, 'C001', 'https://elcytec.com/wp-content/uploads/2024/10/elcytec_ue_boom_3_blue.webp', '2025-02-16 20:02:25', '2025-02-23 21:28:05'),
(34, 'Nike Dri-FIT Tee', 'T-Shirt', 'Breathable and sweat-wicking fabric, ideal for sports and casual wear.', '1999.00', '200.00', 98, 'C002', 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/9b59b46f-f1dd-4957-8003-d3d3018996b1/AS+M+NK+DF+TEE+RLGD+SL+RESET.png', '2025-02-16 20:19:09', '2025-02-24 10:50:57'),
(35, 'Adidas Classic Tee', 'T-Shirt', 'Soft cotton blend, crew neck, classic fit.', '1599.00', '150.00', 80, 'C002', 'https://assets.adidas.com/images/w_600,f_auto,q_auto/cc60af3a88004e30a8a2747933992cad_9366/adidas_Originals_Tee_Black_JD0681_01_laydown_hover.jpg', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(36, 'Puma Graphic Print Tee', 'T-Shirt', 'Stylish graphic design, lightweight, everyday wear.', '1299.00', '100.00', 120, 'C002', 'https://rukminim2.flixcart.com/image/750/900/kshtxu80/t-shirt/c/l/l/m-53307101-puma-original-imag6fybfsdqgykw.jpeg?q=20&crop=false', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(37, 'Levi’s Crew Neck Tee', 'T-Shirt', 'Signature Levi’s logo print, 100% cotton, relaxed fit.', '1799.00', '180.00', 90, 'C002', 'https://media-uk.landmarkshops.in/cdn-cgi/image/h=831,w=615,q=85,fit=cover/lifestyle/1000005632013-16960-0124-Red-Red-1000005632013_02-2100.jpg', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(38, 'H&M Oversized Tee', 'T-Shirt', 'Trendy oversized fit, soft-touch fabric.', '1399.00', '120.00', 110, 'C002', 'https://assets.ajio.com/medias/sys_master/root/20240829/C0Qf/66d09dd86f60443f313df953/-473Wx593H-700323066-pink-MODEL.jpg', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(39, 'Levi’s 511 Slim Fit Jeans', 'Jeans', 'Stretchable slim fit, dark wash, durable fabric.', '3499.00', '300.00', 60, 'C002', 'https://img1.theiconic.com.au/UwbU7sQznhZaERz2N7LEVxEraGY=/634x811/filters:quality(95):fill(ffffff)/http%3A%2F%2Fstatic.theiconic.com.au%2Fp%2Flevis-0504-926325-1.jpg', '2025-02-16 20:19:09', '2025-02-16 20:19:09'),
(40, 'Wrangler Regular Fit Jeans', 'Jeans', 'Classic straight fit, heavy-duty denim.', '2999.00', '250.00', 50, 'C002', 'https://static.aceomni.cmsaceturtle.com/prod/product-image/aceomni/Wrangler/Monobrand/WMJN005513/WMJN005513_1.jpg', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(41, 'Pepe Skinny Fit Jeans', 'Jeans', 'Trendy skinny fit, stylish faded look.', '2799.00', '200.00', 70, 'C002', 'https://assets.myntassets.com/w_412,q_60,dpr_2,fl_progressive/assets/images/22635226/2023/7/24/36fc8fee-d800-42a9-b98d-5aa8b92685591690174540798-Pepe-Jeans-Men-Skinny-Fit-Heavy-Fade-Jeans-5051690174540489-1.jpg', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(42, 'Diesel Tapered Jeans', 'Jeans', 'Premium quality, tapered cut, perfect casual wear.', '4999.00', '500.00', 40, 'C002', 'https://global.diesel.com/on/demandware.static/-/Sites-diesel-master-catalog/default/dw389e31d0/images/large/A03571_0PFAZ_01_F.jpg', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(43, 'Zara Ripped Jeans', 'Jeans', 'Fashion-forward ripped design, slim fit.', '3299.00', '280.00', 55, 'C002', 'https://i.pinimg.com/736x/97/be/05/97be05fce3d8a46c567960cbaae3e1e4.jpg', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(44, 'Nike Windrunner Jacket', 'Jacket', 'Lightweight, water-resistant, breathable fabric.', '5999.00', '500.00', 45, 'C002', 'https://images-cdn.ubuy.co.in/654ded39aec4963e6258e1dd-nike-sportswear-windrunner-hooded.jpg', '2025-02-16 20:19:09', '2025-02-16 20:19:09'),
(45, 'Adidas Puffer Jacket', 'Jacket', 'Warm insulation, stylish puffer design.', '7499.00', '700.00', 35, 'C002', 'https://assets.adidas.com/images/w_600,f_auto,q_auto/fbbfcb698aa340d4a47fee1ba175b5d0_9366/Y-3_Puffer_Jacket_Black_IL2033.jpg', '2025-02-16 20:19:09', '2025-02-23 21:35:11'),
(46, 'North Face Trekking Jacket', 'Jacket', 'Windproof, ideal for outdoor activities.', '8999.00', '900.00', 30, 'C002', 'https://res.cloudinary.com/ekoweb/image/upload/s--lcB3HuiN--/f_auto,h_600,q_auto:eco,w_600/products/9-151759/views/9-151759__nf0a86qqpv6_01', '2025-02-16 20:19:09', '2025-02-23 21:42:15'),
(47, 'Levi’s Denim Jacket', 'Jacket', 'Classic denim design, versatile styling.', '5499.00', '450.00', 50, 'C002', 'https://images-cdn.ubuy.co.in/64d0e2d161f09d257a45bd39-levi-s-men-s-denim-trucker-jacket.jpg', '2025-02-16 20:19:09', '2025-02-23 21:42:15'),
(48, 'Zara Leather Jacket', 'Jacket', 'Premium faux leather, biker-style look.', '9999.00', '1000.00', 25, 'C002', 'https://media.vogue.in/wp-content/uploads/2021/03/Zara-leather-jacket.jpg', '2025-02-16 20:19:09', '2025-02-23 21:43:34'),
(49, 'Forever 21 Floral Dress', 'Dress', 'Lightweight, floral print, knee-length.', '2999.00', '250.00', 70, 'C002', 'https://imagescdn.forever21.in/img/app/product/4/450447-3011913.jpg', '2025-02-16 20:19:09', '2025-02-23 21:45:33'),
(50, 'Zara Bodycon Dress', 'Dress', 'Elegant body-hugging fit, perfect for evening wear.', '4499.00', '400.00', 50, 'C002', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpQ1X7aMB32y_WbPr8ONYkTjMNC-wi3UDbqQ&s', '2025-02-16 20:19:09', '2025-02-23 21:45:33'),
(51, 'H&M Midi Dress', 'Dress', 'Trendy midi length, breathable fabric.', '3499.00', '300.00', 65, 'C002', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtE4-z_G77QRGt8Qr4BYVsHj1biz2kCKB4cA&sple.com/hm_midi.jpg', '2025-02-16 20:19:09', '2025-02-23 21:48:30'),
(52, 'Mango Off-Shoulder Dress', 'Dress', 'Stylish off-shoulder design, party wear.', '4999.00', '500.00', 40, 'C002', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoS__CUB6IFn0dg_skc_DY0fAhBfVLDFOJaw&s', '2025-02-16 20:19:09', '2025-02-23 21:48:00'),
(53, 'Gucci Silk Gown', 'Dress', 'Luxury silk fabric, red-carpet ready.', '19999.00', '2000.00', 15, 'C002', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJaok1Oeff3Ee-qmZ4DtwSt59ZZamGKDOLtQ&s', '2025-02-16 20:19:09', '2025-02-23 21:58:30'),
(54, 'Nike Air Force 1', 'Sneakers', 'Classic low-top sneaker, premium leather build.', '6999.00', '600.00', 80, 'C002', 'https://assets.ajio.com/medias/sys_master/root/20241009/imxn/670684f4f9b8ef490ba87889/-473Wx593H-469685807-blackgrey-MODEL5.jpg', '2025-02-16 20:19:09', '2025-02-23 21:59:37'),
(55, 'Adidas Ultraboost', 'Sneakers', 'High-performance running shoe, Boost cushioning.', '8999.00', '800.00', 70, 'C002', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/shoe/e/g/m/-original-imah5vxzgtthpu89.jpeg?q=90&crop=false', '2025-02-16 20:19:09', '2025-02-23 21:59:37'),
(56, 'Puma RS-X', 'Sneakers', 'Chunky sole, modern design.', '5999.00', '500.00', 75, 'C002', 'https://m.economictimes.com/thumb/msid-68843917,width-1200,height-900,resizemode-4,imgsize-326409/puma-rs-x-trophies.jpg', '2025-02-16 20:19:09', '2025-02-23 22:02:02'),
(57, 'New Balance 574', 'Sneakers', 'Timeless retro design, comfort-focused.', '7499.00', '700.00', 60, 'C002', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhU_7Vb001ZJ3YGNtYjVp-_GHie-auH6Nn-A&s', '2025-02-16 20:19:09', '2025-02-23 22:02:02'),
(58, 'Vans Old Skool', 'Sneakers', 'Iconic skate shoe, durable canvas.', '5499.00', '450.00', 90, 'C002', 'https://images-cdn.ubuy.co.in/633c12fed81a9c38d503bcbc-vans-old-skool-platform-unisex-adult.jpg', '2025-02-16 20:19:09', '2025-02-23 22:02:02'),
(59, 'Nike Fleece Hoodie', 'Hoodie', 'Soft fleece fabric, adjustable hood.', '3999.00', '350.00', 100, 'C002', 'https://threadlogic.com/cdn/shop/files/NIKE-Club-Fleece-Pullover-Hoodie-Navy-S-21_800x.jpg?v=1713972442', '2025-02-16 20:19:09', '2025-02-16 20:19:09'),
(60, 'Adidas Trefoil Hoodie', 'Hoodie', 'Oversized fit, signature Adidas logo.', '4299.00', '400.00', 80, 'C002', 'https://www.ubuy.co.in/productimg/?image=aHR0cHM6Ly9pbWFnZXMtY2RuLnVidXkuY28uaW4vNjM2ODhhZjFkYzI2ODQ1ZmQ2NGZiZDUzLW5ldy1tZW5zLWFkaWRhcy1vcmlnaW5hbC1tZW5zLXRyZWZvaWwuanBn.jpg', '2025-02-16 20:19:09', '2025-02-23 22:04:56'),
(61, 'Puma Essential Hoodie', 'Hoodie', 'Lightweight, everyday wear.', '3499.00', '300.00', 89, 'C002', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3KsVLpPODimI_KwJ7brJekfiE3rNr89DdMQ&s', '2025-02-16 20:19:09', '2025-02-23 22:04:56'),
(62, 'Supreme Box Logo Hoodie', 'Hoodie', 'Streetwear staple, premium cotton.', '12999.00', '1200.00', 30, 'C002', 'https://hypefly.co.in/_next/image?url=https%3A%2F%2Fdjm0962033frr.cloudfront.net%2F1334258_01_jpg_f195e7fb86.webp&w=3840&q=75', '2025-02-16 20:19:09', '2025-02-23 22:04:56'),
(63, 'Champion Reverse Weave Hoodie', 'Hoodie', 'Durable, heavyweight fleece.', '5999.00', '550.00', 60, 'C002', 'https://www.careofcarl.com/bilder/artiklar/zoom/25395711r_1.jpg?m=1695729438', '2025-02-16 20:19:09', '2025-02-23 22:04:56'),
(64, 'Raymond Classic Suit', 'Formal Suit', 'Wool blend, two-piece suit.', '9999.00', '800.00', 40, 'C002', 'https://5.imimg.com/data5/ANDROID/Default/2022/1/EJ/OL/TY/144942171/product-jpeg.jpg', '2025-02-16 20:19:09', '2025-02-16 20:19:09'),
(65, 'Van Heusen Slim Fit Suit', 'Formal Suit', 'Modern slim fit, elegant look.', '11999.00', '1000.00', 35, 'C002', 'https://imagescdn.vanheusenindia.com/img/app/product/7/795996-9357593.jpg?auto=format&w=390', '2025-02-16 20:19:09', '2025-02-23 22:09:24'),
(66, 'Arrow Three-Piece Suit', 'Formal Suit', 'Includes waistcoat, tailored fit.', '13999.00', '1200.00', 30, 'C002', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSR0xAdi5Lfh4kl9dZKI0nPOT2cOgCpWN_OIg&s', '2025-02-16 20:19:09', '2025-02-23 22:09:24'),
(67, 'Louis Philippe Suit', 'Formal Suit', 'Premium Italian fabric, business wear.', '15999.00', '1500.00', 25, 'C002', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgQkuyPZ8biLPpj8xg4B0mD9WseM6lWWOMjg&s', '2025-02-16 20:19:09', '2025-02-23 22:09:24'),
(68, 'Hugo Boss Executive Suit', 'Formal Suit', 'Luxury fit, sharp tailoring.', '24999.00', '2000.00', 15, 'C002', 'https://i.pinimg.com/736x/58/b6/5d/58b65d0b74c5e7771a18c8f33fa7d5ba.jpg', '2025-02-16 20:19:09', '2025-02-23 22:09:24'),
(69, 'The Great Gatsby', 'Fiction Novel', 'Classic novel by F. Scott Fitzgerald about the American Dream.', '499.00', '50.00', 100, 'C003', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1650033243i/41733839.jpg', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(70, 'To Kill a Mockingbird', 'Fiction Novel', 'Harper Lee’s timeless story about racial injustice and morality.', '599.00', '60.00', 90, 'C003', 'https://cdn.penguin.co.in/wp-content/uploads/2023/06/9780099549482-3.jpg', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(71, '1984', 'Fiction Novel', 'Dystopian novel by George Orwell about totalitarianism.', '699.00', '70.00', 80, 'C003', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1532714506i/40961427.jpg', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(72, 'Pride and Prejudice', 'Fiction Novel', 'Jane Austen’s classic romance novel.', '549.00', '50.00', 70, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG8jDNGfkdt8Bd4pmgKtdDVS36NrAk8D9n4g&s', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(73, 'The Catcher in the Rye', 'Fiction Novel', 'J.D. Salinger’s coming-of-age story.', '650.00', '60.00', 85, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFbx4VXBiZRM11hSqJRrC7f1HLQrCUkgMY8g&s', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(74, 'Atomic Habits', 'Self-Help Book', 'James Clear’s guide to building better habits.', '899.00', '100.00', 120, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdXXLVyWh84sPMCwumI2aQYmhGQKHCZp1lKA&s', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(75, 'The Power of Now', 'Self-Help Book', 'Eckhart Tolle’s book on mindfulness and living in the present.', '799.00', '80.00', 110, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoAaWt9C-3uA2C466iMZ4YT3sTdymJFmGdCg&s', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(76, 'Think and Grow Rich', 'Self-Help Book', 'Napoleon Hill’s book on financial success.', '750.00', '75.00', 95, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbxRWb_bZQsxzRejKlpOwvzOHIjq6vfwo9Vg&s', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(77, 'The Subtle Art of Not Giving a F*ck', 'Self-Help Book', 'Mark Manson’s unconventional guide to happiness.', '899.00', '90.00', 85, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk1tHXoaYpST9BGDopKbXASqElrWL7KHNAvw&s', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(78, 'Rich Dad Poor Dad', 'Self-Help Book', 'Robert Kiyosaki’s book on financial education.', '850.00', '85.00', 100, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcZOpYSg9gAZjiWOlECYgjkHAoQrFwxc4-UQ&s', '2025-02-16 20:22:00', '2025-02-23 22:15:09'),
(79, 'Calculus by James Stewart', 'Educational Textbook', 'Comprehensive guide to calculus concepts.', '1499.00', '200.00', 50, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT15-1MqsJ4SbEnxvJY2kAPeIfgNLB8O3ST4w&s', '2025-02-16 20:22:00', '2025-02-23 22:19:10'),
(80, 'Physics for Scientists and Engineers', 'Educational Textbook', 'Essential physics textbook by Serway and Jewett.', '1999.00', '250.00', 40, 'C003', 'https://cdn01.sapnaonline.com/product_media/9789386650672/md_9789386650672.jpg', '2025-02-16 20:22:00', '2025-02-23 22:19:10'),
(81, 'Introduction to Algorithms', 'Educational Textbook', 'Standard textbook on algorithms by Cormen.', '2299.00', '300.00', 35, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdo78qWf1407mWXObS51WvqQjOtNT8oasa1g&s', '2025-02-16 20:22:00', '2025-02-23 22:19:10'),
(82, 'Biology: Concepts and Applications', 'Educational Textbook', 'Fundamental biology concepts by Starr and Taggart.', '1599.00', '180.00', 45, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR04d0Z5wWVV8ng-R_bMiYbOYvuFjhjFkUXhw&s', '2025-02-16 20:22:00', '2025-02-23 22:19:10'),
(83, 'Organic Chemistry by Paula Bruice', 'Educational Textbook', 'Comprehensive organic chemistry guide.', '1899.00', '220.00', 30, 'C003', 'https://m.media-amazon.com/images/I/61NbI4MSc9L._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:22:00', '2025-02-23 22:19:10'),
(84, 'Dune', 'Science Fiction', 'Frank Herbert’s epic sci-fi novel about power and destiny.', '899.00', '90.00', 60, 'C003', 'https://m.media-amazon.com/images/I/71m91l0treL._UF1000,1000_QL80_.jpg', '2025-02-16 20:22:00', '2025-02-23 22:19:10'),
(85, 'The Hitchhiker’s Guide to the Galaxy', 'Science Fiction', 'Douglas Adams’ humorous sci-fi classic.', '799.00', '80.00', 70, 'C003', 'https://m.media-amazon.com/images/M/MV5BMTg4OWYwZjgtZDU0ZS00NjU4LTkxNjItYmYyYmUwNDU5YmM3XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg', '2025-02-16 20:22:00', '2025-02-23 22:21:45'),
(86, 'Foundation', 'Science Fiction', 'Isaac Asimov’s visionary sci-fi series.', '999.00', '100.00', 55, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMXeEdhYHrLbHAe6Xscsj5M5JIqaAEa3zIBQ&s', '2025-02-16 20:22:00', '2025-02-23 22:22:43'),
(87, 'Neuromancer', 'Science Fiction', 'William Gibson’s cyberpunk masterpiece.', '849.00', '85.00', 65, 'C003', 'https://images.squarespace-cdn.com/content/v1/51ad3961e4b0ae1d9bf5b6f1/a4f2090e-148f-4ca0-9174-48765db17223/William-Gibson-Neuromancer-Cyberpunk-Cover-Web.jpg?format=750w', '2025-02-16 20:22:00', '2025-02-23 22:22:43'),
(88, 'The Martian', 'Science Fiction', 'Andy Weir’s thrilling space survival story.', '950.00', '95.00', 75, 'C003', 'https://example.com/the_martian.jpg', '2025-02-16 20:22:00', '2025-02-16 20:22:00'),
(89, 'Steve Jobs by Walter Isaacson', 'Biography', 'Insightful biography of Apple’s co-founder.', '1299.00', '150.00', 40, 'C003', 'https://i.etsystatic.com/17875647/r/il/4a2138/3752106438/il_fullxfull.3752106438_kusi.jpg', '2025-02-16 20:22:00', '2025-02-23 22:35:32'),
(90, 'Becoming by Michelle Obama', 'Biography', 'Inspirational memoir of the former First Lady.', '999.00', '100.00', 50, 'C003', 'https://i.etsystatic.com/17875647/r/il/4a2138/3752106438/il_fullxfull.3752106438_kusi.jpg', '2025-02-16 20:22:00', '2025-02-23 22:35:32'),
(91, 'The Diary of a Young Girl', 'Biography', 'Anne Frank’s powerful story.', '699.00', '70.00', 60, 'C003', 'https://i.etsystatic.com/17875647/r/il/4a2138/3752106438/il_fullxfull.3752106438_kusi.jpg', '2025-02-16 20:22:00', '2025-02-23 22:35:32'),
(92, 'Elon Musk by Ashlee Vance', 'Biography', 'Biography of Tesla and SpaceX founder.', '1099.00', '120.00', 45, 'C003', 'https://i.etsystatic.com/17875647/r/il/4a2138/3752106438/il_fullxfull.3752106438_kusi.jpg', '2025-02-16 20:22:00', '2025-02-23 22:35:32'),
(93, 'Long Walk to Freedom', 'Biography', 'Nelson Mandela’s autobiography.', '999.00', '100.00', 55, 'C003', 'https://i.etsystatic.com/17875647/r/il/4a2138/3752106438/il_fullxfull.3752106438_kusi.jpg', '2025-02-16 20:22:00', '2025-02-23 22:35:32'),
(94, 'Gone Girl', 'Mystery & Thriller', 'Psychological thriller by Gillian Flynn.', '799.00', '80.00', 70, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcZV-1c20qGMnlUt8DQd8AF7R0HaMlP7uGGQ&s', '2025-02-16 20:22:00', '2025-02-23 22:36:45'),
(95, 'The Girl with the Dragon Tattoo', 'Mystery & Thriller', 'Stieg Larsson’s gripping crime novel.', '899.00', '90.00', 65, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcZV-1c20qGMnlUt8DQd8AF7R0HaMlP7uGGQ&s', '2025-02-16 20:22:00', '2025-02-23 22:36:45'),
(96, 'Sherlock Holmes: The Complete Collection', 'Mystery & Thriller', 'Classic detective stories by Arthur Conan Doyle.', '1299.00', '130.00', 50, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcZV-1c20qGMnlUt8DQd8AF7R0HaMlP7uGGQ&s', '2025-02-16 20:22:00', '2025-02-23 22:36:45'),
(97, 'The Silent Patient', 'Mystery & Thriller', 'Thrilling psychological mystery by Alex Michaelides.', '950.00', '95.00', 75, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcZV-1c20qGMnlUt8DQd8AF7R0HaMlP7uGGQ&s', '2025-02-16 20:22:00', '2025-02-23 22:36:45'),
(98, 'Before I Go to Sleep', 'Mystery & Thriller', 'S.J. Watson’s suspenseful thriller.', '849.00', '85.00', 80, 'C003', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcZV-1c20qGMnlUt8DQd8AF7R0HaMlP7uGGQ&s', '2025-02-16 20:22:00', '2025-02-23 22:36:45'),
(99, 'Harry Potter and the Sorcerer’s Stone', 'Fantasy', 'J.K. Rowling’s magical adventure.', '799.00', '80.00', 90, 'C003', 'https://m.media-amazon.com/images/I/71XLiqZnMLL._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:22:00', '2025-02-23 22:38:06'),
(100, 'The Hobbit', 'Fantasy', 'J.R.R. Tolkien’s classic adventure story.', '899.00', '90.00', 85, 'C003', 'https://m.media-amazon.com/images/I/71XLiqZnMLL._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:22:00', '2025-02-23 22:38:06'),
(101, 'The Name of the Wind', 'Fantasy', 'Patrick Rothfuss’ epic fantasy novel.', '999.00', '100.00', 75, 'C003', 'https://m.media-amazon.com/images/I/71XLiqZnMLL._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:22:00', '2025-02-23 22:38:06'),
(102, 'A Game of Thrones', 'Fantasy', 'The first book in George R.R. Martin’s series.', '1099.00', '120.00', 65, 'C003', 'https://m.media-amazon.com/images/I/71XLiqZnMLL._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:22:00', '2025-02-23 22:38:06'),
(103, 'The Way of Kings', 'Fantasy', 'Brandon Sanderson’s legendary high fantasy book.', '1199.00', '130.00', 55, 'C003', 'https://m.media-amazon.com/images/I/71XLiqZnMLL._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:22:00', '2025-02-23 22:38:06'),
(104, 'Samsung 345L Double Door', 'Refrigerator', 'Frost-free refrigerator with digital inverter technology.', '34999.00', '2000.00', 50, 'C004', 'https://hips.hearstapps.com/hmg-prod/images/best-fridges-673bac80a584c.png?crop=0.502xw:1.00xh;0.250xw,0&resize=640:*', '2025-02-16 20:25:25', '2025-02-23 22:39:24'),
(105, 'LG 260L Smart Inverter', 'Refrigerator', 'Energy-efficient refrigerator with smart diagnosis feature.', '29999.00', '1500.00', 40, 'C004', 'https://hips.hearstapps.com/hmg-prod/images/best-fridges-673bac80a584c.png?crop=0.502xw:1.00xh;0.250xw,0&resize=640:*', '2025-02-16 20:25:25', '2025-02-23 22:39:24'),
(106, 'Whirlpool 190L Single Door', 'Refrigerator', 'Compact refrigerator with auto-defrost function.', '15999.00', '1000.00', 60, 'C004', 'https://hips.hearstapps.com/hmg-prod/images/best-fridges-673bac80a584c.png?crop=0.502xw:1.00xh;0.250xw,0&resize=640:*', '2025-02-16 20:25:25', '2025-02-23 22:39:24'),
(107, 'Samsung 28L Convection Microwave', 'Microwave', 'Smart convection microwave with auto cook menu.', '12499.00', '800.00', 30, 'C004', 'https://images-cdn.ubuy.co.in/66b564e668d1c8756957bd90-mainstays-0-7-cu-ft-countertop-microwave.jpg', '2025-02-16 20:25:25', '2025-02-23 22:40:43'),
(108, 'LG 20L Solo Microwave', 'Microwave', 'Compact microwave with auto-defrost function.', '7999.00', '500.00', 40, 'C004', 'https://images-cdn.ubuy.co.in/66b564e668d1c8756957bd90-mainstays-0-7-cu-ft-countertop-microwave.jpg', '2025-02-16 20:25:25', '2025-02-23 22:40:43'),
(109, 'IFB 30L Convection Microwave', 'Microwave', 'High-capacity microwave with grill and convection modes.', '15499.00', '1200.00', 25, 'C004', 'https://images-cdn.ubuy.co.in/66b564e668d1c8756957bd90-mainstays-0-7-cu-ft-countertop-microwave.jpg', '2025-02-16 20:25:25', '2025-02-23 22:40:43'),
(110, 'Samsung 6.5 kg Fully Automatic', 'Washing Machine', 'Top load washing machine with digital inverter technology.', '22999.00', '1500.00', 35, 'C004', 'https://kenstar.in/cdn/shop/files/1_9678783f-f7ae-4158-85ea-3e7473d89f4a.jpg?v=1706710884', '2025-02-16 20:25:25', '2025-02-23 22:41:43'),
(111, 'LG 7 kg Front Load', 'Washing Machine', 'Energy-efficient washing machine with steam wash.', '28999.00', '2000.00', 25, 'C004', 'https://kenstar.in/cdn/shop/files/1_9678783f-f7ae-4158-85ea-3e7473d89f4a.jpg?v=1706710884', '2025-02-16 20:25:25', '2025-02-23 22:41:43'),
(112, 'Whirlpool 6.5 kg Semi Automatic', 'Washing Machine', 'Budget-friendly washing machine with turbo scrub.', '15999.00', '1000.00', 45, 'C004', 'https://kenstar.in/cdn/shop/files/1_9678783f-f7ae-4158-85ea-3e7473d89f4a.jpg?v=1706710884', '2025-02-16 20:25:25', '2025-02-23 22:41:43'),
(113, 'Dyson V12 Cordless Vacuum', 'Vacuum Cleaner', 'Powerful cordless vacuum with HEPA filter.', '47999.00', '3000.00', 20, 'C004', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/vacuum-cleaner/g/k/a/-original-imagrxzpwdnuyhyr.jpeg?q=20&crop=false', '2025-02-16 20:25:25', '2025-02-23 22:42:36'),
(114, 'Eureka Forbes Trendy Zip', 'Vacuum Cleaner', 'Compact vacuum cleaner with powerful suction.', '5999.00', '500.00', 50, 'C004', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/vacuum-cleaner/g/k/a/-original-imagrxzpwdnuyhyr.jpeg?q=20&crop=false', '2025-02-16 20:25:25', '2025-02-23 22:42:36'),
(115, 'Philips PowerPro FC9352', 'Vacuum Cleaner', 'Bagless vacuum cleaner with turbo brush.', '10499.00', '800.00', 30, 'C004', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/vacuum-cleaner/g/k/a/-original-imagrxzpwdnuyhyr.jpeg?q=20&crop=false', '2025-02-16 20:25:25', '2025-02-23 22:42:36'),
(116, 'Daikin 1.5 Ton 5 Star Inverter AC', 'Air Conditioner', 'Energy-efficient split AC with PM2.5 filter.', '42999.00', '2500.00', 25, 'C004', 'https://m.media-amazon.com/images/I/61djZICdUAL._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:25:25', '2025-02-23 22:43:47'),
(117, 'LG 1.5 Ton Dual Inverter AC', 'Air Conditioner', 'Smart AC with AI cooling and low noise operation.', '45999.00', '3000.00', 20, 'C004', 'https://m.media-amazon.com/images/I/61djZICdUAL._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:25:25', '2025-02-23 22:43:47'),
(118, 'Blue Star 1 Ton 3 Star Split AC', 'Air Conditioner', 'Affordable split AC with turbo cooling mode.', '30999.00', '2000.00', 30, 'C004', 'https://m.media-amazon.com/images/I/61djZICdUAL._AC_UF1000,1000_QL80_.jpg', '2025-02-16 20:25:25', '2025-02-23 22:43:47'),
(119, 'Kent Grand RO+UV+UF', 'Water Purifier', 'Advanced water purifier with mineral RO technology.', '18999.00', '1500.00', 40, 'C004', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkNamW5lVbkDRNRAsHVO_0RX1so5msF4uDbQ&s', '2025-02-16 20:25:25', '2025-02-23 22:57:59'),
(120, 'Aquaguard Aura UV+UF', 'Water Purifier', 'Electric water purifier with active copper technology.', '12999.00', '1000.00', 50, 'C004', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkNamW5lVbkDRNRAsHVO_0RX1so5msF4uDbQ&s', '2025-02-16 20:25:25', '2025-02-23 22:57:59'),
(121, 'Blue Star Excella RO+UV', 'Water Purifier', 'Compact purifier with double-layered protection.', '11999.00', '900.00', 55, 'C004', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkNamW5lVbkDRNRAsHVO_0RX1so5msF4uDbQ&s', '2025-02-16 20:25:25', '2025-02-23 22:57:59'),
(122, 'Bosch 13 Place Settings Dishwasher', 'Dishwasher', 'Fully automatic dishwasher with intensive wash mode.', '48999.00', '3500.00', 15, 'C004', 'https://www.ikea.com/global/assets/range-categorisation/images/dishwashers-20825.jpeg', '2025-02-16 20:25:25', '2025-02-23 22:59:05'),
(123, 'LG 14 Place Settings Dishwasher', 'Dishwasher', 'Smart dishwasher with TrueSteam technology.', '52999.00', '4000.00', 12, 'C004', 'https://www.ikea.com/global/assets/range-categorisation/images/dishwashers-20825.jpeg', '2025-02-16 20:25:25', '2025-02-23 22:59:05'),
(124, 'Voltas Beko 8 Place Tabletop Dishwasher', 'Dishwasher', 'Compact dishwasher with eco wash mode.', '22999.00', '2000.00', 25, 'C004', 'https://www.ikea.com/global/assets/range-categorisation/images/dishwashers-20825.jpeg', '2025-02-16 20:25:25', '2025-02-23 22:59:05'),
(125, 'AmazonBasics 10kg Dumbbell Set', 'Dumbbells', 'Hexagonal rubber-coated dumbbells with anti-slip grip.', '2999.00', '200.00', 50, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKnBYmh5kmj4P5vl8hFS6lUb7ugKXwJnr3cw&s', '2025-02-16 20:27:44', '2025-02-23 22:59:59'),
(126, 'CAP Barbell Adjustable Dumbbells', 'Dumbbells', 'Adjustable dumbbells with a total weight of 20kg.', '5999.00', '500.00', 30, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKnBYmh5kmj4P5vl8hFS6lUb7ugKXwJnr3cw&s', '2025-02-16 20:27:44', '2025-02-23 22:59:59'),
(127, 'Bowflex SelectTech 552', 'Dumbbells', 'Adjustable dumbbell with 15 weight settings.', '18999.00', '1500.00', 20, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKnBYmh5kmj4P5vl8hFS6lUb7ugKXwJnr3cw&s', '2025-02-16 20:27:44', '2025-02-23 22:59:59'),
(128, 'Kore 15kg Home Gym Dumbbells', 'Dumbbells', 'Cast iron dumbbells with rubber grip handles.', '3499.00', '300.00', 40, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKnBYmh5kmj4P5vl8hFS6lUb7ugKXwJnr3cw&s', '2025-02-16 20:27:44', '2025-02-23 22:59:59'),
(129, 'Strauss Anti-Skid Yoga Mat', 'Yoga Mat', 'Eco-friendly TPE yoga mat with non-slip surface.', '1299.00', '100.00', 50, 'C005', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/sport-mat/a/q/v/yoga-mat-4-60-manokamna-store-182-original-imagk7ucuskhtfz6.jpeg?q=90&crop=false', '2025-02-16 20:27:44', '2025-02-23 23:01:10'),
(130, 'AmazonBasics 13mm Extra Thick Mat', 'Yoga Mat', 'Soft and thick yoga mat for extra comfort.', '1999.00', '150.00', 40, 'C005', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/sport-mat/a/q/v/yoga-mat-4-60-manokamna-store-182-original-imagk7ucuskhtfz6.jpeg?q=90&crop=false', '2025-02-16 20:27:44', '2025-02-23 23:01:10'),
(131, 'Reebok 6mm Yoga Mat', 'Yoga Mat', 'Lightweight and durable yoga mat for home workouts.', '2499.00', '200.00', 30, 'C005', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/sport-mat/a/q/v/yoga-mat-4-60-manokamna-store-182-original-imagk7ucuskhtfz6.jpeg?q=90&crop=false', '2025-02-16 20:27:44', '2025-02-23 23:01:10'),
(132, 'Nike Flow Yoga Mat', 'Yoga Mat', 'Premium yoga mat with high-density foam.', '3499.00', '300.00', 25, 'C005', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/sport-mat/a/q/v/yoga-mat-4-60-manokamna-store-182-original-imagk7ucuskhtfz6.jpeg?q=90&crop=false', '2025-02-16 20:27:44', '2025-02-23 23:01:10'),
(133, 'Nike Revolution 6', 'Running Shoes', 'Lightweight running shoes with responsive cushioning.', '5999.00', '500.00', 60, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPC2WHMQZl2ZfiCQIAoqSZcxk4m2v-9xwteg&s', '2025-02-16 20:27:44', '2025-02-23 23:02:17'),
(134, 'Adidas Ultraboost 22', 'Running Shoes', 'High-performance running shoes with energy return.', '12999.00', '1200.00', 40, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPC2WHMQZl2ZfiCQIAoqSZcxk4m2v-9xwteg&s', '2025-02-16 20:27:44', '2025-02-23 23:02:17'),
(135, 'Puma Velocity Nitro 2', 'Running Shoes', 'Soft foam running shoes with carbon rubber outsole.', '8499.00', '800.00', 35, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPC2WHMQZl2ZfiCQIAoqSZcxk4m2v-9xwteg&s', '2025-02-16 20:27:44', '2025-02-23 23:02:17'),
(136, 'Asics Gel-Nimbus 24', 'Running Shoes', 'Premium running shoes with gel technology.', '13999.00', '1500.00', 30, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPC2WHMQZl2ZfiCQIAoqSZcxk4m2v-9xwteg&s', '2025-02-16 20:27:44', '2025-02-23 23:02:17'),
(137, 'Fit Simplify Resistance Loop Bands', 'Resistance Bands', 'Set of 5 bands with different resistance levels.', '999.00', '100.00', 70, 'C005', 'https://m.media-amazon.com/images/I/71SDZVqu3+L._AC_UF894,1000_QL80_.jpg', '2025-02-16 20:27:44', '2025-02-23 23:03:40'),
(138, 'TheraBand Professional Resistance Bands', 'Resistance Bands', 'Latex-free resistance bands for physical therapy.', '1999.00', '200.00', 50, 'C005', 'https://m.media-amazon.com/images/I/71SDZVqu3+L._AC_UF894,1000_QL80_.jpg', '2025-02-16 20:27:44', '2025-02-23 23:03:40'),
(139, 'Letsfit Resistance Band Set', 'Resistance Bands', '5-piece set with door anchor and handles.', '1499.00', '150.00', 45, 'C005', 'https://m.media-amazon.com/images/I/71SDZVqu3+L._AC_UF894,1000_QL80_.jpg', '2025-02-16 20:27:44', '2025-02-23 23:03:40'),
(140, 'Bodylastics Heavy Resistance Bands', 'Resistance Bands', 'Premium resistance bands with reinforced safety.', '2999.00', '300.00', 40, 'C005', 'https://m.media-amazon.com/images/I/71SDZVqu3+L._AC_UF894,1000_QL80_.jpg', '2025-02-16 20:27:44', '2025-02-23 23:03:40'),
(141, 'PowerMax TDM-98 Treadmill', 'Treadmill', 'Compact foldable treadmill with LCD display.', '24999.00', '2500.00', 20, 'C005', 'https://www.cockatooindia.com/cdn/shop/files/CFT2750.jpg?v=1737374138', '2025-02-16 20:27:44', '2025-02-23 22:56:21'),
(142, 'Durafit Heavy Hike Treadmill', 'Treadmill', 'Powerful treadmill with auto incline.', '45999.00', '4000.00', 15, 'C005', 'https://www.cockatooindia.com/cdn/shop/files/CFT2750.jpg?v=1737374138', '2025-02-16 20:27:44', '2025-02-23 22:56:21'),
(143, 'Fitkit FT200 Series', 'Treadmill', 'Smart treadmill with Bluetooth connectivity.', '34999.00', '3500.00', 18, 'C005', 'https://www.cockatooindia.com/cdn/shop/files/CFT2750.jpg?v=1737374138', '2025-02-16 20:27:44', '2025-02-23 22:56:21'),
(144, 'Sparnod Fitness STH-1200', 'Treadmill', 'Home-use treadmill with shock-absorbing system.', '29999.00', '2800.00', 22, 'C005', 'https://www.cockatooindia.com/cdn/shop/files/CFT2750.jpg?v=1737374138', '2025-02-16 20:27:44', '2025-02-23 22:56:21'),
(145, 'Hercules Roadeo A50', 'Bicycle', '21-speed mountain bike with alloy frame.', '15999.00', '1500.00', 25, 'C005', 'https://example.com/hercules_a50.jpg', '2025-02-16 20:27:44', '2025-02-16 20:27:44'),
(146, 'Hero Sprint Thorn 26T', 'Bicycle', 'Lightweight bicycle for urban riding.', '9999.00', '1000.00', 30, 'C005', 'https://example.com/hero_thorn.jpg', '2025-02-16 20:27:44', '2025-02-16 20:27:44'),
(147, 'Firefox Bad Attitude 8', 'Bicycle', 'Single-speed bicycle with stylish frame.', '11999.00', '1200.00', 28, 'C005', 'https://example.com/firefox_ba8.jpg', '2025-02-16 20:27:44', '2025-02-16 20:27:44'),
(148, 'Giant ATX Elite 27.5', 'Bicycle', 'Premium MTB with 27.5-inch wheels and disc brakes.', '34999.00', '3000.00', 15, 'C005', 'https://example.com/giant_atx.jpg', '2025-02-16 20:27:44', '2025-02-16 20:27:44'),
(149, 'Nike Dri-FIT Basketball Jersey', 'Sports Jersey', 'Breathable and lightweight basketball jersey.', '2999.00', '200.00', 60, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxx6tv9Glu0ziiWRP683Zf1XjdYreeF6VneA&s', '2025-02-16 20:27:44', '2025-02-23 22:53:59'),
(150, 'Adidas Manchester United Home Jersey', 'Sports Jersey', 'Official 2023 home jersey with Climacool technology.', '5999.00', '500.00', 40, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxx6tv9Glu0ziiWRP683Zf1XjdYreeF6VneA&s', '2025-02-16 20:27:44', '2025-02-23 22:53:59'),
(151, 'Puma Indian Cricket Team Jersey', 'Sports Jersey', 'Official Indian cricket team jersey with dryCELL.', '4999.00', '400.00', 50, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxx6tv9Glu0ziiWRP683Zf1XjdYreeF6VneA&s', '2025-02-16 20:27:44', '2025-02-23 22:53:59'),
(152, 'Under Armour Training Jersey', 'Sports Jersey', 'Stretch-fit training jersey for all sports.', '3499.00', '300.00', 45, 'C005', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxx6tv9Glu0ziiWRP683Zf1XjdYreeF6VneA&s', '2025-02-16 20:27:44', '2025-02-23 22:53:59'),
(153, 'Himalaya Purifying Neem Face Wash', 'Face Wash', 'Herbal face wash with neem for acne control.', '299.00', '20.00', 100, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsaRib70xT9mvzj3-IbUivLYUM8M60i3AlHA&s', '2025-02-16 20:30:51', '2025-02-23 22:52:46'),
(154, 'Garnier Men Oil Clear Face Wash', 'Face Wash', 'Deep cleansing face wash for oily skin.', '349.00', '30.00', 80, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsaRib70xT9mvzj3-IbUivLYUM8M60i3AlHA&s', '2025-02-16 20:30:51', '2025-02-23 22:52:46'),
(155, 'Nivea Milk Delights Face Wash', 'Face Wash', 'Gentle face wash with honey for soft skin.', '399.00', '40.00', 90, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsaRib70xT9mvzj3-IbUivLYUM8M60i3AlHA&s', '2025-02-16 20:30:51', '2025-02-23 22:52:46'),
(156, 'Pond’s Pure Detox Face Wash', 'Face Wash', 'Activated charcoal face wash for deep cleaning.', '449.00', '50.00', 70, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsaRib70xT9mvzj3-IbUivLYUM8M60i3AlHA&s', '2025-02-16 20:30:51', '2025-02-23 22:52:46'),
(157, 'Maybelline Super Stay Matte Ink', 'Lipstick', 'Long-lasting matte lipstick in vibrant shades.', '799.00', '100.00', 60, 'C006', 'https://images.ctfassets.net/wlke2cbybljx/6Z75K7EQh8g4FfDz4TrtyZ/db8c19ba086ca39a187640400ba323b3/LIPSTICKS_X10_Square_RGB.jpg', '2025-02-16 20:30:51', '2025-02-23 22:51:24'),
(158, 'Lakme 9 to 5 Primer + Matte', 'Lipstick', 'Smooth finish lipstick with built-in primer.', '699.00', '80.00', 75, 'C006', 'https://images.ctfassets.net/wlke2cbybljx/6Z75K7EQh8g4FfDz4TrtyZ/db8c19ba086ca39a187640400ba323b3/LIPSTICKS_X10_Square_RGB.jpg', '2025-02-16 20:30:51', '2025-02-23 22:51:24'),
(159, 'MAC Retro Matte Lipstick', 'Lipstick', 'High-pigment, non-transfer lipstick for all-day wear.', '1999.00', '150.00', 50, 'C006', 'https://images.ctfassets.net/wlke2cbybljx/6Z75K7EQh8g4FfDz4TrtyZ/db8c19ba086ca39a187640400ba323b3/LIPSTICKS_X10_Square_RGB.jpg', '2025-02-16 20:30:51', '2025-02-23 22:51:24'),
(160, 'Huda Beauty Power Bullet Lipstick', 'Lipstick', 'Bold and creamy lipstick for luxurious lips.', '2499.00', '200.00', 40, 'C006', 'https://images.ctfassets.net/wlke2cbybljx/6Z75K7EQh8g4FfDz4TrtyZ/db8c19ba086ca39a187640400ba323b3/LIPSTICKS_X10_Square_RGB.jpg', '2025-02-16 20:30:51', '2025-02-23 22:51:24'),
(161, 'Calvin Klein One Eau de Toilette', 'Perfume', 'Fresh citrus fragrance for daily wear.', '2999.00', '250.00', 45, 'C006', 'https://www.wildstone.in/cdn/shop/files/Artboard_3_66107c7d-369b-4e40-aa47-ffb22d84d7ee.jpg?v=1721214124', '2025-02-16 20:30:51', '2025-02-23 22:50:03'),
(162, 'Davidoff Cool Water Perfume', 'Perfume', 'Aqua-inspired refreshing fragrance.', '3499.00', '300.00', 35, 'C006', 'https://www.wildstone.in/cdn/shop/files/Artboard_3_66107c7d-369b-4e40-aa47-ffb22d84d7ee.jpg?v=1721214124', '2025-02-16 20:30:51', '2025-02-23 22:50:03'),
(163, 'Gucci Bloom Eau de Parfum', 'Perfume', 'Floral fragrance with jasmine and tuberose.', '5999.00', '500.00', 25, 'C006', 'https://www.wildstone.in/cdn/shop/files/Artboard_3_66107c7d-369b-4e40-aa47-ffb22d84d7ee.jpg?v=1721214124', '2025-02-16 20:30:51', '2025-02-23 22:50:03'),
(164, 'Dior Sauvage Eau de Parfum', 'Perfume', 'Woody and spicy perfume with a bold scent.', '7999.00', '700.00', 20, 'C006', 'https://www.wildstone.in/cdn/shop/files/Artboard_3_66107c7d-369b-4e40-aa47-ffb22d84d7ee.jpg?v=1721214124', '2025-02-16 20:30:51', '2025-02-23 22:50:03'),
(165, 'Philips Hair Dryer HP8100', 'Hair Dryer', 'Compact 1000W hair dryer for quick drying.', '999.00', '100.00', 80, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPpKa3E-yedLy3nIqNwfEo99L4oxgIlZYXaA&s', '2025-02-16 20:30:51', '2025-02-23 22:48:46'),
(166, 'Havells HD3151 Hair Dryer', 'Hair Dryer', 'Salon-quality hair dryer with 3 heat settings.', '1599.00', '150.00', 60, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPpKa3E-yedLy3nIqNwfEo99L4oxgIlZYXaA&s', '2025-02-16 20:30:51', '2025-02-23 22:48:46'),
(167, 'Remington D5000 Compact Hair Dryer', 'Hair Dryer', 'Powerful 1800W hair dryer with ionic technology.', '2499.00', '250.00', 40, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPpKa3E-yedLy3nIqNwfEo99L4oxgIlZYXaA&s', '2025-02-16 20:30:51', '2025-02-23 22:48:46'),
(168, 'Dyson Supersonic Hair Dryer', 'Hair Dryer', 'Premium high-speed hair dryer with heat control.', '29999.00', '2500.00', 15, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPpKa3E-yedLy3nIqNwfEo99L4oxgIlZYXaA&s', '2025-02-16 20:30:51', '2025-02-23 22:48:46'),
(169, 'Nivea Soft Light Moisturizer', 'Moisturizer', 'Lightweight moisturizer with Vitamin E.', '299.00', '30.00', 100, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHZ8ggpe7bXFxMWqn0Pi9YS4q86CRJOudFbQ&s', '2025-02-16 20:30:51', '2025-02-23 22:47:54'),
(170, 'Cetaphil Daily Hydrating Lotion', 'Moisturizer', 'Intense hydration with Hyaluronic Acid.', '799.00', '70.00', 60, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHZ8ggpe7bXFxMWqn0Pi9YS4q86CRJOudFbQ&s', '2025-02-16 20:30:51', '2025-02-23 22:47:54'),
(171, 'Neutrogena Hydro Boost Gel', 'Moisturizer', 'Water-based gel for 72-hour hydration.', '1299.00', '120.00', 50, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHZ8ggpe7bXFxMWqn0Pi9YS4q86CRJOudFbQ&s', '2025-02-16 20:30:51', '2025-02-23 22:47:54'),
(172, 'The Body Shop Vitamin E Cream', 'Moisturizer', 'Rich moisturizer with Vitamin E for all skin types.', '2499.00', '200.00', 40, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHZ8ggpe7bXFxMWqn0Pi9YS4q86CRJOudFbQ&s', '2025-02-16 20:30:51', '2025-02-23 22:47:54'),
(173, 'Gillette Mach3 Shaving Kit', 'Shaving Kit', 'Complete shaving kit with razor, gel, and aftershave.', '1299.00', '100.00', 70, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUH26r1PHWHQo9ujIGlenmdaLhUY4cbrJEMQ&s', '2025-02-16 20:30:51', '2025-02-23 22:46:55');
INSERT INTO `Products` (`pro_id`, `pro_name`, `pro_type`, `description`, `pro_price`, `discount`, `stock_quantity`, `cat_id`, `image_url`, `created_at`, `updated_at`) VALUES
(174, 'Beardo Beard Grooming Kit', 'Shaving Kit', 'Premium kit for beard maintenance and styling.', '1999.00', '200.00', 50, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUH26r1PHWHQo9ujIGlenmdaLhUY4cbrJEMQ&s', '2025-02-16 20:30:51', '2025-02-23 22:46:55'),
(175, 'Philips Multi-Grooming Kit', 'Shaving Kit', 'Electric trimmer with multiple attachments.', '2499.00', '250.00', 40, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUH26r1PHWHQo9ujIGlenmdaLhUY4cbrJEMQ&s', '2025-02-16 20:30:51', '2025-02-23 22:46:55'),
(176, 'Braun Series 7 Electric Shaver', 'Shaving Kit', 'Advanced electric shaver with precision trimming.', '9999.00', '900.00', 20, 'C006', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUH26r1PHWHQo9ujIGlenmdaLhUY4cbrJEMQ&s', '2025-02-16 20:30:51', '2025-02-23 22:46:55'),
(177, 'Lakme True Wear Nail Polish', 'Nail Polish', 'Glossy nail polish with long-lasting formula.', '299.00', '20.00', 100, 'C006', 'https://verymiss.in/cdn/shop/files/304-1_c8173c7a-59b7-45cc-a4fe-294d8be67953.jpg?v=1720627130', '2025-02-16 20:30:51', '2025-02-23 22:45:55'),
(178, 'Maybelline Color Show Nail Paint', 'Nail Polish', 'Vibrant and quick-drying nail polish.', '349.00', '30.00', 90, 'C006', 'https://verymiss.in/cdn/shop/files/304-1_c8173c7a-59b7-45cc-a4fe-294d8be67953.jpg?v=1720627130', '2025-02-16 20:30:51', '2025-02-23 22:45:55'),
(179, 'O.P.I Infinite Shine Nail Polish', 'Nail Polish', 'Gel-like shine with chip-resistant formula.', '999.00', '80.00', 60, 'C006', 'https://verymiss.in/cdn/shop/files/304-1_c8173c7a-59b7-45cc-a4fe-294d8be67953.jpg?v=1720627130', '2025-02-16 20:30:51', '2025-02-23 22:45:55'),
(180, 'Sally Hansen Miracle Gel', 'Nail Polish', 'Salon-quality gel polish without UV light.', '1299.00', '100.00', 50, 'C006', 'https://verymiss.in/cdn/shop/files/304-1_c8173c7a-59b7-45cc-a4fe-294d8be67953.jpg?v=1720627130', '2025-02-16 20:30:51', '2025-02-23 22:45:55'),
(181, 'Monopoly Classic', 'Board Game', 'Classic real estate trading game for family fun.', '1499.00', '200.00', 50, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdfasynHwAqQCZOCvHC6_gvhEiVptPJMYh3Q&s', '2025-02-16 20:33:03', '2025-02-23 22:45:00'),
(182, 'Scrabble Original', 'Board Game', 'Word-building game to challenge vocabulary skills.', '1299.00', '150.00', 60, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdfasynHwAqQCZOCvHC6_gvhEiVptPJMYh3Q&s', '2025-02-16 20:33:03', '2025-02-23 22:45:00'),
(183, 'Catan Board Game', 'Board Game', 'Strategy board game of trading and building.', '3499.00', '500.00', 30, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdfasynHwAqQCZOCvHC6_gvhEiVptPJMYh3Q&s', '2025-02-16 20:33:03', '2025-02-23 22:45:00'),
(184, 'Chess & Checkers Set', 'Board Game', 'Classic 2-in-1 wooden board for chess and checkers.', '999.00', '100.00', 80, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdfasynHwAqQCZOCvHC6_gvhEiVptPJMYh3Q&s', '2025-02-16 20:33:03', '2025-02-23 22:45:00'),
(185, 'Marvel Spider-Man Action Figure', 'Action Figure', '6-inch collectible Spider-Man action figure.', '1999.00', '250.00', 40, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkETgfeyGfLlj2i_CerRTMfeDLTNMVCAEXcA&s', '2025-02-16 20:33:03', '2025-02-23 22:31:39'),
(186, 'Batman Dark Knight Action Figure', 'Action Figure', 'Highly detailed Batman figure with accessories.', '2499.00', '300.00', 35, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkETgfeyGfLlj2i_CerRTMfeDLTNMVCAEXcA&s', '2025-02-16 20:33:03', '2025-02-23 22:31:41'),
(187, 'Transformers Optimus Prime Figure', 'Action Figure', 'Converts from robot to truck in seconds.', '2999.00', '400.00', 25, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkETgfeyGfLlj2i_CerRTMfeDLTNMVCAEXcA&s', '2025-02-16 20:33:03', '2025-02-23 22:31:43'),
(188, 'Dragon Ball Z Goku Action Figure', 'Action Figure', 'Goku figure with multiple articulation points.', '1799.00', '200.00', 50, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkETgfeyGfLlj2i_CerRTMfeDLTNMVCAEXcA&s', '2025-02-16 20:33:03', '2025-02-23 22:31:45'),
(189, 'Rubik’s Cube 3x3', 'Puzzle', 'Classic brain teaser for all ages.', '499.00', '50.00', 100, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQS1DZbShNL2Ds20seOEi_EkVdTTYlOdg2BQ&s', '2025-02-16 20:33:03', '2025-02-23 22:30:32'),
(190, 'Jigsaw Puzzle 1000 Pieces', 'Puzzle', 'Challenging puzzle with scenic artwork.', '999.00', '120.00', 80, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQS1DZbShNL2Ds20seOEi_EkVdTTYlOdg2BQ&s', '2025-02-16 20:33:03', '2025-02-23 22:30:35'),
(191, '3D Wooden Brain Teaser Puzzle', 'Puzzle', 'Intricate wooden puzzle for problem-solving skills.', '1299.00', '150.00', 60, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQS1DZbShNL2Ds20seOEi_EkVdTTYlOdg2BQ&s', '2025-02-16 20:33:03', '2025-02-23 22:30:39'),
(192, 'Sudoku Wooden Board Game', 'Puzzle', 'Classic logic puzzle game for numbers lovers.', '799.00', '100.00', 70, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQS1DZbShNL2Ds20seOEi_EkVdTTYlOdg2BQ&s', '2025-02-16 20:33:03', '2025-02-23 22:30:42'),
(193, 'Hot Wheels 50-Car Gift Pack', 'Toy Car', 'Set of 50 collectible Hot Wheels cars.', '3999.00', '500.00', 30, 'C007', 'https://i.ytimg.com/vi/g4hOiwggYJE/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDsxUMSVm7e6fEgAECk79UXYb3NAA', '2025-02-16 20:33:03', '2025-02-23 22:29:16'),
(194, 'Lamborghini Die-Cast Model Car', 'Toy Car', '1:18 scale realistic Lamborghini toy car.', '2999.00', '300.00', 40, 'C007', 'https://i.ytimg.com/vi/g4hOiwggYJE/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDsxUMSVm7e6fEgAECk79UXYb3NAA', '2025-02-16 20:33:03', '2025-02-23 22:29:19'),
(195, 'Remote Control Monster Truck', 'Toy Car', 'All-terrain RC truck with powerful motor.', '4999.00', '600.00', 25, 'C007', 'https://i.ytimg.com/vi/g4hOiwggYJE/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDsxUMSVm7e6fEgAECk79UXYb3NAA', '2025-02-16 20:33:03', '2025-02-23 22:29:22'),
(196, 'Ferrari F1 Racing Car Model', 'Toy Car', 'Detailed Ferrari F1 racing car model.', '3499.00', '400.00', 35, 'C007', 'https://i.ytimg.com/vi/g4hOiwggYJE/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDsxUMSVm7e6fEgAECk79UXYb3NAA', '2025-02-16 20:33:03', '2025-02-23 22:29:26'),
(197, 'DJI Mini 2 Drone', 'Remote Control Drone', 'Compact 4K camera drone with GPS.', '59999.00', '5000.00', 10, 'C007', 'https://m.media-amazon.com/images/I/81PbZyjMkqL.jpg', '2025-02-16 20:33:03', '2025-02-23 22:27:52'),
(198, 'Syma X5C RC Drone', 'Remote Control Drone', 'Beginner-friendly drone with HD camera.', '6999.00', '700.00', 20, 'C007', 'https://m.media-amazon.com/images/I/81PbZyjMkqL.jpg', '2025-02-16 20:33:03', '2025-02-23 22:27:55'),
(199, 'Holy Stone HS720 Drone', 'Remote Control Drone', 'GPS drone with 4K UHD camera.', '24999.00', '2000.00', 15, 'C007', 'https://m.media-amazon.com/images/I/81PbZyjMkqL.jpg', '2025-02-16 20:33:03', '2025-02-23 22:27:58'),
(200, 'Parrot Anafi FPV Drone', 'Remote Control Drone', 'First-person view drone with 180° camera.', '39999.00', '3000.00', 12, 'C007', 'https://m.media-amazon.com/images/I/81PbZyjMkqL.jpg', '2025-02-16 20:33:03', '2025-02-23 22:28:03'),
(201, 'LEGO Star Wars Millennium Falcon', 'Lego Set', 'Detailed Star Wars spaceship LEGO set.', '14999.00', '1500.00', 20, 'C007', 'https://m.media-amazon.com/images/I/61H6GXNIRXL.jpg', '2025-02-16 20:33:03', '2025-02-23 22:26:28'),
(202, 'LEGO Technic Bugatti Chiron', 'Lego Set', 'Advanced LEGO Technic set of Bugatti Chiron.', '24999.00', '2500.00', 15, 'C007', 'https://m.media-amazon.com/images/I/61H6GXNIRXL.jpg', '2025-02-16 20:33:03', '2025-02-23 22:26:34'),
(203, 'LEGO Harry Potter Hogwarts Castle', 'Lego Set', 'Magical Hogwarts Castle LEGO set.', '29999.00', '3000.00', 12, 'C007', 'https://m.media-amazon.com/images/I/61H6GXNIRXL.jpg', '2025-02-16 20:33:03', '2025-02-23 22:26:36'),
(204, 'LEGO Super Mario Starter Course', 'Lego Set', 'Interactive Super Mario LEGO playset.', '7999.00', '800.00', 30, 'C007', 'https://m.media-amazon.com/images/I/61H6GXNIRXL.jpg', '2025-02-16 20:33:03', '2025-02-23 22:26:39'),
(205, 'Giant Teddy Bear 4 Feet', 'Stuffed Animal', 'Large soft teddy bear for cuddling.', '2499.00', '300.00', 40, 'C007', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flipkart.com%2Fav-toys-4-feet-teddy-bear-pink-color-122-cm%2Fp%2Fitmeuzyewayyz5hz&psig=AOvVaw3MWv0IeZatmz5OaqaOmM1M&ust=1740405133417000&source=images&opi=89978449', '2025-02-16 20:33:03', '2025-02-23 21:54:23'),
(206, 'Disney Mickey Mouse Plush', 'Stuffed Animal', 'Official Disney Mickey Mouse plush toy.', '1499.00', '200.00', 50, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_KNpSSqYkM23Epk3cV2P_RAoyK9DQszX0fQ&s', '2025-02-16 20:33:03', '2025-02-23 21:54:23'),
(207, 'Panda Hugging Plush Toy', 'Stuffed Animal', 'Cute panda plush with soft material.', '1999.00', '250.00', 35, 'C007', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcjs7MVZxCBpwpinWyHJkDMMaK2NN_8ehAzA&s', '2025-02-16 20:33:03', '2025-02-23 21:54:23'),
(208, 'Unicorn Stuffed Toy', 'Stuffed Animal', 'Colorful unicorn plush with sparkles.', '2299.00', '300.00', 30, 'C007', 'https://images-cdn.ubuy.co.in/63412b162686ad658217941b-unicorn-plush-toys-suitable-for-girls.jpg', '2025-02-16 20:33:03', '2025-02-23 21:54:23'),
(209, 'Modern Sofa Set', 'Furniture', 'Stylish and comfortable 3-seater sofa with premium fabric and sturdy wooden frame, perfect for living rooms.', '29999.00', '2000.00', 10, 'C008', 'https://images.jdmagicbox.com/quickquotes/images_main/luxury-modern-sofa-set-2217796384-tmce0if9.jpg', '2025-02-17 00:03:17', '2025-02-17 00:03:17'),
(210, 'Wooden Dining Table', 'Furniture', 'Elegant 6-seater solid wood dining table with polished finish and durable construction for long-lasting use.', '39999.00', '2500.00', 8, 'C008', 'https://cdn.shopify.com/s/files/1/0191/2234/collections/4f8e0651b4aa91f9ecb55b2b0db4958f_cd3f03f7-862a-4d90-b94e-8c6d7efa4a8e.jpg?v=1730463769', '2025-02-17 00:03:17', '2025-02-17 00:03:17'),
(211, 'Ergonomic Office Chair', 'Furniture', 'High-back office chair with lumbar support, breathable mesh, and adjustable height for maximum comfort during work.', '7999.00', '500.00', 15, 'C008', 'https://assets.wfcdn.com/im/64897798/resize-h800-w800%5Ecompr-r85/2720/272028787/Albaugh+Ergonomic+Office+Chair%2C+High+Back+Swivel+Rolling+Executive+Chair%2C+Mid-Century+Faux+Lether+with+Lumbar+Support%2C+Large+Computer+Desk+Task+Chair+with+Suede+Fabric+for+Home.jpg', '2025-02-17 00:03:17', '2025-02-17 00:26:34'),
(212, 'King Size Bed', 'Furniture', 'Luxurious king-size bed with cushioned headboard, sturdy wooden frame, and storage drawers for added convenience.', '49999.00', '3000.00', 5, 'C008', 'https://5.imimg.com/data5/SELLER/Default/2023/2/HP/DD/DM/1408445/king-size-bed.jpeg', '2025-02-17 00:03:17', '2025-02-17 00:03:17'),
(213, 'Bookshelf with Storage', 'Furniture', 'Spacious wooden bookshelf with multiple compartments and a modern design, perfect for organizing books and decor.', '12999.00', '800.00', 12, 'C008', 'https://m.media-amazon.com/images/I/81uqhysikuL.jpg', '2025-02-17 00:03:17', '2025-02-17 00:29:17'),
(214, 'Recliner Chair', 'Furniture', 'Comfortable recliner chair with plush cushioning and adjustable reclining positions, ideal for relaxation and comfort.', '18999.00', '1500.00', 7, 'C008', 'https://images.durian.in/Durian/durian/product/800x800/product_2022100614141665065668_65843.jpg', '2025-02-17 00:03:17', '2025-02-17 00:03:17'),
(215, 'Glass Coffee Table', 'Furniture', 'Elegant glass-top coffee table with a sleek metal frame and minimalist design, perfect for modern living spaces.', '9999.00', '700.00', 20, 'C008', 'https://furniture123.co.uk/Images/AKA006_1_Classic.jpg?v=1', '2025-02-17 00:03:17', '2025-02-17 00:03:17');

-- --------------------------------------------------------

--
-- Table structure for table `Reviews`
--

CREATE TABLE `Reviews` (
  `pro_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `review_text` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Shipping`
--

CREATE TABLE `Shipping` (
  `order_id` bigint(20) DEFAULT NULL,
  `shipping_address` varchar(100) DEFAULT NULL,
  `shipping_method` enum('standard','express','overnight') NOT NULL,
  `shiping_cost` decimal(10,2) NOT NULL,
  `estimate_delivery_date` date DEFAULT NULL,
  `shipping_status` enum('pending','in transit','delivered','returned') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Shipping`
--

INSERT INTO `Shipping` (`order_id`, `shipping_address`, `shipping_method`, `shiping_cost`, `estimate_delivery_date`, `shipping_status`) VALUES
(1, 'Naini Mirzapur Road, , PRAYAGRAJ, Uttar Pradesh - 212207', 'express', '0.00', '2025-03-01', 'pending'),
(2, 'Ssss, Gg, Gg, Gg - 211016', 'express', '0.00', '2025-03-01', 'pending'),
(3, 'Naini Mirzapur Road, , PRAYAGRAJ, Uttar Pradesh - 212207', 'express', '0.00', '2025-03-01', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_id` bigint(20) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_pass` varchar(100) NOT NULL,
  `user_phonenumber` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_id`, `user_name`, `Gender`, `user_email`, `user_pass`, `user_phonenumber`, `created_at`, `updated_at`) VALUES
(1, 'Adarsh Upadhyay', 'Male', 'aadi@gmail.com', '$2y$10$459sxG2ZeGk3V4ODkjwA4.ECVR8B9THR0ihnNben9QAR801yYEdBe', 9532864006, '2025-02-14 16:26:24', '2025-02-14 16:26:24'),
(2, 'Neeraj', 'Male', 'nrox4263@gmail.com', '$2y$10$NcfYDMgx4xTdk12t0oxvMeAZu0vweaSqatoR5xoGpGrgideYFPhPC', 7310452103, '2025-02-24 15:06:49', '2025-02-24 15:06:49');

-- --------------------------------------------------------

--
-- Table structure for table `Wishlist`
--

CREATE TABLE `Wishlist` (
  `user_id` bigint(20) DEFAULT NULL,
  `pro_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Address`
--
ALTER TABLE `Address`
  ADD PRIMARY KEY (`add_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Audit_Logs`
--
ALTER TABLE `Audit_Logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Cart`
--
ALTER TABLE `Cart`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pro_id` (`pro_id`);

--
-- Indexes for table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `Coupons`
--
ALTER TABLE `Coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Order_Item`
--
ALTER TABLE `Order_Item`
  ADD KEY `order_id` (`order_id`),
  ADD KEY `pro_id` (`pro_id`);

--
-- Indexes for table `Payment`
--
ALTER TABLE `Payment`
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`pro_id`),
  ADD KEY `fk_Products_cat_id` (`cat_id`);

--
-- Indexes for table `Reviews`
--
ALTER TABLE `Reviews`
  ADD KEY `pro_id` (`pro_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Shipping`
--
ALTER TABLE `Shipping`
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `Wishlist`
--
ALTER TABLE `Wishlist`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pro_id` (`pro_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Address`
--
ALTER TABLE `Address`
  MODIFY `add_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Audit_Logs`
--
ALTER TABLE `Audit_Logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Coupons`
--
ALTER TABLE `Coupons`
  MODIFY `coupon_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `order_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Products`
--
ALTER TABLE `Products`
  MODIFY `pro_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
