-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 23, 2025 lúc 04:15 PM
-- Phiên bản máy phục vụ: 8.0.43
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `res_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblbill`
--

CREATE TABLE `tblbill` (
  `ID` int NOT NULL,
  `date` date NOT NULL,
  `totalprice` float NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `tblStaffID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblbill`
--

INSERT INTO `tblbill` (`ID`, `date`, `totalprice`, `status`, `CustomerID`, `tblStaffID`) VALUES
(1, '2025-10-16', 150000, 'Đã thanh toán', 5, 2),
(2, '2025-10-16', 550000, 'Đã thanh toán', 6, 2),
(3, '2025-10-17', 200000, 'Chưa thanh toán', 7, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblcombo`
--

CREATE TABLE `tblcombo` (
  `ID` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblcombo`
--

INSERT INTO `tblcombo` (`ID`, `name`, `description`, `status`) VALUES
(1, 'Combo Gia Đình', 'Phù hợp cho 4-6 người', 'Còn món'),
(2, 'Combo Sinh Viên', 'Giá rẻ cho sinh viên', 'Còn món'),
(3, 'Combo Hải Sản', 'Đặc sản hải sản tươi ngon', 'Còn món');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblcustomer`
--

CREATE TABLE `tblcustomer` (
  `ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblcustomer`
--

INSERT INTO `tblcustomer` (`ID`) VALUES
(5),
(6),
(7);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbldish`
--

CREATE TABLE `tbldish` (
  `ID` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DishComboID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbldish`
--

INSERT INTO `tbldish` (`ID`, `name`, `price`, `type`, `status`, `description`, `DishComboID`) VALUES
(1, 'Phở Bò', 55000, 'Món chính', 'Còn món', 'Phở bò truyền thống Hà Nội', NULL),
(2, 'Bún Chả', 50000, 'Món chính', 'Còn món', 'Bún chả Hà Nội với thịt nướng', NULL),
(3, 'Cơm Tấm', 45000, 'Món chính', 'Còn món', 'Cơm tấm sườn bì chả trứng', NULL),
(4, 'Bánh Xèo', 40000, 'Món phụ', 'Còn món', 'Bánh xèo miền Tây giòn rụm', NULL),
(5, 'Gỏi Cuốn', 35000, 'Món khai vị', 'Còn món', 'Gỏi cuốn tôm thịt tươi ngon', NULL),
(6, 'Canh Chua', 60000, 'Món canh', 'Còn món', 'Canh chua cá lóc miền Nam', NULL),
(7, 'Lẩu Thái', 250000, 'Món đặc biệt', 'Còn món', 'Lẩu Thái hải sản cay nồng', NULL),
(8, 'Bò Né', 55000, 'Món chính', 'Còn món', 'Bò né Đà Lạt với bánh mì', NULL),
(9, 'Mì Quảng', 50000, 'Món chính', 'Còn món', 'Mì Quảng Đà Nẵng', NULL),
(10, 'Hủ Tiếu', 45000, 'Món chính', 'Còn món', 'Hủ tiếu Nam Vang thanh ngọt', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbldishcombo`
--

CREATE TABLE `tbldishcombo` (
  `ID` int NOT NULL,
  `quantity` int NOT NULL,
  `ComboID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbldishcombo`
--

INSERT INTO `tbldishcombo` (`ID`, `quantity`, `ComboID`) VALUES
(1, 2, 1),
(2, 1, 2),
(3, 1, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblimportedingredient`
--

CREATE TABLE `tblimportedingredient` (
  `ID` int NOT NULL,
  `quantity` int NOT NULL,
  `price` float NOT NULL,
  `IngredientID` int NOT NULL,
  `IngredientReceiptID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblimportedingredient`
--

INSERT INTO `tblimportedingredient` (`ID`, `quantity`, `price`, `IngredientID`, `IngredientReceiptID`) VALUES
(1, 50, 250000, 1, 1),
(2, 50, 200000, 3, 1),
(3, 30, 400000, 2, 2),
(4, 20, 100000, 8, 2),
(5, 50, 30000, 4, 3),
(6, 25, 40000, 5, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblingredient`
--

CREATE TABLE `tblingredient` (
  `ID` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblingredient`
--

INSERT INTO `tblingredient` (`ID`, `name`, `unit`, `price`) VALUES
(1, 'Thịt bò', 'kg', 250000),
(2, 'Tôm', 'kg', 400000),
(3, 'Thịt heo', 'kg', 200000),
(4, 'Rau sống', 'kg', 30000),
(5, 'Bún', 'kg', 40000),
(6, 'Bánh phở', 'kg', 35000),
(7, 'Nước mắm', 'lít', 50000),
(8, 'Gia vị', 'kg', 100000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblingredientreceipt`
--

CREATE TABLE `tblingredientreceipt` (
  `ID` int NOT NULL,
  `date` date NOT NULL,
  `totalprice` float NOT NULL,
  `StaffID` int NOT NULL,
  `SupplierID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblingredientreceipt`
--

INSERT INTO `tblingredientreceipt` (`ID`, `date`, `totalprice`, `StaffID`, `SupplierID`) VALUES
(1, '2025-10-15', 15000000, 4, 1),
(2, '2025-10-15', 8000000, 4, 2),
(3, '2025-10-16', 3000000, 4, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblmembercard`
--

CREATE TABLE `tblmembercard` (
  `ID` int NOT NULL,
  `rank` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `point` int NOT NULL,
  `StaffID` int NOT NULL,
  `CustomerID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblmembercard`
--

INSERT INTO `tblmembercard` (`ID`, `rank`, `point`, `StaffID`, `CustomerID`) VALUES
(1, 'Silver', 150, 1, 5),
(2, 'Gold', 500, 1, 6),
(3, 'Bronze', 50, 2, 7);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblorderedcombo`
--

CREATE TABLE `tblorderedcombo` (
  `ID` int NOT NULL,
  `quantity` int NOT NULL,
  `BillID` int NOT NULL,
  `ComboID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblorderedcombo`
--

INSERT INTO `tblorderedcombo` (`ID`, `quantity`, `BillID`, `ComboID`) VALUES
(1, 1, 2, 1),
(2, 1, 3, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblordereddish`
--

CREATE TABLE `tblordereddish` (
  `ID` int NOT NULL,
  `quantity` int NOT NULL,
  `price` float NOT NULL,
  `BillID` int NOT NULL,
  `DishID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblordereddish`
--

INSERT INTO `tblordereddish` (`ID`, `quantity`, `price`, `BillID`, `DishID`) VALUES
(1, 2, 55000, 1, 1),
(2, 1, 35000, 1, 5),
(3, 1, 250000, 2, 7),
(4, 2, 55000, 2, 1),
(5, 2, 60000, 2, 6),
(6, 1, 50000, 3, 2),
(7, 2, 45000, 3, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblorderedtable`
--

CREATE TABLE `tblorderedtable` (
  `ID` int NOT NULL,
  `date` date NOT NULL,
  `TableID` int NOT NULL,
  `BillID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblorderedtable`
--

INSERT INTO `tblorderedtable` (`ID`, `date`, `TableID`, `BillID`) VALUES
(1, '2025-10-16', 8, 1),
(2, '2025-10-16', 5, 2),
(3, '2025-10-17', 3, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblstaff`
--

CREATE TABLE `tblstaff` (
  `ID` int NOT NULL,
  `position` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblstaff`
--

INSERT INTO `tblstaff` (`ID`, `position`) VALUES
(1, 'Quản lý'),
(2, 'Thu ngân'),
(3, 'Phục vụ'),
(4, 'Nhân viên kho');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tblsupplier`
--

CREATE TABLE `tblsupplier` (
  `ID` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tblsupplier`
--

INSERT INTO `tblsupplier` (`ID`, `name`, `phone`, `address`) VALUES
(1, 'Công ty Thịt Sạch ABC', '0912345678', 'Q1, TP.HCM'),
(2, 'Công ty Hải Sản Tươi Sống', '0923456789', 'Q4, TP.HCM'),
(3, 'Công ty Rau Củ Organic', '0934567890', 'Q7, TP.HCM');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbltable`
--

CREATE TABLE `tbltable` (
  `ID` int NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbltable`
--

INSERT INTO `tbltable` (`ID`, `description`, `status`) VALUES
(1, 'Bàn 1 - 4 người', 'Trống'),
(2, 'Bàn 2 - 4 người', 'Trống'),
(3, 'Bàn 3 - 6 người', 'Đã đặt'),
(4, 'Bàn 4 - 2 người', 'Trống'),
(5, 'Bàn 5 - 8 người', 'Đã đặt'),
(6, 'Bàn 6 - 4 người', 'Trống'),
(7, 'Bàn 7 - 6 người', 'Trống'),
(8, 'Bàn 8 - 4 người', 'Đã đặt');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbluser`
--

CREATE TABLE `tbluser` (
  `ID` int NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbluser`
--

INSERT INTO `tbluser` (`ID`, `username`, `password`, `name`, `date`, `address`, `phone`, `role`) VALUES
(1, 'manager1', '123456', 'Nguyễn Văn Quản Lý', '2024-01-15', '123 Đường ABC, Q1, TP.HCM', '0901111111', 'Manager'),
(2, 'staff1', '123456', 'Trần Thị Thu Ngân', '2024-02-20', '456 Đường DEF, Q2, TP.HCM', '0902222222', 'Staff'),
(3, 'staff2', '123456', 'Lê Văn Phục Vụ', '2024-03-10', '789 Đường GHI, Q3, TP.HCM', '0903333333', 'Staff'),
(4, 'warehouse1', '123456', 'Phạm Thị Kho', '2024-04-05', '147 Đường JKL, Q4, TP.HCM', '0904444444', 'WarehouseStaff'),
(5, 'customer1', '123456', 'Nguyễn Văn A', '2024-05-01', '258 Đường MNO, Q5, TP.HCM', '0905555555', 'Customer'),
(6, 'customer2', '123456', 'Trần Thị B', '2024-06-15', '369 Đường PQR, Q6, TP.HCM', '0906666666', 'Customer'),
(7, 'customer3', '123456', 'Lê Văn C', '2024-07-20', '741 Đường STU, Q7, TP.HCM', '0907777777', 'Customer');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `warehousestaff`
--

CREATE TABLE `warehousestaff` (
  `ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `warehousestaff`
--

INSERT INTO `warehousestaff` (`ID`) VALUES
(4);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `tblbill`
--
ALTER TABLE `tblbill`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `tblStaffID` (`tblStaffID`);

--
-- Chỉ mục cho bảng `tblcombo`
--
ALTER TABLE `tblcombo`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `tblcustomer`
--
ALTER TABLE `tblcustomer`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `tbldish`
--
ALTER TABLE `tbldish`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `DishComboID` (`DishComboID`);

--
-- Chỉ mục cho bảng `tbldishcombo`
--
ALTER TABLE `tbldishcombo`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ComboID` (`ComboID`);

--
-- Chỉ mục cho bảng `tblimportedingredient`
--
ALTER TABLE `tblimportedingredient`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IngredientID` (`IngredientID`),
  ADD KEY `IngredientReceiptID` (`IngredientReceiptID`);

--
-- Chỉ mục cho bảng `tblingredient`
--
ALTER TABLE `tblingredient`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `tblingredientreceipt`
--
ALTER TABLE `tblingredientreceipt`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `StaffID` (`StaffID`),
  ADD KEY `SupplierID` (`SupplierID`);

--
-- Chỉ mục cho bảng `tblmembercard`
--
ALTER TABLE `tblmembercard`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `StaffID` (`StaffID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Chỉ mục cho bảng `tblorderedcombo`
--
ALTER TABLE `tblorderedcombo`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `BillID` (`BillID`),
  ADD KEY `ComboID` (`ComboID`);

--
-- Chỉ mục cho bảng `tblordereddish`
--
ALTER TABLE `tblordereddish`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `BillID` (`BillID`),
  ADD KEY `DishID` (`DishID`);

--
-- Chỉ mục cho bảng `tblorderedtable`
--
ALTER TABLE `tblorderedtable`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `TableID` (`TableID`),
  ADD KEY `BillID` (`BillID`);

--
-- Chỉ mục cho bảng `tblstaff`
--
ALTER TABLE `tblstaff`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `tblsupplier`
--
ALTER TABLE `tblsupplier`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `tbltable`
--
ALTER TABLE `tbltable`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `tbluser`
--
ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Chỉ mục cho bảng `warehousestaff`
--
ALTER TABLE `warehousestaff`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `tblbill`
--
ALTER TABLE `tblbill`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tblcombo`
--
ALTER TABLE `tblcombo`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tbldish`
--
ALTER TABLE `tbldish`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `tbldishcombo`
--
ALTER TABLE `tbldishcombo`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tblimportedingredient`
--
ALTER TABLE `tblimportedingredient`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `tblingredient`
--
ALTER TABLE `tblingredient`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `tblingredientreceipt`
--
ALTER TABLE `tblingredientreceipt`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tblmembercard`
--
ALTER TABLE `tblmembercard`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tblorderedcombo`
--
ALTER TABLE `tblorderedcombo`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `tblordereddish`
--
ALTER TABLE `tblordereddish`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `tblorderedtable`
--
ALTER TABLE `tblorderedtable`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tblsupplier`
--
ALTER TABLE `tblsupplier`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tbltable`
--
ALTER TABLE `tbltable`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `tbluser`
--
ALTER TABLE `tbluser`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `tblbill`
--
ALTER TABLE `tblbill`
  ADD CONSTRAINT `tblbill_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `tblcustomer` (`ID`) ON DELETE SET NULL,
  ADD CONSTRAINT `tblbill_ibfk_2` FOREIGN KEY (`tblStaffID`) REFERENCES `tblstaff` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tblcustomer`
--
ALTER TABLE `tblcustomer`
  ADD CONSTRAINT `tblcustomer_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `tbluser` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tbldish`
--
ALTER TABLE `tbldish`
  ADD CONSTRAINT `tbldish_ibfk_1` FOREIGN KEY (`DishComboID`) REFERENCES `tbldishcombo` (`ID`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `tbldishcombo`
--
ALTER TABLE `tbldishcombo`
  ADD CONSTRAINT `tbldishcombo_ibfk_1` FOREIGN KEY (`ComboID`) REFERENCES `tblcombo` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tblimportedingredient`
--
ALTER TABLE `tblimportedingredient`
  ADD CONSTRAINT `tblimportedingredient_ibfk_1` FOREIGN KEY (`IngredientID`) REFERENCES `tblingredient` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `tblimportedingredient_ibfk_2` FOREIGN KEY (`IngredientReceiptID`) REFERENCES `tblingredientreceipt` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tblingredientreceipt`
--
ALTER TABLE `tblingredientreceipt`
  ADD CONSTRAINT `tblingredientreceipt_ibfk_1` FOREIGN KEY (`StaffID`) REFERENCES `tblstaff` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `tblingredientreceipt_ibfk_2` FOREIGN KEY (`SupplierID`) REFERENCES `tblsupplier` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tblmembercard`
--
ALTER TABLE `tblmembercard`
  ADD CONSTRAINT `tblmembercard_ibfk_1` FOREIGN KEY (`StaffID`) REFERENCES `tblstaff` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `tblmembercard_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `tblcustomer` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tblorderedcombo`
--
ALTER TABLE `tblorderedcombo`
  ADD CONSTRAINT `tblorderedcombo_ibfk_1` FOREIGN KEY (`BillID`) REFERENCES `tblbill` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `tblorderedcombo_ibfk_2` FOREIGN KEY (`ComboID`) REFERENCES `tblcombo` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tblordereddish`
--
ALTER TABLE `tblordereddish`
  ADD CONSTRAINT `tblordereddish_ibfk_1` FOREIGN KEY (`BillID`) REFERENCES `tblbill` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `tblordereddish_ibfk_2` FOREIGN KEY (`DishID`) REFERENCES `tbldish` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tblorderedtable`
--
ALTER TABLE `tblorderedtable`
  ADD CONSTRAINT `tblorderedtable_ibfk_1` FOREIGN KEY (`TableID`) REFERENCES `tbltable` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `tblorderedtable_ibfk_2` FOREIGN KEY (`BillID`) REFERENCES `tblbill` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tblstaff`
--
ALTER TABLE `tblstaff`
  ADD CONSTRAINT `tblstaff_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `tbluser` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `warehousestaff`
--
ALTER TABLE `warehousestaff`
  ADD CONSTRAINT `warehousestaff_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `tblstaff` (`ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
