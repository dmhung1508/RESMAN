<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .register-container {
            background: white;
            padding: 50px;
            max-width: 550px;
            width: 100%;
            border-top: 3px solid #2c2c2c;
            box-shadow: 0 5px 30px rgba(0,0,0,0.05);
        }
        
        .logo {
            text-align: center;
            font-size: 48px;
            margin-bottom: 30px;
            color: #2c2c2c;
        }
        
        h1 {
            color: #2c2c2c;
            text-align: center;
            margin-bottom: 10px;
            font-size: 32px;
            font-weight: 400;
            letter-spacing: 1px;
        }
        
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 40px;
            font-size: 14px;
            font-weight: 300;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            color: #2c2c2c;
            font-weight: 400;
            font-size: 13px;
            letter-spacing: 0.5px;
        }
        
        input[type="text"],
        input[type="password"],
        input[type="email"],
        select {
            width: 100%;
            padding: 14px;
            border: 1px solid #e8e8e8;
            font-size: 14px;
            transition: all 0.3s;
            background: #fafafa;
        }
        
        input:focus,
        select:focus {
            outline: none;
            border-color: #2c2c2c;
            background: #ffffff;
        }
        
        .btn {
            width: 100%;
            padding: 15px;
            border: 2px solid #2c2c2c;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
            background: #ffffff;
            color: #2c2c2c;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .btn-register {
            background: #2c2c2c;
            color: white;
        }
        
        .btn-register:hover {
            background: #1a1a1a;
        }
        
        .error-message {
            background: #fff5f5;
            color: #c53030;
            padding: 15px;
            margin-bottom: 25px;
            border-left: 3px solid #c53030;
            text-align: left;
            font-size: 13px;
        }
        
        .login-link {
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 13px;
        }
        
        .login-link a {
            color: #2c2c2c;
            text-decoration: none;
            font-weight: 500;
            border-bottom: 1px solid #2c2c2c;
        }
        
        .login-link a:hover {
            opacity: 0.7;
        }
        
        .required {
            color: #c53030;
        }
        
        .role-select {
            background: #fafafa;
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid #e8e8e8;
        }
        
        .role-select label {
            font-size: 13px;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="logo">📝</div>
        <h1>Đăng Ký</h1>
        <p class="subtitle">Tạo tài khoản mới để sử dụng hệ thống</p>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ${errorMessage}
            </div>
        </c:if>
        
        <form action="RegisterController" method="post">
            <div class="role-select">
                <label for="role">VAI TRÒ NHÂN VIÊN <span class="required">*</span></label>
                <select id="role" name="role" required>
                    <option value="">-- Chọn vai trò --</option>
                    <option value="manager">Quản lý (Manager)</option>
                    <option value="cashier">Thu ngân (Cashier)</option>
                    <option value="waiter">Phục vụ (Waiter)</option>
                    <option value="chef">Đầu bếp (Chef)</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="username">TÊN ĐĂNG NHẬP <span class="required">*</span></label>
                <input type="text" id="username" name="username" 
                       placeholder="Nhập tên đăng nhập..." required>
            </div>
            
            <div class="form-group">
                <label for="password">MẬT KHẨU <span class="required">*</span></label>
                <input type="password" id="password" name="password" 
                       placeholder="Nhập mật khẩu (ít nhất 6 ký tự)..." required minlength="6">
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">XÁC NHẬN MẬT KHẨU <span class="required">*</span></label>
                <input type="password" id="confirmPassword" name="confirmPassword" 
                       placeholder="Nhập lại mật khẩu..." required>
            </div>
            
            <div class="form-group">
                <label for="fullname">HỌ VÀ TÊN <span class="required">*</span></label>
                <input type="text" id="fullname" name="fullname" 
                       placeholder="Nhập họ và tên..." required>
            </div>
            
            <div class="form-group">
                <label for="email">EMAIL</label>
                <input type="email" id="email" name="email" 
                       placeholder="Nhập email...">
            </div>
            
            <div class="form-group">
                <label for="phone">SỐ ĐIỆN THOẠI</label>
                <input type="text" id="phone" name="phone" 
                       placeholder="Nhập số điện thoại..." pattern="[0-9]{10,11}">
            </div>
            
            <div class="form-group">
                <label for="address">ĐỊA CHỈ</label>
                <input type="text" id="address" name="address" 
                       placeholder="Nhập địa chỉ...">
            </div>
            
            <button type="submit" class="btn btn-register">Đăng Ký</button>
        </form>
        
        <div class="login-link">
            Đã có tài khoản? <a href="LoginController">Đăng nhập ngay</a>
        </div>
    </div>
</body>
</html>
