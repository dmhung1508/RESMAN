<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Kiểm tra đăng nhập và quyền truy cập
    String role = (String) session.getAttribute("role");
    String fullname = (String) session.getAttribute("fullname");
    
    if (role == null) {
        response.sendRedirect("LoginController");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Nhân Viên</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            max-width: 500px;
            width: 100%;
            border-top: 3px solid #2c2c2c;
            box-shadow: 0 5px 30px rgba(0,0,0,0.05);
        }
        
        .header {
            background: #2c2c2c;
            color: white;
            padding: 30px;
            text-align: center;
            font-weight: 400;
            font-size: 24px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        
        .content {
            padding: 50px 40px;
        }
        
        .menu-button {
            display: block;
            background: #ffffff;
            color: #2c2c2c;
            padding: 20px;
            margin: 15px 0;
            text-decoration: none;
            border: 2px solid #e8e8e8;
            font-weight: 500;
            font-size: 14px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s;
            text-align: center;
        }
        
        .menu-button:hover {
            background: #2c2c2c;
            color: white;
            border-color: #2c2c2c;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">Quản Lý</div>
        
        <div class="content">
            <a href="DishController" class="menu-button">Quản Lý Món Ăn</a>
            <a href="LogoutController" class="menu-button">Đăng Xuất</a>
        </div>
    </div>
</body>
</html>
