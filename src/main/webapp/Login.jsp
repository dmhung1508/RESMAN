<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập</title>
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
        
        .login-container {
            background: white;
            padding: 50px;
            max-width: 450px;
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
        input[type="password"] {
            width: 100%;
            padding: 14px;
            border: 1px solid #e8e8e8;
            font-size: 14px;
            transition: all 0.3s;
            background: #fafafa;
        }
        
        input:focus {
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
        
        .btn-login:hover {
            background: #2c2c2c;
            color: #ffffff;
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
        
        .success-message {
            background: #f0fff4;
            color: #22543d;
            padding: 15px;
            margin-bottom: 25px;
            border-left: 3px solid #22543d;
            text-align: left;
            font-size: 13px;
        }
        
        .register-link {
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 13px;
        }
        
        .register-link a {
            color: #2c2c2c;
            text-decoration: none;
            font-weight: 500;
            border-bottom: 1px solid #2c2c2c;
        }
        
        .register-link a:hover {
            opacity: 0.7;
        }
        
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .back-link a {
            color: #999;
            text-decoration: none;
            font-size: 13px;
        }
        
        .back-link a:hover {
            color: #2c2c2c;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">🔐</div>
        <h1>Đăng Nhập</h1>
        <p class="subtitle">Nhập thông tin để truy cập hệ thống</p>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ${errorMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty successMessage}">
            <div class="success-message">
                ${successMessage}
            </div>
        </c:if>
        
        <form action="LoginController" method="post">
            <div class="form-group">
                <label for="username">TÊN ĐĂNG NHẬP</label>
                <input type="text" id="username" name="username" 
                       placeholder="Nhập tên đăng nhập..." required>
            </div>
            
            <div class="form-group">
                <label for="password">MẬT KHẨU</label>
                <input type="password" id="password" name="password" 
                       placeholder="Nhập mật khẩu..." required>
            </div>
            
            <button type="submit" class="btn btn-login">Đăng Nhập</button>
        </form>
        
        <div class="register-link">
            Chưa có tài khoản? <a href="RegisterController">Đăng ký ngay</a>
        </div>
        
        <div class="back-link">
            <a href="index.jsp">← Quay về trang chủ</a>
        </div>
        
<%--        <div class="demo-info">--%>
<%--            <strong>📝 Tài khoản demo:</strong>--%>
<%--            <strong>Manager:</strong> manager1 / 123456<br>--%>
<%--            <strong>Cashier:</strong> cashier1 / 123456<br>--%>
<%--            <strong>Waiter:</strong> waiter1 / 123456<br>--%>
<%--            <strong>Chef:</strong> chef1 / 123456--%>
<%--        </div>--%>
    </div>
</body>
</html>




