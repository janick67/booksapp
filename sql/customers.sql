-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 19 Gru 2019, 17:41
-- Wersja serwera: 10.3.16-MariaDB
-- Wersja PHP: 7.3.7

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
  `ad_company` text NOT NULL,
  `ad_NIP` int(10) NOT NULL,
  `ad_firstName` text NOT NULL,
  `ad_lastName` text NOT NULL,
  `ad_creatorID` int(11) NOT NULL,
  `ad_creatorTS` date NOT NULL,
  `ad_modTS` date NOT NULL,
  `ad_modID` int(11) NOT NULL,
  `ad_isArchival` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `books`
--

CREATE TABLE `books` (
  `bo_ID` int(11) NOT NULL,
  `bo_title` text NOT NULL,
  `bo_printHouse` varchar(11) NOT NULL,
  `bo_ISBN` int(13) NOT NULL,
  `co_printDate` date NOT NULL,
  `bo_category` text NOT NULL,
  `bo_description` text NOT NULL,
  `bo_author` text NOT NULL,
  `bo_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `books`
--

INSERT INTO `books` (`bo_ID`, `bo_title`, `bo_printHouse`, `bo_ISBN`, `co_printDate`, `bo_category`, `bo_description`, `bo_author`, `bo_price`) VALUES
(1, 'Harry', 'DKA', 13678985, '2019-12-08', 'Fantastyka', 'o takim czarodzieju', 'JK', 13),
(2, 'Krzyżacy', 'KLA', 678975645, '2019-12-16', 'Historyczna', 'o takich najazdach', 'Sienkiewicz', 66),
(3, 'Mitologia', 'Gre', 4567887, '2019-12-01', 'Historyczna', 'O bogach i nie tylko', 'anonim', 67);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `customeraddress`
--

CREATE TABLE `customeraddress` (
  `ca_ID` int(11) NOT NULL,
  `ca_addressID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `cu_creatorTS` datetime NOT NULL DEFAULT current_timestamp(),
  `cu_modTS` datetime NOT NULL DEFAULT current_timestamp(),
  `cu_modID` int(11) DEFAULT NULL,
  `cu_isArchival` tinyint(1) NOT NULL DEFAULT 0
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
  `di_createTS` date NOT NULL,
  `di_modTS` date NOT NULL,
  `di_modID` int(11) NOT NULL,
  `di_isArchival` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `discount_customer`
--

CREATE TABLE `discount_customer` (
  `dc_ID` int(11) NOT NULL,
  `dc_discountID` int(11) NOT NULL,
  `dc_customerID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `discount_elements`
--

CREATE TABLE `discount_elements` (
  `del_ID` int(11) NOT NULL,
  `del_discountIID` int(11) NOT NULL,
  `del_bookID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `or_customerID` int(11) NOT NULL,
  `or_sourceWarehouseID` int(11) NOT NULL,
  `or_targetWarehouseID` int(11) NOT NULL,
  `or_status` text NOT NULL,
  `or_addressID` int(11) NOT NULL,
  `or_shipmentID` int(11) NOT NULL,
  `or_storeID` int(11) NOT NULL,
  `or_creatorID` int(11) NOT NULL,
  `or_createTS` int(11) NOT NULL,
  `or_modTS` date NOT NULL,
  `or_modID` date NOT NULL,
  `or_comment` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `order_books`
--

CREATE TABLE `order_books` (
  `ob_ID` int(11) NOT NULL,
  `ob_orderID` int(11) NOT NULL,
  `ob_bookID` int(11) NOT NULL,
  `ob_count` int(11) NOT NULL,
  `ob_manualDiscount` int(11) NOT NULL,
  `ob_createTS` date NOT NULL,
  `ob_modTS` date NOT NULL,
  `ob_comment` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('cc95ee3f-da47-4695-9e6a-c0bdc5867d15', 1576781452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('fe174f01-f856-4934-9b6f-15ec52550945', 1576784375, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}');

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
  `st_name` text NOT NULL,
  `st_shortName` text NOT NULL,
  `st_addressID` int(11) NOT NULL,
  `st_warehouseID` int(11) NOT NULL,
  `st_creatorID` int(11) NOT NULL,
  `st_createTS` date NOT NULL,
  `st_modTS` date NOT NULL,
  `st_modID` int(11) NOT NULL,
  `st_isArchival` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `wa_code` text NOT NULL,
  `wa_address` text NOT NULL,
  `wa_creatorID` int(11) NOT NULL,
  `wa_creatorTS` date NOT NULL,
  `wa_modTS` date NOT NULL,
  `wa_modID` int(11) NOT NULL,
  `wa_isArchival` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  ADD PRIMARY KEY (`ca_ID`),
  ADD KEY `ca_addressID` (`ca_addressID`);

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
  ADD KEY `del_discountIID` (`del_discountIID`,`del_bookID`);

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
  MODIFY `ad_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `books`
--
ALTER TABLE `books`
  MODIFY `bo_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `customeraddress`
--
ALTER TABLE `customeraddress`
  MODIFY `ca_ID` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `di_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `discount_customer`
--
ALTER TABLE `discount_customer`
  MODIFY `dc_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `discount_elements`
--
ALTER TABLE `discount_elements`
  MODIFY `del_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `news`
--
ALTER TABLE `news`
  MODIFY `ne_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `order_books`
--
ALTER TABLE `order_books`
  MODIFY `ob_ID` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `st_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `us_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `wa_ID` int(11) NOT NULL AUTO_INCREMENT;

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
