<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.DishDAO" %>
<%@ page import="model.Dish" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Món Ăn</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #fafafa;
            padding: 20px;
            min-height: 100vh;
        }
        
        .page-header {
            max-width: 1200px;
            margin: 0 auto 40px;
            text-align: center;
            padding: 30px 0;
            border-bottom: 1px solid #e8e8e8;
        }
        
        .page-header h2 {
            color: #2c2c2c;
            font-size: 28px;
            font-weight: 400;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        
        .container {
            background: white;
            max-width: 1000px;
            margin: 0 auto;
            box-shadow: 0 5px 30px rgba(0,0,0,0.05);
        }
        
        .header {
            background: #2c2c2c;
            color: white;
            padding: 25px 40px;
            text-align: center;
            font-weight: 400;
            font-size: 20px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        
        .content {
            padding: 50px 40px;
        }
        
        .section {
            margin-bottom: 50px;
        }
        
        .section-title {
            font-weight: 500;
            margin-bottom: 25px;
            font-size: 16px;
            color: #2c2c2c;
            letter-spacing: 1px;
            text-transform: uppercase;
            padding-bottom: 15px;
            border-bottom: 2px solid #e8e8e8;
        }
        
        .table-dishes {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            border: 1px solid #e8e8e8;
        }
        
        .table-dishes th {
            background: #fafafa;
            border: 1px solid #e8e8e8;
            padding: 15px;
            font-weight: 500;
            text-align: left;
            color: #2c2c2c;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .table-dishes td {
            border: 1px solid #e8e8e8;
            padding: 15px;
            font-size: 14px;
            color: #333;
        }
        
        .table-cart {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            border: 1px solid #e8e8e8;
        }
        
        .table-cart th {
            background: #fafafa;
            border: 1px solid #e8e8e8;
            padding: 15px;
            font-weight: 500;
            text-align: left;
            color: #2c2c2c;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .table-cart td {
            border: 1px solid #e8e8e8;
            padding: 15px;
            font-size: 14px;
        }
        
        .table-cart .total-row {
            background: #2c2c2c;
            color: white;
            font-weight: 600;
        }
        
        .form-input {
            padding: 12px;
            border: 1px solid #e8e8e8;
            font-size: 14px;
            width: 100%;
            background: #fafafa;
            transition: all 0.3s;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #2c2c2c;
            background: #ffffff;
        }
        
        .input-quantity {
            width: 80px;
            padding: 10px;
            border: 1px solid #e8e8e8;
            text-align: center;
            background: #fafafa;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 50px;
            justify-content: center;
        }
        
        .btn {
            padding: 15px 50px;
            border: 2px solid #2c2c2c;
            font-weight: 500;
            cursor: pointer;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s;
            background: #ffffff;
            color: #2c2c2c;
        }
        
        .btn-primary {
            background: #2c2c2c;
            color: white;
        }
        
        .btn-primary:hover {
            background: #1a1a1a;
        }
        
        .btn:hover {
            background: #2c2c2c;
            color: #ffffff;
        }
        
        .search-row {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            align-items: center;
        }
        
        .search-input {
            flex: 1;
            padding: 12px;
            border: 1px solid #e8e8e8;
            background: #fafafa;
            transition: all 0.3s;
        }
        
        .search-input:focus {
            outline: none;
            border-color: #2c2c2c;
            background: #ffffff;
        }
        
        .add-form {
            display: flex;
            gap: 15px;
            align-items: center;
            margin-bottom: 25px;
            padding: 25px;
            background: #fafafa;
            border: 1px solid #e8e8e8;
        }
        
        .add-form label {
            font-size: 13px;
            color: #2c2c2c;
            font-weight: 500;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>
    <div class="page-header">
        <h2>Đặt Món Online</h2>
    </div>
    
    <div class="container">
        <div class="header">Chọn Món Ăn</div>
        
        <div class="content">
            <div class="section">
                <form action="DishController" method="post">
                    <input type="hidden" name="action" value="searchForOrder">
                    <div class="search-row">
                        <label style="min-width: 100px; font-size: 13px; font-weight: 500; letter-spacing: 0.5px;">TÌM MÓN</label>
                        <input type="text" class="search-input" name="searchTerm" 
                               value="${param.searchTerm}" placeholder="Nhập tên món (vd: phở) hoặc loại món (vd: món chính)">
                        <button type="submit" class="btn btn-primary" style="padding: 12px 40px;">Tìm Kiếm</button>
                    </div>
                </form>
            </div>
            
            <div class="section">
                <div class="section-title">Danh Sách Món Ăn</div>
                <table class="table-dishes">
                    <thead>
                        <tr>
                            <th>Tên Món</th>
                            <th style="width: 150px;">Giá</th>
                            <th style="width: 150px; text-align: center;">Số Lượng</th>
                            <th style="width: 120px; text-align: center;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty dishList}">
                                <c:forEach var="dish" items="${dishList}">
                                    <c:if test="${dish.status == 'Còn món'}">
                                        <tr>
                                            <td>${dish.name}</td>
                                            <td>${dish.price} VND</td>
                                            <td style="text-align: center;">
                                                <form action="BillController" method="post" style="margin: 0; display: inline-flex; align-items: center; gap: 10px; justify-content: center;">
                                                    <input type="hidden" name="action" value="addToCart">
                                                    <input type="hidden" name="dishID" value="${dish.id}">
                                                    <input type="number" name="quantity" 
                                                           style="width: 70px; padding: 8px; border: 1px solid #e8e8e8; text-align: center; background: #fafafa;" 
                                                           value="1" min="1" max="99">
                                            </td>
                                            <td style="text-align: center;">
                                                    <button type="submit" 
                                                            style="padding: 8px 20px; background: #2c2c2c; color: white; border: 1px solid #2c2c2c; cursor: pointer; font-size: 12px; letter-spacing: 0.5px; text-transform: uppercase; transition: all 0.3s;"
                                                            onmouseover="this.style.background='#1a1a1a'" 
                                                            onmouseout="this.style.background='#2c2c2c'">
                                                        Thêm
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" style="text-align: center; color: #999; padding: 40px;">
                                        <c:choose>
                                            <c:when test="${not empty searchName}">
                                                Không tìm thấy món ăn
                                            </c:when>
                                            <c:otherwise>
                                                Nhập tên món để tìm kiếm
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            
            <div class="section">
                <div class="section-title">Giỏ Hàng</div>
                <table class="table-cart">
                    <thead>
                        <tr>
                            <th>Tên Món</th>
                            <th style="width: 120px;">Số Lượng</th>
                            <th style="width: 150px;">Thành Tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
                            DishDAO dishDAO = new DishDAO();
                            java.math.BigDecimal totalAmount = java.math.BigDecimal.ZERO;
                            
                            if (cart != null && !cart.isEmpty()) {
                                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                                    Dish dish = dishDAO.getDishInfo(entry.getKey());
                                    if (dish != null) {
                                        java.math.BigDecimal subtotal = dish.getPrice().multiply(java.math.BigDecimal.valueOf(entry.getValue()));
                                        totalAmount = totalAmount.add(subtotal);
                        %>
                        <tr>
                            <td><%= dish.getName() %></td>
                            <td style="text-align: center;"><%= entry.getValue() %></td>
                            <td><%= subtotal %> VND</td>
                        </tr>
                        <%
                                    }
                                }
                        %>
                        <tr class="total-row">
                            <td colspan="2" style="text-align: right; padding-right: 20px;">TỔNG CỘNG</td>
                            <td><%= totalAmount %> VND</td>
                        </tr>
                        <%
                            } else {
                        %>
                        <tr>
                            <td colspan="3" style="text-align: center; color: #999;">Giỏ hàng trống</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
            <div class="button-group">
                <button type="button" class="btn" 
                        onclick="window.location.href='TableController'">Quay Lại</button>
                <c:if test="${not empty cart}">
                    <form action="BillController" method="post" style="margin: 0;">
                        <input type="hidden" name="action" value="confirm">
                        <button type="submit" class="btn btn-primary">Xác Nhận</button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
