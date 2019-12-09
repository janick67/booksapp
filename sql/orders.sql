-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 04 Gru 2019, 22:13
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
-- Struktura tabeli dla tabeli `orderbookdiscounts`
--

CREATE TABLE `orderbookdiscounts` (
  `od_id` int(10) NOT NULL,
  `od_orderBookID` int(10) NOT NULL,
  `od_value` float NOT NULL,
  `od_comment` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orderbooks`
--

CREATE TABLE `orderbooks` (
  `ob_ID` int(10) NOT NULL,
  `ob_orderID` int(10) NOT NULL,
  `ob_bookID` int(10) NOT NULL,
  `ob_count` int(10) NOT NULL,
  `ob_createTS` datetime NOT NULL,
  `ob_modTs` datetime NOT NULL,
  `ob_comment` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `or_ID` int(10) NOT NULL,
  `or_customerID` int(10) NOT NULL,
  `or_targetWarehouseID` int(10) NOT NULL,
  `or_status` int(10) NOT NULL,
  `or_addressID` int(10) NOT NULL,
  `or_creatorID` int(10) NOT NULL,
  `or_createTS` datetime NOT NULL,
  `or_modTS` datetime NOT NULL,
  `or_comment` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('feea220e-133f-4967-8a8e-1d9810410b3c', 1575504746, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
