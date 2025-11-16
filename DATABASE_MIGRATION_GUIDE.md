# Hướng dẫn Migration Database

## Tổng quan
Database đã được cập nhật sang cấu trúc mới với các bảng có tiền tố `tbl`. Dưới đây là hướng dẫn các thay đổi và cách cập nhật code.

## Thay đổi cấu trúc

### 1. Bảng User (users → tblUser)
**CŨ:**
```sql
users (id, fullname, phone, email, address)
staff (id, user_id, username, password_hash, role)
customers (id, user_id)
```

**MỚI:**
```sql
tblUser (ID, username, password, name, date, address, phone, role)
tblStaff (ID, position) -- ID là FK tới tblUser
tblCustomer (ID) -- ID là FK tới tblUser
```

### 2. Bảng Dish (dish → tblDish)
**CŨ:**
```sql
dish (id, name, description, price, status)
```

**MỚI:**
```sql
tblDish (ID, name, price, type, status, description, DishComboID)
```

### 3. Bảng Table (restaurant_table → tblTable)
**CŨ:**
```sql
restaurant_table (id, number_no, capacity, status)
```

**MỚI:**
```sql
tblTable (ID, description, status)
```

### 4. Bảng Order (orders → tblBill + tblOrderedDish + tblOrderedTable)
**CŨ:**
```sql
orders (id, customer_id, table_id, order_datetime, total_amount)
order_item (id, order_id, dish_id, quantity, note, line_total)
```

**MỚI:**
```sql
tblBill (ID, date, totalprice, status, CustomerID, tblStaffID)
tblOrderedTable (ID, date, TableID, BillID)
tblOrderedDish (ID, quantity, price, BillID, DishID)
```

## Cách cập nhật code

### Bước 1: Chạy lại database
```bash
mysql -u root -p < database.sql
```

### Bước 2: Cập nhật Model Classes

Các model cần cập nhật theo cấu trúc mới:

#### Users.java
```java
public class Users {
    private int id;
    private String username;
    private String password;
    private String name;
    private Date date;
    private String address;
    private String phone;
    private String role; // 'staff' hoặc 'customer'
}
```

#### Staff.java
```java
public class Staff {
    private int id; // FK tới tblUser
    private String position;
    private Users user; // Object User
}
```

#### Customer.java
```java
public class Customer {
    private int id; // FK tới tblUser
    private Users user; // Object User
}
```

### Bước 3: Cập nhật DAO Classes

#### StaffDAO - Login
```java
public Staff login(String username, String password) {
    String sql = "SELECT s.*, u.* FROM tblStaff s " +
                "JOIN tblUser u ON s.ID = u.ID " +
                "WHERE u.username = ? AND u.password = ?";
    // ...
}
```

#### CustomerDAO - Đăng ký
```java
public int register(Users user) {
    // 1. Insert vào tblUser với role='customer'
    // 2. Lấy ID vừa tạo
    // 3. Insert vào tblCustomer với ID đó
}
```

#### DishDAO
```java
public List<Dish> getDishListByName(String name) {
    String sql = "SELECT * FROM tblDish WHERE name LIKE ?";
    // ...
}
```

#### OrderDAO → BillDAO
```java
public boolean saveBill(Bill bill, int customerId, int staffId, int tableId) {
    // 1. Insert vào tblBill
    // 2. Insert vào tblOrderedTable
    // 3. Insert vào tblOrderedDish cho từng món
}
```

## Lưu ý quan trọng

1. **Inheritance Pattern**: tblUser là bảng cha, tblStaff và tblCustomer kế thừa thông qua ID
2. **Role Field**: Sử dụng field `role` trong tblUser để phân biệt 'staff' và 'customer'
3. **Bill thay cho Order**: Khái niệm "Order" đổi thành "Bill"
4. **Table Linking**: Mỗi Bill liên kết với Table thông qua bảng tblOrderedTable

## Các thay đổi cần thiết trong Controllers

### ConfirmOrderController
- Đổi `OrderDAO` → `BillDAO`
- Đổi `Order` → `Bill`
- Cập nhật logic lưu vào `tblBill`, `tblOrderedTable`, `tblOrderedDish`

### SearchTableController
- Cập nhật query từ `restaurant_table` → `tblTable`

### LoginController / RegisterController
- Cập nhật để làm việc với cấu trúc tblUser mới

## Test sau khi migration

1. Đăng nhập Staff
2. Tìm kiếm bàn
3. Chọn món ăn
4. Xác nhận đơn hàng
5. Xem lịch sử đơn hàng
