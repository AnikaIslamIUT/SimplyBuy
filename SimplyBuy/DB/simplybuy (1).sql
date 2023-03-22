-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2022 at 01:55 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simplybuy`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `product_difference` (`CartProductID` INT) RETURNS INT(11) BEGIN
 DECLARE difference INT;
  Select Quantity-MAX(CartQuantity) into difference FROM product,cart WHERE product.ProductID = cart.CartProductID ;
  RETURN difference;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total` (`CartProductID` INT, `CartQuantity` INT) RETURNS INT(11) BEGIN
 DECLARE total_sum INT;
  Select SUM(Price*CartQuantity)into total_sum FROM product,cart WHERE product.ProductID = cart.CartProductID ;
  RETURN total_sum;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total1` (`CartProductID` INT) RETURNS INT(11) BEGIN
 DECLARE total_sum INT;
  Select SUM(Price)into total_sum FROM product,cart WHERE product.ProductID = cart.CartProductID ;
  RETURN total_sum;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total2` (`UserName` VARCHAR(255)) RETURNS INT(11) BEGIN
 DECLARE total_sum INT;
  Select SUM(Price*CartQuantity)into total_sum FROM product,cart WHERE product.ProductID = cart.CartProductID ;
  RETURN total_sum;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `UserName` varchar(255) NOT NULL,
  `CartProductID` int(11) NOT NULL,
  `CartQuantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`UserName`, `CartProductID`, `CartQuantity`) VALUES
('Moo', 23, 0);

--
-- Triggers `cart`
--
DELIMITER $$
CREATE TRIGGER `CanAddToCart` BEFORE INSERT ON `cart` FOR EACH ROW IF (product_difference(NEW.CartQuantity) >= '0')
              THEN
             SET NEW.CartQuantity = (SELECT MAX(NEW.CartQuantity) FROM cart);
ELSE
 SET NEW.CartQuantity = '0' ;

     END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `UserName` varchar(255) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `OrderQuantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`UserName`, `ProductID`, `OrderQuantity`) VALUES
('ani', 37, 2),
('Israt Sakib', 23, 1),
('Israt Sakib', 27, 1),
('Moo', 22, 0);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `UpdateProduct` AFTER INSERT ON `orders` FOR EACH ROW UPDATE product
SET product.Quantity = product.Quantity - NEW.OrderQuantity
WHERE product.ProductID=NEW.ProductID
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `empty_cart` AFTER INSERT ON `orders` FOR EACH ROW DELETE
FROM
    cart
WHERE
    cart.CartProductID=NEW.ProductID
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ordertable`
--

CREATE TABLE `ordertable` (
  `OrderID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `ShipAddress` varchar(255) NOT NULL,
  `ShipDate` varchar(255) NOT NULL,
  `SumPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ordertable`
--

INSERT INTO `ordertable` (`OrderID`, `CustomerID`, `ShipAddress`, `ShipDate`, `SumPrice`) VALUES
(39, 12, 'Azimpur, Dhaka, Bangladesh', '23-04-2022', 113400),
(40, 13, '123/I am dumb/dhaka -1205', '23-04-2022', 84000),
(41, 13, '123/I am dumb/dhaka -1205', '23-04-2022', 8400),
(42, 13, '123/I am dumb/dhaka -1205', '23-04-2022', 189000),
(43, 13, '123/I am dumb/dhaka -1205', '23-04-2022', 8400),
(44, 13, '123/I am dumb/dhaka -1205', '23-04-2022', 8400),
(45, 13, '123/I am dumb/dhaka -1205', '23-04-2022', 1050),
(46, 14, '123/I am dumb/dhaka -1205', '23-04-2022', 176400),
(47, 14, '123/I am dumb/dhaka -1205', '23-04-2022', 8400),
(48, 14, '123/I am dumb/dhaka -1205', '23-04-2022', 8400),
(49, 14, '123/I am dumb/dhaka -1205', '24-04-2022', 8400),
(50, 15, 'Hello', '24-04-2022', 210),
(51, 15, 'Hello', '24-04-2022', 16800),
(52, 15, 'Hello', '24-04-2022', 8400),
(53, 15, 'Hello', '24-04-2022', 8400),
(64, 15, 'Hello', '24-04-2022', 84000),
(65, 15, 'Hello', '24-04-2022', 8400),
(66, 15, 'Hello', '24-04-2022', 94500),
(67, 15, 'Hello', '24-04-2022', 94500),
(68, 15, 'Hello', '24-04-2022', 84000),
(69, 15, 'Hello', '24-04-2022', 84000),
(70, 15, 'Hello', '24-04-2022', 8400),
(71, 15, 'Hello', '24-04-2022', 8400),
(72, 15, 'Hello', '24-04-2022', 1050),
(73, 15, 'Hello', '24-04-2022', 105),
(74, 15, 'Hello', '24-04-2022', 210),
(75, 15, 'Hello', '24-04-2022', 16800),
(76, 15, 'Hello', '24-04-2022', 3150),
(77, 17, '123/123', '24-04-2022', 8973),
(78, 17, '123/123', '24-04-2022', 8400),
(79, 17, '123/123', '24-04-2022', 189000),
(80, 17, '123/123', '24-04-2022', 0),
(81, 18, 'Moo', '25-04-2022', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `ProductID` int(11) NOT NULL,
  `ProductName` varchar(255) NOT NULL,
  `Category` varchar(255) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Rating` double NOT NULL,
  `RatedCount` int(11) NOT NULL,
  `Price` double NOT NULL,
  `img_dir` varchar(255) NOT NULL,
  `Details` varchar(255) NOT NULL,
  `Time_Added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`ProductID`, `ProductName`, `Category`, `Quantity`, `Rating`, `RatedCount`, `Price`, `img_dir`, `Details`, `Time_Added`) VALUES
(22, 'Microsoft Surface Laptop 3', 'elctronicDevices', 0, 1, 3, 80000, 'https://m.media-amazon.com/images/I/71h6PpGaz9L._AC_SX466_.jpg\r\n', '13.5\" Touch-Screen – Intel Core i5 - 8GB Memory - 128GB Solid State Drive (Latest Model) – Platinum with Alcantara', '2022-04-16 19:15:19'),
(23, 'Sony 65 Inch 4K Ultra HD TV X80K', 'homeApplience', 2, 4, 0, 100000, 'https://images-na.ssl-images-amazon.com/images/I/91KZbi-CbzL.__AC_SY300_SX300_QL70_FMwebp_.jpg', 'LED Smart Google TV with Dolby Vision HDR KD65X80K- 2022 Model', '2022-04-16 19:19:19'),
(24, 'Apple iPhone 12 Pro, 128GB, Pacific Blue', 'elctronicDevices', 2, 4.5, 0, 90000, 'https://www.deccanherald.com/sites/dh/files/articleimages/2020/10/14/apple-iphone-12-pro-series-901598-1602626981.jpg', 'This Renewed Premium product is shipped and sold by Amazon and has been certified by Amazon to work and look like new. With at least 90% battery life, it comes in deluxe, Amazon-branded packaging and is backed by a one-year warranty and technical support.', '2022-04-16 19:21:22'),
(25, 'Beats Studio3 Wireless', 'elctronicDevices', 3, 4.78, 0, 8000, 'https://m.media-amazon.com/images/I/61Xvn9KUgYL._AC_SX522_.jpg', 'Noise Cancelling Over-Ear Headphones - Apple W1 Headphone Chip, Class 1 Bluetooth, 22 Hours of Listening Time, Built-in Microphone - Defiant Black-Red (Latest Model)', '2022-04-16 19:29:26'),
(26, 'Sengled Alexa Light Bulb', 'homeApplience', 25, 4.5, 0, 1000, 'https://m.media-amazon.com/images/I/61akqzq0WyS._AC_SX466_PIbundle-4,TopRight,0,0_SH20_.jpg', 'WiFi Light Bulbs, Smart Light Bulbs, Smart Bulbs that Work with Alexa & Google Assistant, A19 Daylight (5000K) No Hub Required, 800LM 60W Equivalent High CRI>90, 4 Pack', '2022-04-16 19:32:54'),
(27, 'NETGEAR Nighthawk Smart Wi-Fi Router (R7000) ', 'homeApplience', 6, 0, 1, 8000, 'https://m.media-amazon.com/images/I/51-UcKWKOrL._AC_SX679_.jpg', 'AC1900 Wireless Speed (Up to 1900 Mbps) | Up to 1800 Sq Ft Coverage & 30 Devices | 4 x 1G Ethernet and 2 USB ports | Armor Security', '2022-04-16 19:35:38'),
(28, 'WOLVERINE Men\'s Overpass 6\" Composite-Toe Boot', 'fashionClothing', 2, 4, 0, 8000, 'https://m.media-amazon.com/images/I/81adTzFUXlL._AC_UX575_.jpg', 'Flexible, athletic Contour Welt construction moves with you by bending and flexing at essential points', '2022-04-16 19:39:21'),
(29, 'Deia Dresses', 'fashionClothing', 5, 4.5, 2, 3000, 'https://cdn.shopify.com/s/files/1/0950/9820/products/DEIA-DRESS_LYDDEN-GARDEN-11_700x.jpg?v=1646677915', '', '2022-04-16 19:48:10'),
(30, 'Fossil Men\'s Nate Stainless Steel Quartz Chronograph Watch', 'fashionClothing', 10, 4, 0, 5000, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1s8wWL1s-gD-Q2VBG1U9LCkIDgPTGVo3rdQ&usqp=CAU', 'Fossil has always been inspired by American creativity and ingenuity. Since 1984, we’ve strived to bring new life into the industry by making quality, fashionable watches and accessories that were both fun and accessible.', '2022-04-16 19:55:26'),
(31, 'Band-Aid Brand Sterile Flexible Fabric Adhesive Bandages', 'healthCare', 100, 5, 0, 200, 'https://m.media-amazon.com/images/I/814wuzoB-7L._AC_SX679_.jpg', 'Comfortable Flexible Protection & Wound Care for Minor Cuts & Scrapes, Pad Designed to Cushion Painful Wounds, One Size, 100 ct', '2022-04-16 19:59:04'),
(32, 'DAKOTT Ferrari No. 5 Limited Edition Soccer Ball', 'sports', 5, 4.6, 0, 15000, 'https://m.media-amazon.com/images/I/51gbZrQBMiL._AC_.jpg', 'Ferrari Official Soccer Ball,Size 5 Training Ball for Girls,Boys,Youth Teenagers,Adults,Machine Stitched for Indoor Outdoor Play\r\n', '2022-04-16 20:03:50'),
(33, 'Mew', '3', 10, 0, 0, 150, 'Web/Cat03.jpg', '150 takar biral', '2022-04-17 22:35:58'),
(35, 'dog', '2', 10, 0, 0, 123, 'Web/doggy-date-night.jpg', 'snbshxsj', '2022-04-17 22:46:56'),
(37, 'Ice cream', '5', 8, 0, 0, 150, 'Web/ice-cream-day.jpg', 'Yummy Yummy Ice cream', '2022-04-17 22:48:41'),
(39, 'Flower', '3', 12, 0, 0, 420, 'Web/download (1).jfif', 'Good Flower', '2022-04-18 02:45:59'),
(41, 'MewTwo', 'HomeAppliance', 12, 2, 2, 200, '', 'mnxzjkxnzjm', '2022-04-18 01:22:45');

--
-- Triggers `product`
--
DELIMITER $$
CREATE TRIGGER `IDIncrement` BEFORE INSERT ON `product` FOR EACH ROW SET NEW.ProductID = (SELECT MAX(ProductID) + 2 FROM product)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`UserName`,`CartProductID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`UserName`,`ProductID`);

--
-- Indexes for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD PRIMARY KEY (`OrderID`,`CustomerID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ProductID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ordertable`
--
ALTER TABLE `ordertable`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
