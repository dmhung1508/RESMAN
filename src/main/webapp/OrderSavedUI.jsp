<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Món Thành Công</title>
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
        
        .container {
            background: white;
            padding: 60px 50px;
            max-width: 700px;
            width: 100%;
            text-align: center;
            border-top: 3px solid #2c2c2c;
            box-shadow: 0 5px 30px rgba(0,0,0,0.05);
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            border: 3px solid #2c2c2c;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 40px;
            font-size: 48px;
            animation: scaleIn 0.6s ease-out;
        }
        
        @keyframes scaleIn {
            0% {
                transform: scale(0);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }
        
        h1 {
            color: #2c2c2c;
            margin-bottom: 20px;
            font-size: 32px;
            font-weight: 400;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        
        .message {
            color: #666;
            font-size: 16px;
            line-height: 1.8;
            margin-bottom: 50px;
            font-weight: 300;
        }
        
        .order-info {
            background: #fafafa;
            padding: 40px;
            margin-bottom: 40px;
            border: 1px solid #e8e8e8;
        }
        
        .order-info h3 {
            margin-bottom: 30px;
            color: #2c2c2c;
            font-size: 16px;
            font-weight: 500;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #e8e8e8;
        }
        
        .info-row:last-child {
            border-bottom: none;
            padding-top: 20px;
            margin-top: 10px;
            border-top: 2px solid #2c2c2c;
        }
        
        .info-label {
            color: #666;
            font-weight: 400;
            font-size: 14px;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            color: #2c2c2c;
            font-weight: 500;
            font-size: 14px;
        }
        
        .highlight {
            background: #fafafa;
            color: #2c2c2c;
            padding: 30px;
            margin-bottom: 40px;
            font-weight: 400;
            font-size: 14px;
            line-height: 1.8;
            border-left: 3px solid #2c2c2c;
        }
        
        .btn {
            padding: 15px 60px;
            border: 2px solid #2c2c2c;
            font-weight: 500;
            cursor: pointer;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            background: #2c2c2c;
            color: white;
        }
        
        .btn:hover {
            background: #1a1a1a;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✓</div>
        <h1>Đặt Món Thành Công</h1>
        
        <div class="message">
            Cảm ơn bạn đã đặt món. Đơn hàng của bạn đã được ghi nhận và đang được xử lý.
        </div>
        
        <div class="order-info">
            <h3>Thông Tin Đơn Hàng</h3>
            <div class="info-row">
                <span class="info-label">Mã đơn hàng</span>
                <span class="info-value">#${order.orderID}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Ngày đặt</span>
                <span class="info-value">${order.orderDate != null ? order.orderDate : 'Hôm nay'}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Tổng tiền</span>
                <span class="info-value" style="font-size: 18px; font-weight: 600;">
                    ${order.totalAmount} VNĐ
                </span>
            </div>
        </div>
        
        <div class="highlight">
            <strong>Lưu ý:</strong> Vui lòng đến nhà hàng đúng giờ đã đặt. 
            Nhân viên sẽ phục vụ các món ăn cho bạn ngay khi bạn đến.
        </div>
        
        <a href="index.jsp" class="btn">Về Trang Chủ</a>
    </div>
</body>
</html>
