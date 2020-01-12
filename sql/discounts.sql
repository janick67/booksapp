-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 08 Sty 2020, 18:04
-- Wersja serwera: 10.1.38-MariaDB
-- Wersja PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `booksapp`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `address`
--

CREATE TABLE `address` (
  `ad_ID` int(11) NOT NULL,
  `ad_name` varchar(254) NOT NULL,
  `ad_address1` varchar(254) NOT NULL,
  `ad_address2` varchar(254) DEFAULT NULL,
  `ad_city` varchar(254) NOT NULL,
  `ad_postalCode` varchar(10) NOT NULL,
  `ad_creatorID` int(11) DEFAULT NULL,
  `ad_creatorTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ad_modTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ad_modID` int(11) DEFAULT NULL,
  `ad_isArchival` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `address`
--

INSERT INTO `address` (`ad_ID`, `ad_name`, `ad_address1`, `ad_address2`, `ad_city`, `ad_postalCode`, `ad_creatorID`, `ad_creatorTS`, `ad_modTS`, `ad_modID`, `ad_isArchival`) VALUES
(6, 'Sekretariat', 'Blachotrapez ul. Kilińskiego 49a', NULL, 'Rabka-Zdrój', '34-700', NULL, '2019-12-22 11:29:50', '2019-12-22 11:29:50', NULL, 0),
(7, 'Sękocin', 'Blachotrapez Sękocin Stary 4', NULL, 'Sękocin stary', '52-410', NULL, '2019-12-22 11:33:44', '2019-12-22 11:33:44', NULL, 0),
(8, 'Centrala', 'PZPN ul.wiejska 25', NULL, 'Warszawa', '35-250', NULL, '2019-12-22 12:41:26', '2019-12-22 12:41:26', NULL, 0),
(10, 'Magazyn ZABO', 'Booksapp ul. Kilińskiego 40', NULL, 'Rabka-Zdrój', '34-700', NULL, '2019-12-27 12:01:39', '2019-12-27 12:01:39', NULL, 0),
(11, 'Magazyn Centrala', 'Booksapp ul.Tatrzańska 92', NULL, 'Warszawa', '83-214', NULL, '2019-12-27 12:05:45', '2019-12-27 12:05:45', NULL, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `books`
--

CREATE TABLE `books` (
  `bo_ID` int(11) NOT NULL,
  `bo_title` text NOT NULL,
  `bo_printHouse` varchar(11) NOT NULL,
  `bo_ISBN` int(13) NOT NULL,
  `bo_printDate` date NOT NULL,
  `bo_category` text NOT NULL,
  `bo_description` text NOT NULL,
  `bo_author` text NOT NULL,
  `bo_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `books`
--

INSERT INTO `books` (`bo_ID`, `bo_title`, `bo_printHouse`, `bo_ISBN`, `bo_printDate`, `bo_category`, `bo_description`, `bo_author`, `bo_price`) VALUES
(1, 'Harry', 'DKA', 13678985, '2019-12-08', 'Fantastyka', 'o takim czarodzieju', 'JK', 13),
(2, 'Krzyżacy', 'KLA', 678975645, '2019-12-16', 'Historyczna', 'o takich najazdach', 'Sienkiewicz', 66),
(3, 'Mitologia', 'Gre', 4567887, '2019-12-01', 'Historyczna', 'O bogach i nie tylko', 'anonim', 67);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `customeraddress`
--

CREATE TABLE `customeraddress` (
  `ca_customerID` int(11) NOT NULL,
  `ca_addressID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `customeraddress`
--

INSERT INTO `customeraddress` (`ca_customerID`, `ca_addressID`) VALUES
(3, 8),
(5, 6),
(5, 7);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `customers`
--

CREATE TABLE `customers` (
  `cu_ID` int(11) NOT NULL,
  `cu_company` varchar(50) NOT NULL,
  `cu_NIP` int(10) NOT NULL,
  `cu_firstName` varchar(50) NOT NULL,
  `cu_lastName` varchar(50) NOT NULL,
  `cu_email` varchar(50) NOT NULL,
  `cu_creatorID` int(11) NOT NULL,
  `cu_creatorTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cu_modTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cu_modID` int(11) DEFAULT NULL,
  `cu_isArchival` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `customers`
--

INSERT INTO `customers` (`cu_ID`, `cu_company`, `cu_NIP`, `cu_firstName`, `cu_lastName`, `cu_email`, `cu_creatorID`, `cu_creatorTS`, `cu_modTS`, `cu_modID`, `cu_isArchival`) VALUES
(3, 'PZPN', 4353883, 'Polski Związek', 'Piłki Nożnej', 'pzpn@pzpn.pl', 1, '2019-12-19 17:20:54', '2019-12-19 17:20:54', NULL, 0),
(5, 'Blachotrapez', 161625879, '', '', 'bt@blachotrapez.com.pl', 1, '2019-12-19 17:22:14', '2019-12-19 17:22:14', NULL, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `deliveries`
--

CREATE TABLE `deliveries` (
  `de_ID` int(11) NOT NULL,
  `de_deliveryDate` date NOT NULL,
  `de_status` text NOT NULL,
  `de_destWarehouseID` int(11) NOT NULL,
  `de_sourceCompany` text NOT NULL,
  `de_comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `delivery_books`
--

CREATE TABLE `delivery_books` (
  `db_ID` int(11) NOT NULL,
  `db_deliveryID` int(11) NOT NULL,
  `db_bookID` int(11) NOT NULL,
  `db_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `discounts`
--

CREATE TABLE `discounts` (
  `di_ID` int(11) NOT NULL,
  `di_value` int(11) NOT NULL,
  `di_name` text NOT NULL,
  `di_confirmDate` date NOT NULL,
  `di_endDate` date NOT NULL,
  `di_creatorID` int(11) NOT NULL,
  `di_createTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `di_modTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `di_modID` int(11) NOT NULL,
  `di_isArchival` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `discounts`
--

INSERT INTO `discounts` (`di_ID`, `di_value`, `di_name`, `di_confirmDate`, `di_endDate`, `di_creatorID`, `di_createTS`, `di_modTS`, `di_modID`, `di_isArchival`) VALUES
(1, 5, 'Podstawowy +5%', '2020-01-07', '2020-01-31', 0, '2020-01-07 14:04:22', '2020-01-07 14:04:22', 0, 0),
(2, 10, 'Podstawowy +10%', '2020-01-06', '2020-01-31', 0, '2020-01-07 14:05:59', '2020-01-07 14:05:59', 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `discount_customer`
--

CREATE TABLE `discount_customer` (
  `dc_ID` int(11) NOT NULL,
  `dc_discountID` int(11) NOT NULL,
  `dc_customerID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `discount_customer`
--

INSERT INTO `discount_customer` (`dc_ID`, `dc_discountID`, `dc_customerID`) VALUES
(1, 1, 3),
(2, 2, 5);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `discount_elements`
--

CREATE TABLE `discount_elements` (
  `del_ID` int(11) NOT NULL,
  `del_discountID` int(11) NOT NULL,
  `del_bookID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `discount_elements`
--

INSERT INTO `discount_elements` (`del_ID`, `del_discountID`, `del_bookID`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `news`
--

CREATE TABLE `news` (
  `ne_ID` int(11) NOT NULL,
  `ne_content` text NOT NULL,
  `ne_creatorID` int(11) NOT NULL,
  `ce_createTS` date NOT NULL,
  `ne_modTS` date NOT NULL,
  `ne_modID` int(11) NOT NULL,
  `ne_address` text NOT NULL,
  `ne_isarchival` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `or_ID` int(11) NOT NULL,
  `or_customerID` int(11) DEFAULT NULL,
  `or_sourceWarehouseID` int(11) NOT NULL,
  `or_targetWarehouseID` int(11) DEFAULT NULL,
  `or_status` int(2) NOT NULL COMMENT '0 - nie zapisane, 1 - zapisane, 2 - w realizacji, 3 - wysałane, 4 - zrealizowane, 5 - anulowane',
  `or_addressID` int(11) NOT NULL,
  `or_shipmentID` int(11) DEFAULT NULL,
  `or_storeID` int(11) NOT NULL,
  `or_creatorID` int(11) NOT NULL,
  `or_createTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `or_modTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `or_modID` int(11) NOT NULL,
  `or_comment` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `orders`
--

INSERT INTO `orders` (`or_ID`, `or_customerID`, `or_sourceWarehouseID`, `or_targetWarehouseID`, `or_status`, `or_addressID`, `or_shipmentID`, `or_storeID`, `or_creatorID`, `or_createTS`, `or_modTS`, `or_modID`, `or_comment`) VALUES
(1, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 11:45:03', '2020-01-05 11:45:03', 0, 0),
(2, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 11:45:05', '2020-01-05 11:45:05', 0, 0),
(3, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 11:48:49', '2020-01-05 11:48:49', 0, 0),
(4, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 11:55:03', '2020-01-05 11:55:03', 0, 0),
(5, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 11:55:36', '2020-01-05 11:55:36', 0, 0),
(6, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 11:56:01', '2020-01-05 11:56:01', 0, 0),
(7, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 11:58:09', '2020-01-05 11:58:09', 0, 0),
(8, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:00:25', '2020-01-05 12:00:25', 0, 0),
(9, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:25', '2020-01-05 12:02:25', 0, 0),
(10, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', 0, 0),
(11, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', 0, 0),
(12, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', 0, 0),
(13, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', 0, 0),
(14, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', 0, 0),
(15, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', 0, 0),
(16, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', 0, 0),
(17, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', 0, 0),
(18, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(19, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(20, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(21, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(22, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(23, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(24, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(25, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(26, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', 0, 0),
(27, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:09:43', '2020-01-05 12:09:43', 0, 0),
(28, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-05 12:10:29', '2020-01-05 12:10:29', 0, 0),
(29, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:03:56', '2020-01-07 09:03:56', 0, 0),
(30, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:05', '2020-01-07 09:04:05', 0, 0),
(31, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:05', '2020-01-07 09:04:05', 0, 0),
(32, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', 0, 0),
(33, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', 0, 0),
(34, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', 0, 0),
(35, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', 0, 0),
(36, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', 0, 0),
(37, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', 0, 0),
(38, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', 0, 0),
(39, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', 0, 0),
(40, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', 0, 0),
(41, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:12:35', '2020-01-07 09:12:35', 0, 0),
(42, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:12:37', '2020-01-07 09:12:37', 0, 0),
(43, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', 0, 0),
(44, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', 0, 0),
(45, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', 0, 0),
(46, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', 0, 0),
(47, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:10', '2020-01-07 09:13:10', 0, 0),
(48, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', 0, 0),
(49, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', 0, 0),
(50, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', 0, 0),
(51, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', 0, 0),
(52, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', 0, 0),
(53, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:26', '2020-01-07 09:13:26', 0, 0),
(54, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:26', '2020-01-07 09:13:26', 0, 0),
(55, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:26', '2020-01-07 09:13:26', 0, 0),
(56, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:26', '2020-01-07 09:13:26', 0, 0),
(57, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:26', '2020-01-07 09:13:26', 0, 0),
(58, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:26', '2020-01-07 09:13:26', 0, 0),
(59, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:59', '2020-01-07 09:13:59', 0, 0),
(60, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:59', '2020-01-07 09:13:59', 0, 0),
(61, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:59', '2020-01-07 09:13:59', 0, 0),
(62, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:59', '2020-01-07 09:13:59', 0, 0),
(63, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:13:59', '2020-01-07 09:13:59', 0, 0),
(64, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', 0, 0),
(65, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:14:18', '2020-01-07 09:14:18', 0, 0),
(66, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', 0, 0),
(67, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', 0, 0),
(68, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', 0, 0),
(69, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', 0, 0),
(70, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', 0, 0),
(71, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:15:45', '2020-01-07 09:15:45', 0, 0),
(72, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:17:23', '2020-01-07 09:17:23', 0, 0),
(73, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:23:26', '2020-01-07 09:23:26', 0, 0),
(74, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:24:03', '2020-01-07 09:24:03', 0, 0),
(75, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 09:24:42', '2020-01-07 09:24:42', 0, 0),
(76, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 10:50:13', '2020-01-07 10:50:13', 0, 0),
(77, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 10:50:44', '2020-01-07 10:50:44', 0, 0),
(78, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 10:52:44', '2020-01-07 10:52:44', 0, 0),
(79, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 14:52:47', '2020-01-07 14:52:47', 0, 0),
(80, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 14:53:16', '2020-01-07 14:53:16', 0, 0),
(81, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 14:53:55', '2020-01-07 14:53:55', 0, 0),
(82, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 15:48:56', '2020-01-07 15:48:56', 0, 0),
(83, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 15:51:18', '2020-01-07 15:51:18', 0, 0),
(84, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-07 15:51:45', '2020-01-07 15:51:45', 0, 0),
(85, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:10:09', '2020-01-08 12:10:09', 0, 0),
(86, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:11:50', '2020-01-08 12:11:50', 0, 0),
(87, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:12:19', '2020-01-08 12:12:19', 0, 0),
(88, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:12:47', '2020-01-08 12:12:47', 0, 0),
(89, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:13:02', '2020-01-08 12:13:02', 0, 0),
(90, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:14:08', '2020-01-08 12:14:08', 0, 0),
(91, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:15:21', '2020-01-08 12:15:21', 0, 0),
(92, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:15:57', '2020-01-08 12:15:57', 0, 0),
(93, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:16:48', '2020-01-08 12:16:48', 0, 0),
(94, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:16:51', '2020-01-08 12:16:51', 0, 0),
(95, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 12:17:42', '2020-01-08 12:17:42', 0, 0),
(96, 5, 1, NULL, 0, 7, NULL, 1, 0, '2020-01-08 13:59:14', '2020-01-08 13:59:14', 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `order_books`
--

CREATE TABLE `order_books` (
  `ob_ID` int(11) NOT NULL,
  `ob_orderID` int(11) NOT NULL,
  `ob_bookID` int(11) NOT NULL,
  `ob_count` int(11) NOT NULL,
  `ob_manualDiscount` int(11) NOT NULL DEFAULT '0',
  `ob_createTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ob_modTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ob_comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `order_books`
--

INSERT INTO `order_books` (`ob_ID`, `ob_orderID`, `ob_bookID`, `ob_count`, `ob_manualDiscount`, `ob_createTS`, `ob_modTS`, `ob_comment`) VALUES
(1, 6, 2, 1, 0, '2020-01-05 11:56:01', '2020-01-05 11:56:01', ''),
(2, 6, 3, 1, 0, '2020-01-05 11:56:01', '2020-01-05 11:56:01', ''),
(3, 7, 2, 1, 0, '2020-01-05 11:58:09', '2020-01-05 11:58:09', ''),
(4, 7, 3, 1, 0, '2020-01-05 11:58:09', '2020-01-05 11:58:09', ''),
(5, 8, 2, 1, 0, '2020-01-05 12:00:25', '2020-01-05 12:00:25', ''),
(6, 8, 3, 1, 0, '2020-01-05 12:00:25', '2020-01-05 12:00:25', ''),
(7, 9, 2, 1, 0, '2020-01-05 12:02:25', '2020-01-05 12:02:25', ''),
(8, 9, 3, 1, 0, '2020-01-05 12:02:25', '2020-01-05 12:02:25', ''),
(9, 10, 2, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(10, 10, 3, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(11, 11, 2, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(12, 11, 3, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(13, 12, 2, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(14, 12, 3, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(15, 13, 2, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(16, 13, 3, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(17, 14, 2, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(18, 14, 3, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(19, 15, 2, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(20, 15, 3, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(21, 16, 2, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(22, 16, 3, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(23, 17, 2, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(24, 17, 3, 1, 0, '2020-01-05 12:02:35', '2020-01-05 12:02:35', ''),
(25, 18, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(26, 18, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(27, 19, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(28, 19, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(29, 20, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(30, 20, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(31, 21, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(32, 21, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(33, 22, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(34, 22, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(35, 23, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(36, 23, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(37, 24, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(38, 24, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(39, 25, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(40, 25, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(41, 26, 2, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(42, 26, 3, 1, 0, '2020-01-05 12:02:36', '2020-01-05 12:02:36', ''),
(43, 27, 2, 1, 0, '2020-01-05 12:09:43', '2020-01-05 12:09:43', ''),
(44, 27, 3, 1, 0, '2020-01-05 12:09:43', '2020-01-05 12:09:43', ''),
(45, 28, 2, 1, 0, '2020-01-05 12:10:29', '2020-01-05 12:10:29', ''),
(46, 28, 3, 1, 0, '2020-01-05 12:10:29', '2020-01-05 12:10:29', ''),
(47, 29, 1, 2, 0, '2020-01-07 09:03:56', '2020-01-07 09:03:56', ''),
(48, 29, 2, 3, 0, '2020-01-07 09:03:56', '2020-01-07 09:03:56', ''),
(49, 30, 1, 2, 0, '2020-01-07 09:04:05', '2020-01-07 09:04:05', ''),
(50, 30, 2, 3, 0, '2020-01-07 09:04:05', '2020-01-07 09:04:05', ''),
(51, 31, 1, 2, 0, '2020-01-07 09:04:05', '2020-01-07 09:04:05', ''),
(52, 31, 2, 3, 0, '2020-01-07 09:04:05', '2020-01-07 09:04:05', ''),
(53, 32, 1, 2, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', ''),
(54, 32, 2, 3, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', ''),
(55, 33, 1, 2, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', ''),
(56, 33, 2, 3, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', ''),
(57, 34, 1, 2, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', ''),
(58, 34, 2, 3, 0, '2020-01-07 09:04:06', '2020-01-07 09:04:06', ''),
(59, 35, 1, 2, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(60, 35, 2, 3, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(61, 36, 1, 2, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(62, 36, 2, 3, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(63, 37, 1, 2, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(64, 37, 2, 3, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(65, 38, 1, 2, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(66, 38, 2, 3, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(67, 39, 1, 2, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(68, 39, 2, 3, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(69, 40, 1, 2, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(70, 40, 2, 3, 0, '2020-01-07 09:04:34', '2020-01-07 09:04:34', ''),
(71, 41, 1, 2, 0, '2020-01-07 09:12:35', '2020-01-07 09:12:35', ''),
(72, 41, 2, 3, 0, '2020-01-07 09:12:35', '2020-01-07 09:12:35', ''),
(73, 42, 1, 2, 0, '2020-01-07 09:12:37', '2020-01-07 09:12:37', ''),
(74, 42, 2, 3, 0, '2020-01-07 09:12:37', '2020-01-07 09:12:37', ''),
(75, 43, 1, 2, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', ''),
(76, 43, 2, 3, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', ''),
(77, 44, 1, 2, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', ''),
(78, 44, 2, 3, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', ''),
(79, 45, 1, 2, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', ''),
(80, 45, 2, 3, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', ''),
(81, 46, 1, 2, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', ''),
(82, 46, 2, 3, 0, '2020-01-07 09:12:38', '2020-01-07 09:12:38', ''),
(83, 47, 1, 2, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(84, 47, 2, 3, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(85, 48, 1, 2, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(86, 48, 2, 3, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(87, 49, 1, 2, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(88, 49, 2, 3, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(89, 50, 1, 2, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(90, 50, 2, 3, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(91, 51, 1, 2, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(92, 51, 2, 3, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(93, 52, 1, 2, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(94, 52, 2, 3, 0, '2020-01-07 09:13:11', '2020-01-07 09:13:11', ''),
(95, 53, 1, 2, 0, '2020-01-07 09:13:26', '2020-01-07 09:13:26', ''),
(96, 53, 2, 3, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(97, 54, 1, 2, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(98, 54, 2, 3, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(99, 55, 1, 2, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(100, 55, 2, 3, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(101, 56, 1, 2, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(102, 56, 2, 3, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(103, 57, 1, 2, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(104, 57, 2, 3, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(105, 58, 1, 2, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(106, 58, 2, 3, 0, '2020-01-07 09:13:27', '2020-01-07 09:13:27', ''),
(107, 59, 1, 2, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(108, 59, 2, 3, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(109, 60, 1, 2, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(110, 60, 2, 3, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(111, 61, 1, 2, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(112, 61, 2, 3, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(113, 62, 1, 2, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(114, 62, 2, 3, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(115, 63, 1, 2, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(116, 63, 2, 3, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(117, 64, 1, 2, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(118, 64, 2, 3, 0, '2020-01-07 09:14:00', '2020-01-07 09:14:00', ''),
(119, 65, 1, 2, 0, '2020-01-07 09:14:18', '2020-01-07 09:14:18', ''),
(120, 65, 2, 3, 0, '2020-01-07 09:14:18', '2020-01-07 09:14:18', ''),
(121, 66, 1, 2, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(122, 66, 2, 3, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(123, 67, 1, 2, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(124, 67, 2, 3, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(125, 68, 1, 2, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(126, 68, 2, 3, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(127, 69, 1, 2, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(128, 69, 2, 3, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(129, 70, 1, 2, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(130, 70, 2, 3, 0, '2020-01-07 09:14:19', '2020-01-07 09:14:19', ''),
(131, 71, 1, 2, 0, '2020-01-07 09:15:45', '2020-01-07 09:15:45', ''),
(132, 71, 2, 3, 0, '2020-01-07 09:15:45', '2020-01-07 09:15:45', ''),
(133, 72, 1, 2, 0, '2020-01-07 09:17:23', '2020-01-07 09:17:23', ''),
(134, 72, 2, 3, 0, '2020-01-07 09:17:23', '2020-01-07 09:17:23', ''),
(135, 73, 1, 2, 0, '2020-01-07 09:23:26', '2020-01-07 09:23:26', ''),
(136, 73, 2, 3, 0, '2020-01-07 09:23:26', '2020-01-07 09:23:26', ''),
(137, 74, 1, 2, 0, '2020-01-07 09:24:03', '2020-01-07 09:24:03', ''),
(138, 74, 2, 3, 0, '2020-01-07 09:24:03', '2020-01-07 09:24:03', ''),
(139, 75, 1, 2, 0, '2020-01-07 09:24:42', '2020-01-07 09:24:42', ''),
(140, 75, 2, 3, 0, '2020-01-07 09:24:42', '2020-01-07 09:24:42', ''),
(141, 76, 1, 2, 0, '2020-01-07 10:50:13', '2020-01-07 10:50:13', ''),
(142, 76, 2, 3, 0, '2020-01-07 10:50:13', '2020-01-07 10:50:13', ''),
(143, 77, 1, 2, 0, '2020-01-07 10:50:44', '2020-01-07 10:50:44', ''),
(144, 77, 2, 3, 0, '2020-01-07 10:50:44', '2020-01-07 10:50:44', ''),
(145, 78, 1, 2, 0, '2020-01-07 10:52:44', '2020-01-07 10:52:44', ''),
(146, 78, 2, 3, 0, '2020-01-07 10:52:44', '2020-01-07 10:52:44', ''),
(147, 79, 1, 2, 0, '2020-01-07 14:52:47', '2020-01-07 14:52:47', ''),
(148, 79, 2, 3, 0, '2020-01-07 14:52:47', '2020-01-07 14:52:47', ''),
(149, 80, 1, 2, 0, '2020-01-07 14:53:16', '2020-01-07 14:53:16', ''),
(150, 80, 2, 3, 0, '2020-01-07 14:53:16', '2020-01-07 14:53:16', ''),
(151, 81, 1, 2, 0, '2020-01-07 14:53:55', '2020-01-07 14:53:55', ''),
(152, 81, 2, 3, 0, '2020-01-07 14:53:55', '2020-01-07 14:53:55', ''),
(153, 86, 1, 1, 0, '2020-01-08 12:11:50', '2020-01-08 12:11:50', ''),
(154, 86, 2, 1, 0, '2020-01-08 12:11:50', '2020-01-08 12:11:50', ''),
(155, 87, 1, 1, 0, '2020-01-08 12:12:19', '2020-01-08 12:12:19', ''),
(156, 87, 2, 1, 0, '2020-01-08 12:12:19', '2020-01-08 12:12:19', ''),
(157, 88, 1, 1, 0, '2020-01-08 12:12:47', '2020-01-08 12:12:47', ''),
(158, 88, 2, 1, 0, '2020-01-08 12:12:47', '2020-01-08 12:12:47', ''),
(159, 89, 1, 1, 0, '2020-01-08 12:13:02', '2020-01-08 12:13:02', ''),
(160, 89, 2, 1, 0, '2020-01-08 12:13:02', '2020-01-08 12:13:02', ''),
(161, 90, 1, 1, 0, '2020-01-08 12:14:08', '2020-01-08 12:14:08', ''),
(162, 90, 2, 1, 0, '2020-01-08 12:14:08', '2020-01-08 12:14:08', ''),
(163, 91, 1, 1, 0, '2020-01-08 12:15:21', '2020-01-08 12:15:21', ''),
(164, 91, 2, 1, 0, '2020-01-08 12:15:21', '2020-01-08 12:15:21', ''),
(165, 92, 1, 1, 0, '2020-01-08 12:15:57', '2020-01-08 12:15:57', ''),
(166, 92, 2, 1, 0, '2020-01-08 12:15:57', '2020-01-08 12:15:57', ''),
(167, 93, 1, 1, 0, '2020-01-08 12:16:48', '2020-01-08 12:16:48', ''),
(168, 93, 2, 1, 0, '2020-01-08 12:16:48', '2020-01-08 12:16:48', ''),
(169, 94, 1, 1, 0, '2020-01-08 12:16:51', '2020-01-08 12:16:51', ''),
(170, 94, 2, 1, 0, '2020-01-08 12:16:51', '2020-01-08 12:16:51', ''),
(171, 95, 1, 1, 0, '2020-01-08 12:17:42', '2020-01-08 12:17:42', ''),
(172, 95, 2, 1, 0, '2020-01-08 12:17:42', '2020-01-08 12:17:42', ''),
(173, 96, 1, 1, 0, '2020-01-08 13:59:14', '2020-01-08 13:59:14', ''),
(174, 96, 2, 1, 0, '2020-01-08 13:59:14', '2020-01-08 13:59:14', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `order_book_discounts`
--

CREATE TABLE `order_book_discounts` (
  `od_id` int(11) NOT NULL,
  `od_orderBookID` int(11) NOT NULL,
  `od_discountElementID` int(11) NOT NULL,
  `od_value` int(11) NOT NULL,
  `od_comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `roles`
--

CREATE TABLE `roles` (
  `ro_ID` int(11) NOT NULL,
  `ro_name` text NOT NULL,
  `ro_creatorID` int(11) NOT NULL,
  `ro_createTS` date NOT NULL,
  `ro_modTS` date NOT NULL,
  `ro_modID` int(11) NOT NULL,
  `ro_isArchival` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('3b71df3c-e5f1-4e9c-8bf9-ed477ca469cd', 1578513526, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `shipments`
--

CREATE TABLE `shipments` (
  `si_ID` int(11) NOT NULL,
  `si_type` text NOT NULL,
  `si_numer` int(11) NOT NULL,
  `si_status` text NOT NULL,
  `si_creatorID` int(11) NOT NULL,
  `si_createTS` date NOT NULL,
  `si_modTS` date NOT NULL,
  `si_comment` text NOT NULL,
  `si_modID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `status_history`
--

CREATE TABLE `status_history` (
  `sh_ID` int(11) NOT NULL,
  `sh_elementType` text NOT NULL,
  `sh_elementID` int(11) NOT NULL,
  `sh_oldStatus` text NOT NULL,
  `sh_newStatus` text NOT NULL,
  `sh_date` date NOT NULL,
  `sh_newStatusUserID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `store`
--

CREATE TABLE `store` (
  `st_ID` int(11) NOT NULL,
  `st_name` varchar(50) NOT NULL,
  `st_shortName` varchar(50) NOT NULL,
  `st_addressID` int(11) NOT NULL,
  `st_warehouseID` int(11) NOT NULL,
  `st_creatorID` int(11) NOT NULL,
  `st_createTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `st_modTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `st_modID` int(11) NOT NULL,
  `st_isArchival` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `store`
--

INSERT INTO `store` (`st_ID`, `st_name`, `st_shortName`, `st_addressID`, `st_warehouseID`, `st_creatorID`, `st_createTS`, `st_modTS`, `st_modID`, `st_isArchival`) VALUES
(1, 'Zabornia', 'ZABO', 10, 1, 0, '2019-12-27 12:09:17', '2019-12-27 12:09:17', 0, 0),
(2, 'Centrala', 'CENT', 11, 2, 0, '2019-12-27 12:10:29', '2019-12-27 12:10:29', 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `us_ID` int(11) NOT NULL,
  `us_login` text NOT NULL,
  `us_email` text NOT NULL,
  `us_password` text NOT NULL,
  `us_roleID` int(11) NOT NULL,
  `us_storID` int(11) NOT NULL,
  `us_creatorID` int(11) NOT NULL,
  `us_creatorTS` date NOT NULL,
  `us_modTS` date NOT NULL,
  `us_modID` int(11) NOT NULL,
  `us_isArchival` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `warehouses`
--

CREATE TABLE `warehouses` (
  `wa_ID` int(11) NOT NULL,
  `wa_code` varchar(10) NOT NULL,
  `wa_addressID` int(11) NOT NULL,
  `wa_creatorID` int(11) NOT NULL,
  `wa_creatorTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `wa_modTS` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `wa_modID` int(11) NOT NULL,
  `wa_isArchival` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `warehouses`
--

INSERT INTO `warehouses` (`wa_ID`, `wa_code`, `wa_addressID`, `wa_creatorID`, `wa_creatorTS`, `wa_modTS`, `wa_modID`, `wa_isArchival`) VALUES
(1, 'ZABO', 10, 0, '2019-12-27 12:02:03', '2019-12-27 12:02:03', 0, 0),
(2, 'CENT', 11, 0, '2019-12-27 12:06:46', '2019-12-27 12:06:46', 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `warehouse_books`
--

CREATE TABLE `warehouse_books` (
  `wb_ID` int(11) NOT NULL,
  `wb_bookID` int(11) NOT NULL,
  `wb_count` int(11) NOT NULL,
  `wb_warehouseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`ad_ID`),
  ADD KEY `ad_creatorID` (`ad_creatorID`),
  ADD KEY `ad_modID` (`ad_modID`);

--
-- Indeksy dla tabeli `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`bo_ID`);

--
-- Indeksy dla tabeli `customeraddress`
--
ALTER TABLE `customeraddress`
  ADD UNIQUE KEY `ca_customerID` (`ca_customerID`,`ca_addressID`);

--
-- Indeksy dla tabeli `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`cu_ID`),
  ADD KEY `cu_creatorID` (`cu_creatorID`),
  ADD KEY `cu_modID` (`cu_modID`);

--
-- Indeksy dla tabeli `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`de_ID`),
  ADD KEY `de_destWarehouseID` (`de_destWarehouseID`);

--
-- Indeksy dla tabeli `delivery_books`
--
ALTER TABLE `delivery_books`
  ADD PRIMARY KEY (`db_ID`),
  ADD KEY `db_bookID` (`db_bookID`),
  ADD KEY `db_deliveryID` (`db_deliveryID`),
  ADD KEY `db_deliveryID_2` (`db_deliveryID`);

--
-- Indeksy dla tabeli `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`di_ID`),
  ADD KEY `di_creatorID` (`di_creatorID`),
  ADD KEY `di_modID` (`di_modID`);

--
-- Indeksy dla tabeli `discount_customer`
--
ALTER TABLE `discount_customer`
  ADD PRIMARY KEY (`dc_ID`),
  ADD KEY `dc_discountID` (`dc_discountID`,`dc_customerID`);

--
-- Indeksy dla tabeli `discount_elements`
--
ALTER TABLE `discount_elements`
  ADD PRIMARY KEY (`del_ID`),
  ADD KEY `del_discountIID` (`del_discountID`,`del_bookID`);

--
-- Indeksy dla tabeli `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`ne_ID`),
  ADD KEY `ne_creatorID` (`ne_creatorID`,`ne_modID`);

--
-- Indeksy dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`or_ID`),
  ADD KEY `or_customerID` (`or_customerID`,`or_sourceWarehouseID`,`or_targetWarehouseID`),
  ADD KEY `or_addressID` (`or_addressID`,`or_shipmentID`,`or_storeID`,`or_creatorID`,`or_modID`);

--
-- Indeksy dla tabeli `order_books`
--
ALTER TABLE `order_books`
  ADD PRIMARY KEY (`ob_ID`),
  ADD KEY `ob_orderID` (`ob_orderID`,`ob_bookID`);

--
-- Indeksy dla tabeli `order_book_discounts`
--
ALTER TABLE `order_book_discounts`
  ADD PRIMARY KEY (`od_id`),
  ADD KEY `od_orderBookID` (`od_orderBookID`,`od_discountElementID`);

--
-- Indeksy dla tabeli `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`ro_ID`),
  ADD KEY `ro_creatorID` (`ro_creatorID`,`ro_modID`);

--
-- Indeksy dla tabeli `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indeksy dla tabeli `shipments`
--
ALTER TABLE `shipments`
  ADD PRIMARY KEY (`si_ID`),
  ADD KEY `si_creatorID` (`si_creatorID`);

--
-- Indeksy dla tabeli `status_history`
--
ALTER TABLE `status_history`
  ADD PRIMARY KEY (`sh_ID`),
  ADD KEY `sh_elementID` (`sh_elementID`,`sh_newStatusUserID`);

--
-- Indeksy dla tabeli `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`st_ID`),
  ADD KEY `st_addressID` (`st_addressID`,`st_warehouseID`,`st_creatorID`,`st_modID`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`us_ID`),
  ADD KEY `us_roleID` (`us_roleID`,`us_storID`,`us_creatorID`,`us_modID`);

--
-- Indeksy dla tabeli `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`wa_ID`),
  ADD KEY `wa_creatorID` (`wa_creatorID`,`wa_modID`);

--
-- Indeksy dla tabeli `warehouse_books`
--
ALTER TABLE `warehouse_books`
  ADD PRIMARY KEY (`wb_ID`),
  ADD KEY `wb_bookID` (`wb_bookID`,`wb_warehouseID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `address`
--
ALTER TABLE `address`
  MODIFY `ad_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT dla tabeli `books`
--
ALTER TABLE `books`
  MODIFY `bo_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `customers`
--
ALTER TABLE `customers`
  MODIFY `cu_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `de_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `delivery_books`
--
ALTER TABLE `delivery_books`
  MODIFY `db_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `discounts`
--
ALTER TABLE `discounts`
  MODIFY `di_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `discount_customer`
--
ALTER TABLE `discount_customer`
  MODIFY `dc_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `discount_elements`
--
ALTER TABLE `discount_elements`
  MODIFY `del_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `news`
--
ALTER TABLE `news`
  MODIFY `ne_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `orders`
--
ALTER TABLE `orders`
  MODIFY `or_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT dla tabeli `order_books`
--
ALTER TABLE `order_books`
  MODIFY `ob_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;

--
-- AUTO_INCREMENT dla tabeli `order_book_discounts`
--
ALTER TABLE `order_book_discounts`
  MODIFY `od_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `roles`
--
ALTER TABLE `roles`
  MODIFY `ro_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `shipments`
--
ALTER TABLE `shipments`
  MODIFY `si_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `status_history`
--
ALTER TABLE `status_history`
  MODIFY `sh_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `store`
--
ALTER TABLE `store`
  MODIFY `st_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `us_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `wa_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `warehouse_books`
--
ALTER TABLE `warehouse_books`
  MODIFY `wb_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `delivery_books`
--
ALTER TABLE `delivery_books`
  ADD CONSTRAINT `delivery_books_ibfk_1` FOREIGN KEY (`db_bookID`) REFERENCES `books` (`bo_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
