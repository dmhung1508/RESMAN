<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Báo</title>
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
            max-width: 600px;
            width: 100%;
            text-align: center;
            border-top: 3px solid #2c2c2c;
            box-shadow: 0 5px 30px rgba(0,0,0,0.05);
        }
        
        .icon {
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
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 400;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        
        .message {
            color: #666;
            font-size: 16px;
            margin-bottom: 40px;
            line-height: 1.8;
            font-weight: 300;
        }
        
        .btn {
            padding: 15px 50px;
            border: 2px solid #2c2c2c;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            background: #2c2c2c;
            color: white;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .btn:hover {
            background: #1a1a1a;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">✓</div>
        <h1>Thông Báo</h1>
        <div class="message">
            ${message}
        </div>
        <a href="DishController" class="btn">Quay Lại</a>
    </div>
</body>
</html>
