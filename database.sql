-- Tạo database
CREATE DATABASE IF NOT EXISTS resmanto CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE resmanto;

-- Drop các bảng cũ nếu tồn tại
DROP TABLE IF EXISTS tblOrderedDish;
DROP TABLE IF EXISTS tblOrderedCombo;
DROP TABLE IF EXISTS tblOrderedTable;
DROP TABLE IF EXISTS tblBill;
DROP TABLE IF EXISTS tblImportedIngredient;
DROP TABLE IF EXISTS tblIngredientReceipt;
DROP TABLE IF EXISTS tblDish;
DROP TABLE IF EXISTS tblDishCombo;
DROP TABLE IF EXISTS tblCombo;
DROP TABLE IF EXISTS tblTable;
DROP TABLE IF EXISTS tblIngredient;
DROP TABLE IF EXISTS tblSupplier;
DROP TABLE IF EXISTS tblMemberCard;
DROP TABLE IF EXISTS WarehouseStaff;
DROP TABLE IF EXISTS tblStaff;
DROP TABLE IF EXISTS tblCustomer;
DROP TABLE IF EXISTS tblUser;

-- Tạo bảng tblUser
CREATE TABLE tblUser (
    ID int(10) NOT NULL AUTO_INCREMENT,
    username varchar(50) NOT NULL UNIQUE,
    password varchar(100) NOT NULL,
    name varchar(100) NOT NULL,
    `date` date NOT NULL,
    address varchar(200) NOT NULL,
    phone varchar(20) NOT NULL UNIQUE,
    role varchar(50) NOT NULL,
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblStaff
CREATE TABLE tblStaff (
    ID int(10) NOT NULL,
    position varchar(50) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES tblUser (ID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng WarehouseStaff
CREATE TABLE WarehouseStaff (
    ID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES tblStaff (ID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblCustomer
CREATE TABLE tblCustomer (
    ID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES tblUser (ID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblMemberCard
CREATE TABLE tblMemberCard (
    ID int(10) NOT NULL AUTO_INCREMENT,
    `rank` varchar(50) NOT NULL,
    `point` int(10) NOT NULL,
    StaffID int(10) NOT NULL,
    CustomerID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (StaffID) REFERENCES tblStaff (ID),
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblSupplier
CREATE TABLE tblSupplier (
    ID int(10) NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    phone varchar(20),
    address varchar(200) NOT NULL,
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblIngredient
CREATE TABLE tblIngredient (
    ID int(10) NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    unit varchar(50) NOT NULL,
    price float NOT NULL,
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblIngredientReceipt
CREATE TABLE tblIngredientReceipt (
    ID int(10) NOT NULL AUTO_INCREMENT,
    `date` date NOT NULL,
    totalprice float NOT NULL,
    StaffID int(10) NOT NULL,
    SupplierID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (StaffID) REFERENCES tblStaff (ID),
    FOREIGN KEY (SupplierID) REFERENCES tblSupplier (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblImportedIngredient
CREATE TABLE tblImportedIngredient (
    ID int(10) NOT NULL AUTO_INCREMENT,
    quantity int(10) NOT NULL,
    price float NOT NULL,
    IngredientID int(10) NOT NULL,
    IngredientReceiptID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (IngredientID) REFERENCES tblIngredient (ID),
    FOREIGN KEY (IngredientReceiptID) REFERENCES tblIngredientReceipt (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblCombo
CREATE TABLE tblCombo (
    ID int(10) NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    description varchar(255) NOT NULL,
    status varchar(50),
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblDishCombo
CREATE TABLE tblDishCombo (
    ID int(10) NOT NULL AUTO_INCREMENT,
    quantity int(10) NOT NULL,
    ComboID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (ComboID) REFERENCES tblCombo (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblDish
CREATE TABLE tblDish (
    ID int(10) NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    price float NOT NULL,
    type varchar(50) NOT NULL,
    status varchar(50),
    description varchar(255) NOT NULL,
    DishComboID int(10),
    PRIMARY KEY (ID),
    FOREIGN KEY (DishComboID) REFERENCES tblDishCombo (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblTable
CREATE TABLE tblTable (
    ID int(10) NOT NULL AUTO_INCREMENT,
    description varchar(255) NOT NULL,
    status varchar(50) NOT NULL,
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblBill
CREATE TABLE tblBill (
    ID int(10) NOT NULL AUTO_INCREMENT,
    `date` date NOT NULL,
    totalprice float NOT NULL,
    status varchar(50),
    CustomerID int(10),
    tblStaffID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer (ID),
    FOREIGN KEY (tblStaffID) REFERENCES tblStaff (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblOrderedTable
CREATE TABLE tblOrderedTable (
    ID int(10) NOT NULL AUTO_INCREMENT,
    `date` date NOT NULL,
    TableID int(10) NOT NULL,
    BillID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (TableID) REFERENCES tblTable (ID),
    FOREIGN KEY (BillID) REFERENCES tblBill (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblOrderedDish
CREATE TABLE tblOrderedDish (
    ID int(10) NOT NULL AUTO_INCREMENT,
    quantity int(10) NOT NULL,
    price float NOT NULL,
    BillID int(10) NOT NULL,
    DishID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (BillID) REFERENCES tblBill (ID),
    FOREIGN KEY (DishID) REFERENCES tblDish (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tạo bảng tblOrderedCombo
CREATE TABLE tblOrderedCombo (
    ID int(10) NOT NULL AUTO_INCREMENT,
    quantity int(10) NOT NULL,
    BillID int(10) NOT NULL,
    ComboID int(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (BillID) REFERENCES tblBill (ID),
    FOREIGN KEY (ComboID) REFERENCES tblCombo (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================
-- DỮ LIỆU MẪU
-- ================================

-- Dữ liệu mẫu cho bảng tblUser
INSERT INTO tblUser (username, password, name, `date`, address, phone, role) VALUES
('manager1', '123456', 'Nguyễn Văn Quản Lý', '1990-01-15', '123 Đường ABC, Q1, TP.HCM', '0901111111', 'staff'),
('cashier1', '123456', 'Trần Thị Thu Ngân', '1992-05-20', '456 Đường DEF, Q2, TP.HCM', '0902222222', 'staff'),
('waiter1', '123456', 'Lê Văn Phục Vụ', '1995-08-10', '789 Đường GHI, Q3, TP.HCM', '0903333333', 'staff'),
('chef1', '123456', 'Phạm Thị Đầu Bếp', '1988-12-25', '147 Đường JKL, Q4, TP.HCM', '0904444444', 'staff'),
('customer1', '123456', 'Nguyễn Văn A', '1993-03-10', '258 Đường MNO, Q5, TP.HCM', '0905555555', 'customer'),
('customer2', '123456', 'Trần Thị B', '1994-07-15', '369 Đường PQR, Q6, TP.HCM', '0906666666', 'customer'),
('customer3', '123456', 'Lê Văn C', '1996-11-20', '741 Đường STU, Q7, TP.HCM', '0907777777', 'customer');

-- Dữ liệu mẫu cho bảng tblStaff
INSERT INTO tblStaff (ID, position) VALUES
(1, 'manager'),
(2, 'cashier'),
(3, 'waiter'),
(4, 'chef');

-- Dữ liệu mẫu cho bảng tblCustomer
INSERT INTO tblCustomer (ID) VALUES
(5), (6), (7);

-- Dữ liệu mẫu cho bảng tblMemberCard
INSERT INTO tblMemberCard (`rank`, `point`, StaffID, CustomerID) VALUES
('Silver', 150, 1, 5),
('Gold', 500, 1, 6),
('Bronze', 50, 1, 7);

-- Dữ liệu mẫu cho bảng tblTable
INSERT INTO tblTable (description, status) VALUES
('Bàn 1 - 4 người', 'Trống'),
('Bàn 2 - 4 người', 'Trống'),
('Bàn 3 - 6 người', 'Đã đặt'),
('Bàn 4 - 2 người', 'Trống'),
('Bàn 5 - 8 người', 'Đã đặt'),
('Bàn 6 - 4 người', 'Trống'),
('Bàn 7 - 6 người', 'Trống'),
('Bàn 8 - 4 người', 'Đang dùng');

-- Dữ liệu mẫu cho bảng tblDish
INSERT INTO tblDish (name, price, type, status, description, DishComboID) VALUES
('Phở Bò', 55000, 'Món chính', 'Còn món', 'Phở bò truyền thống Hà Nội với nước dùng hầm xương nhiều giờ', NULL),
('Bún Chả', 50000, 'Món chính', 'Còn món', 'Bún chả Hà Nội với thịt nướng thơm ngon', NULL),
('Cơm Tấm', 45000, 'Món chính', 'Còn món', 'Cơm tấm sườn bì chả trứng đặc sản Sài Gòn', NULL),
('Bánh Xèo', 40000, 'Món chính', 'Còn món', 'Bánh xèo miền Tây giòn rụm, nhân tôm thịt', NULL),
('Gỏi Cuốn', 35000, 'Khai vị', 'Còn món', 'Gỏi cuốn tôm thịt tươi ngon kèm nước chấm đặc biệt', NULL),
('Canh Chua', 60000, 'Món canh', 'Còn món', 'Canh chua cá lóc miền Nam chuẩn vị', NULL),
('Lẩu Thái', 250000, 'Món lẩu', 'Còn món', 'Lẩu Thái hải sản cay nồng đậm đà', NULL),
('Bò Né', 55000, 'Món chính', 'Còn món', 'Bò né Đà Lạt với bánh mì nóng giòn', NULL),
('Mì Quảng', 50000, 'Món chính', 'Còn món', 'Mì Quảng Đà Nẵng với tôm thịt đầy đặn', NULL),
('Hủ Tiếu', 45000, 'Món chính', 'Còn món', 'Hủ tiếu Nam Vang thanh ngọt nước dùng', NULL);

-- Dữ liệu mẫu cho bảng tblSupplier
INSERT INTO tblSupplier (name, phone, address) VALUES
('Công ty Thịt Sạch ABC', '0912345678', 'Q1, TP.HCM'),
('Công ty Hải Sản Tươi Sống', '0923456789', 'Q4, TP.HCM'),
('Công ty Rau Củ Organic', '0934567890', 'Q7, TP.HCM');

-- Dữ liệu mẫu cho bảng tblIngredient
INSERT INTO tblIngredient (name, unit, price) VALUES
('Thịt bò', 'kg', 250000),
('Tôm', 'kg', 400000),
('Thịt heo', 'kg', 200000),
('Rau sống', 'kg', 30000),
('Bún', 'kg', 40000),
('Bánh phở', 'kg', 35000),
('Nước mắm', 'lít', 100000),
('Gia vị', 'kg', 80000);

-- Dữ liệu mẫu cho bảng tblBill
INSERT INTO tblBill (`date`, totalprice, status, CustomerID, tblStaffID) VALUES
('2025-10-16', 150000, 'Đã thanh toán', 5, 2),
('2025-10-16', 550000, 'Đã thanh toán', 6, 2);

-- Dữ liệu mẫu cho bảng tblOrderedTable
INSERT INTO tblOrderedTable (`date`, TableID, BillID) VALUES
('2025-10-16', 8, 1),
('2025-10-16', 5, 2);

-- Dữ liệu mẫu cho bảng tblOrderedDish
INSERT INTO tblOrderedDish (quantity, price, BillID, DishID) VALUES
(2, 110000, 1, 1),
(1, 35000, 1, 5),
(1, 250000, 2, 7),
(2, 110000, 2, 1),
(2, 120000, 2, 6);

-- Hiển thị dữ liệu
SELECT 'Users:' as '';
SELECT * FROM tblUser;

SELECT 'Staff:' as '';
SELECT * FROM tblStaff;

SELECT 'Customers:' as '';
SELECT * FROM tblCustomer;

SELECT 'Member Cards:' as '';
SELECT * FROM tblMemberCard;

SELECT 'Tables:' as '';
SELECT * FROM tblTable;

SELECT 'Dishes:' as '';
SELECT * FROM tblDish;

SELECT 'Suppliers:' as '';
SELECT * FROM tblSupplier;

SELECT 'Ingredients:' as '';
SELECT * FROM tblIngredient;

SELECT 'Bills:' as '';
SELECT * FROM tblBill;

SELECT 'Ordered Tables:' as '';
SELECT * FROM tblOrderedTable;

SELECT 'Ordered Dishes:' as '';
SELECT * FROM tblOrderedDish;
