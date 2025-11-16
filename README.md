# 🍽️ Hệ Thống Quản Lý Nhà Hàng

Hệ thống quản lý nhà hàng được phát triển bằng Java Web (JSP/Servlet) với cơ sở dữ liệu MySQL.

## 📋 Mục Lục
- [Tính năng](#tính-năng)
- [Công nghệ sử dụng](#công-nghệ-sử-dụng)
- [Cấu trúc Project](#cấu-trúc-project)
- [Cài đặt](#cài-đặt)
- [Cấu hình Database](#cấu-hình-database)
- [Chạy ứng dụng](#chạy-ứng-dụng)
- [Sử dụng](#sử-dụng)

## ✨ Tính năng

### 1. Module Quản Lý Món Ăn (Nhân viên)
- Xem danh sách món ăn
- Tìm kiếm món ăn theo tên
- Chỉnh sửa thông tin món ăn (tên, giá, mô tả, trạng thái)
- Lưu thông tin vào database

### 2. Module Đặt Món Online (Khách hàng)
- Tìm bàn đã đặt theo số điện thoại
- Xem thông tin bàn đã đặt
- Tìm kiếm và chọn món ăn
- Thêm món vào giỏ hàng
- Xác nhận và lưu đơn hàng
- Xem thông tin đơn hàng đã đặt

## 🛠️ Công nghệ sử dụng

- **Backend:** Java (JDK 8+)
- **Web Framework:** JSP/Servlet
- **Database:** MySQL 8.0
- **Build Tool:** Maven
- **Server:** Apache Tomcat 9.0+
- **Frontend:** HTML5, CSS3

## 📁 Cấu trúc Project

```
UI/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── controller/          # Servlet Controllers
│   │   │   │   ├── DishController.java
│   │   │   │   ├── SearchTableController.java
│   │   │   │   ├── SelectDishController.java
│   │   │   │   └── ConfirmOrderController.java
│   │   │   ├── dao/                 # Data Access Objects
│   │   │   │   ├── DAO.java
│   │   │   │   ├── DishDAO.java
│   │   │   │   ├── OrderDAO.java
│   │   │   │   └── ReservationDAO.java
│   │   │   └── model/               # Entity Classes
│   │   │       ├── Dish.java
│   │   │       ├── Customer.java
│   │   │       ├── Order.java
│   │   │       ├── OrderItem.java
│   │   │       ├── Reservation.java
│   │   │       ├── Table.java
│   │   │       └── Payment.java
│   │   └── webapp/                  # JSP Files
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── MainStaffUI.jsp      # Trang chủ nhân viên
│   │       ├── ManageDishUI.jsp     # Quản lý món ăn
│   │       ├── EditDishUI.jsp       # Chỉnh sửa món ăn
│   │       ├── NotificationUI.jsp   # Thông báo
│   │       ├── MainCustomerUI.jsp   # Trang chủ khách hàng
│   │       ├── SearchTableUI.jsp    # Tìm bàn đã đặt
│   │       ├── SelectDish.jsp       # Chọn món ăn
│   │       ├── ConfirmUI.jsp   # Xác nhận đơn hàng
│   │       └── OrderSavedUI.jsp     # Đặt món thành công
├── pom.xml                          # Maven configuration
├── database.sql                     # SQL script
└── README.md
```

## 🚀 Cài đặt

### Yêu cầu hệ thống
- Java JDK 8 trở lên
- Apache Tomcat 9.0 trở lên
- MySQL 8.0 trở lên
- Maven 3.6 trở lên

### Bước 1: Clone hoặc tải project
```bash
cd UI
```

### Bước 2: Cài đặt dependencies
```bash
mvn clean install
```

## 🗄️ Cấu hình Database

### Bước 1: Tạo database
Chạy file `database.sql` trong MySQL:

```bash
mysql -u root -p < database.sql
```

Hoặc import trong MySQL Workbench/phpMyAdmin.

### Bước 2: Cấu hình kết nối
Chỉnh sửa file `src/main/java/dao/DAO.java`:

```java
String url = "jdbc:mysql://localhost:3306/resman";
String username = "root";      // Thay đổi username của bạn
String password = "your_password";  // Thay đổi password của bạn
```

## ▶️ Chạy ứng dụng

### Cách 1: Sử dụng Maven
```bash
mvn tomcat7:run
```

### Cách 2: Deploy lên Tomcat
1. Build file WAR:
   ```bash
   mvn clean package
   ```

2. Copy file `target/restaurant-management.war` vào thư mục `webapps` của Tomcat

3. Khởi động Tomcat:
   ```bash
   # Windows
   catalina.bat run
   
   # Linux/Mac
   ./catalina.sh run
   ```

### Cách 3: Sử dụng IDE (Eclipse/IntelliJ)
1. Import project as Maven project
2. Cấu hình Tomcat server trong IDE
3. Run project trên server

## 📖 Sử dụng

### Truy cập ứng dụng
- **Khách hàng:** http://localhost:8080/restaurant-management/MainCustomerUI.jsp
- **Nhân viên:** http://localhost:8080/restaurant-management/MainStaffUI.jsp

### Dữ liệu test
Database đã có sẵn dữ liệu mẫu:

**Khách hàng có đặt bàn:**
- Số điện thoại: 0901234567 (Nguyễn Văn A - Bàn 3)
- Số điện thoại: 0912345678 (Trần Thị B - Bàn 5)

**Món ăn:** 10 món ăn mẫu đã được thêm vào

## 🎯 Luồng sử dụng

### Module Nhân Viên - Chỉnh Sửa Món Ăn
1. Truy cập MainStaffUI.jsp
2. Click "Quản Lý Món Ăn"
3. Nhập tên món ăn cần tìm và click "Tìm kiếm"
4. Click "Chỉnh sửa" ở món ăn muốn sửa
5. Nhập thông tin mới (tên, giá, mô tả, trạng thái)
6. Click "Lưu"
7. Hệ thống hiển thị thông báo thành công

### Module Khách Hàng - Đặt Món Online
1. Truy cập MainCustomerUI.jsp
2. Click "Bắt Đầu Đặt Món"
3. Nhập số điện thoại đã đặt bàn
4. Hệ thống hiển thị thông tin bàn đã đặt
5. Tìm kiếm món ăn theo tên
6. Chọn món và nhập số lượng, click "Thêm"
7. Lặp lại bước 5-6 cho các món khác
8. Click "Xác nhận đặt món"
9. Kiểm tra thông tin đơn hàng
10. Click "Lưu đơn hàng"
11. Hệ thống hiển thị thông báo thành công với mã đơn hàng

## 🎨 Giao diện

- **Modern & Responsive:** Giao diện hiện đại, đáp ứng nhiều kích thước màn hình
- **Gradient Colors:** Sử dụng màu gradient bắt mắt
- **User-Friendly:** Dễ sử dụng với các biểu tượng emoji trực quan
- **Animation:** Hiệu ứng chuyển động mượt mà

## 📝 Lưu ý

1. **Database Connection:** Đảm bảo MySQL đang chạy và thông tin kết nối đúng
2. **Port:** Mặc định sử dụng port 8080, có thể thay đổi trong cấu hình Tomcat
3. **Character Encoding:** Project sử dụng UTF-8 để hỗ trợ tiếng Việt
4. **Session Timeout:** Session timeout mặc định là 30 phút

## 🐛 Xử lý lỗi thường gặp

### Lỗi kết nối database
- Kiểm tra MySQL đang chạy
- Kiểm tra username/password trong DAO.java
- Kiểm tra database đã được tạo

### Lỗi 404 Not Found
- Kiểm tra context path trong URL
- Kiểm tra file WAR đã được deploy đúng

### Lỗi tiếng Việt bị lỗi font
- Kiểm tra encoding trong web.xml
- Kiểm tra database charset là utf8mb4

## 📞 Hỗ trợ

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra log trong Tomcat
2. Kiểm tra console trong browser (F12)
3. Kiểm tra database connection

## 📄 License

Đây là project học tập, miễn phí sử dụng cho mục đích giáo dục.

---
**Phát triển bởi:** Team PTTK_E22TTNT  
**Ngày:** October 2025

