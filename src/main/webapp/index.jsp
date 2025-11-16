<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Quản Lý Nhà Hàng</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Playfair Display', 'Times New Roman', serif;
            background: #ffffff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            background: #ffffff;
            padding: 60px 50px;
            max-width: 900px;
            width: 100%;
            text-align: center;
            border-top: 3px solid #2c2c2c;
        }
        
        .logo {
            font-size: 48px;
            margin-bottom: 20px;
            color: #2c2c2c;
        }
        
        h1 {
            color: #2c2c2c;
            margin-bottom: 15px;
            font-size: 42px;
            font-weight: 400;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 60px;
            font-size: 16px;
            font-family: 'Segoe UI', sans-serif;
            font-weight: 300;
            letter-spacing: 1px;
        }
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .menu-card {
            text-decoration: none;
            background: #ffffff;
            color: #2c2c2c;
            padding: 40px 30px;
            border: 2px solid #e8e8e8;
            transition: all 0.4s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        
        .menu-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: #2c2c2c;
            transition: all 0.4s ease;
            z-index: 0;
        }
        
        .menu-card:hover::before {
            left: 0;
        }
        
        .menu-card:hover {
            border-color: #2c2c2c;
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .menu-card:hover .menu-icon,
        .menu-card:hover .menu-title,
        .menu-card:hover .menu-desc {
            color: #ffffff;
        }
        
        .menu-icon {
            font-size: 48px;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
            transition: all 0.4s ease;
        }
        
        .menu-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
            font-family: 'Segoe UI', sans-serif;
            letter-spacing: 1px;
            position: relative;
            z-index: 1;
            transition: all 0.4s ease;
        }
        
        .menu-desc {
            font-size: 14px;
            font-family: 'Segoe UI', sans-serif;
            font-weight: 300;
            color: #666;
            position: relative;
            z-index: 1;
            transition: all 0.4s ease;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">🍽️</div>
        <h1>Hệ Thống Quản Lý Nhà Hàng</h1>
        <!-- <p class="subtitle">Chọn vai trò của bạn để tiếp tục</p> -->
        
        <div class="menu-grid">
            <a href="LoginController" class="menu-card">
                <div class="menu-icon">🔐</div>
                <div class="menu-title">Đăng Nhập Nhân Viên</div>
                <div class="menu-desc">Truy cập hệ thống quản lý</div>
            </a> 
            
            <a href="TableController" class="menu-card">
                <div class="menu-icon">🍴</div>
                <div class="menu-title">Đặt Món Online</div>
                <div class="menu-desc">Khách hàng đặt món</div>
            </a>
        </div>
        
<%--        <div class="info-box">--%>
<%--            <strong>🎯 Chức năng hệ thống:</strong><br>--%>
<%--            ✅ Đăng nhập / Đăng ký<br>--%>
<%--            ✅ Quản lý món ăn (Nhân viên)<br>--%>
<%--            ✅ Đặt món online (Khách hàng)<br>--%>
<%--            ✅ Xác nhận đơn hàng--%>
<%--        </div>--%>
    </div>
</body>
</html>

