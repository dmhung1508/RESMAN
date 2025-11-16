<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Kiểm tra đăng nhập và quyền truy cập
    String role = (String) session.getAttribute("role");
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
    <title>Chỉnh Sửa Món Ăn</title>
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
            padding: 50px;
            max-width: 600px;
            width: 100%;
            border-top: 3px solid #2c2c2c;
            box-shadow: 0 5px 30px rgba(0,0,0,0.05);
        }
        
        h1 {
            color: #2c2c2c;
            margin-bottom: 40px;
            text-align: center;
            font-size: 28px;
            font-weight: 400;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        
        .form-group {
            margin-bottom: 30px;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            color: #2c2c2c;
            font-weight: 400;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 14px;
            border: 1px solid #e8e8e8;
            font-size: 14px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: all 0.3s;
            background: #fafafa;
        }
        
        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #2c2c2c;
            background: #ffffff;
        }
        
        textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 40px;
        }
        
        .btn {
            flex: 1;
            padding: 15px 30px;
            border: 2px solid #2c2c2c;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .btn-save {
            background: #2c2c2c;
            color: white;
        }
        
        .btn-save:hover {
            background: #1a1a1a;
        }
        
        .btn-cancel {
            background: #ffffff;
            color: #2c2c2c;
        }
        
        .btn-cancel:hover {
            background: #2c2c2c;
            color: white;
        }
        
        .required {
            color: #c53030;
            margin-left: 3px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Chỉnh Sửa Món Ăn</h1>
        
        <form action="DishController" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="dishID" value="${dish.id}">
            
            <div class="form-group">
                <label for="txtDishName">Tên món <span class="required">*</span></label>
                <input type="text" id="txtDishName" name="txtDishName" 
                       value="${dish.name}" required>
            </div>
            
            <div class="form-group">
                <label for="txtPrice">Giá (VNĐ) <span class="required">*</span></label>
                <input type="number" id="txtPrice" name="txtPrice" 
                       value="${dish.price}" step="0.01" min="0" required>
            </div>
            
            <div class="form-group">
                <label for="txtType">Loại món <span class="required">*</span></label>
                <select id="txtType" name="txtType" required>
                    <option value="Món chính" ${dish.type == 'Món chính' ? 'selected' : ''}>Món chính</option>
                    <option value="Khai vị" ${dish.type == 'Khai vị' ? 'selected' : ''}>Khai vị</option>
                    <option value="Món canh" ${dish.type == 'Món canh' ? 'selected' : ''}>Món canh</option>
                    <option value="Món lẩu" ${dish.type == 'Món lẩu' ? 'selected' : ''}>Món lẩu</option>
                    <option value="Tráng miệng" ${dish.type == 'Tráng miệng' ? 'selected' : ''}>Tráng miệng</option>
                    <option value="Đồ uống" ${dish.type == 'Đồ uống' ? 'selected' : ''}>Đồ uống</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="txtDescription">Mô tả</label>
                <textarea id="txtDescription" name="txtDescription">${dish.description}</textarea>
            </div>
            
            <div class="form-group">
                <label for="cbStatus">Trạng thái <span class="required">*</span></label>
                <select id="cbStatus" name="cbStatus" required>
                    <option value="Còn món" ${dish.status == 'Còn món' ? 'selected' : ''}>Còn món</option>
                    <option value="Hết món" ${dish.status == 'Hết món' ? 'selected' : ''}>Hết món</option>
                    <option value="Tạm ngưng" ${dish.status == 'Tạm ngưng' ? 'selected' : ''}>Tạm ngưng</option>
                </select>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn btn-save">Lưu</button>
                <button type="button" class="btn btn-cancel" 
                        onclick="window.location.href='DishController'">Hủy</button>
            </div>
        </form>
    </div>
</body>
</html>
