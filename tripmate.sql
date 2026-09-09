-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 09, 2026 at 02:10 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tripmate`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `guests` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('Pending','Confirmed','Cancelled','Completed') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_number` varchar(50) NOT NULL,
  `room_type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `facilities` text DEFAULT NULL,
  `price_per_night` decimal(10,2) NOT NULL,
  `max_guests` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('Available','Unavailable') DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_number`, `room_type`, `description`, `facilities`, `price_per_night`, `max_guests`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, '101', 'Standard', '[\"City View\", \"Bedroom 1 - 1 queen bed\"]', '[\"Wifi\", \"Non-air-conditioned\", \"Mineral Water\"]', 1000.00, 2, '/standard.png', 'Available', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(2, '102', 'Semi-deluxe', '[\"City View\", \"Bedroom 1 - 1 king bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\"]', 1500.00, 2, '/semi_deluxe.png', 'Unavailable', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(3, '103', 'Deluxe', '[\"Pool View\", \"Bedroom 1 - 1 king bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\"]', 2500.00, 3, '/deluxe.png', 'Available', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(4, '104', 'Suite', '[\"Pool View\", \"Bedroom 2 - 1 King bed and 1 queen bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\", \"In-room dining\", \"Iron-board\"]', 5000.00, 4, '/suite.png', 'Available', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(5, '201', 'Standard', '[\"City View\", \"Bedroom 1 - 1 queen bed\"]', '[\"Wifi\", \"Non-air-conditioned\", \"Mineral Water\"]', 1000.00, 2, '/standard.png', 'Available', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(6, '202', 'Semi-deluxe', '[\"City View\", \"Bedroom 1 - 1 king bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\"]', 1500.00, 2, '/semi_deluxe.png', 'Available', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(7, '203', 'Deluxe', '[\"Pool View\", \"Bedroom 1 - 1 king bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\"]', 2500.00, 3, '/deluxe.png', 'Unavailable', '2026-09-09 07:10:28', '2026-09-09 07:43:20'),
(8, '204', 'Suite', '[\"Pool View\", \"Bedroom 2 - 1 King bed and 1 queen bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\", \"In-room dining\", \"Iron-board\"]', 5000.00, 4, '/suite.png', 'Available', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(9, '301', 'Standard', '[\"City View\", \"Bedroom 1 - 1 queen bed\"]', '[\"Wifi\", \"Non-air-conditioned\", \"Mineral Water\"]', 1000.00, 2, '/standard.png', 'Unavailable', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(10, '302', 'Semi-deluxe', '[\"City View\", \"Bedroom 1 - 1 king bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\"]', 1500.00, 2, '/semi_deluxe.png', 'Available', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(11, '303', 'Deluxe', '[\"Pool View\", \"Bedroom 1 - 1 king bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\"]', 2500.00, 3, '/deluxe.png', 'Available', '2026-09-09 07:10:28', '2026-09-09 07:10:28'),
(12, '304', 'Suite', '[\"Pool View\", \"Bedroom 2 - 1 King bed and 1 queen bed\", \"Complimentary Breakfast\"]', '[\"Wifi\", \"Air-conditioned\", \"Mineral Water\", \"Laundary-service\", \"In-room dining\", \"Iron-board\"]', 5000.00, 4, '/suite.png', 'Unavailable', '2026-09-09 07:10:28', '2026-09-09 07:10:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
