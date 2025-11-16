<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.DishDAO" %>
<%@ page import="model.Dish" %>
<%@ page import="model.Customer" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.math.BigDecimal" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    Order savedOrder = (Order) request.getAttribute("savedOrder");
    String successMessage = (String) request.getAttribute("successMessage");
    DishDAO dishDAO = new DishDAO();
    BigDecimal grandTotal = BigDecimal.ZERO;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Đơn Hàng</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            max-width: 800px;
            width: 100%;
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
            padding: 40px 50px;
        }
        
        .message-text {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 30px;
            color: #2c2c2c;
            text-align: center;
        }
        
        .order-list {
            background: #fafafa;
            border: 2px solid #e8e8e8;
            margin-bottom: 30px;
            max-height: 400px;
            overflow-y: auto;
        }
        
        .order-item {
            padding: 20px;
            border-bottom: 1px solid #e8e8e8;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .dish-info {
            flex: 1;
        }
        
        .dish-name {
            font-size: 16px;
            font-weight: 500;
            color: #2c2c2c;
            margin-bottom: 5px;
        }
        
        .dish-details {
            font-size: 14px;
            color: #666;
        }
        
        .dish-price {
            text-align: right;
            min-width: 120px;
        }
        
        .quantity {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }
        
        .price {
            font-size: 16px;
            font-weight: 600;
            color: #d32f2f;
        }
        
        .total-section {
            background: #f5f5f5;
            padding: 20px;
            border: 2px solid #e8e8e8;
            margin-bottom: 30px;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .total-label {
            font-size: 18px;
            font-weight: 600;
            color: #2c2c2c;
        }
        
        .total-amount {
            font-size: 24px;
            font-weight: 700;
            color: #d32f2f;
        }
        
        .choice-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
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
            background: #ffffff;
            color: #2c2c2c;
        }
        
        .btn-yes {
            background: #2c2c2c;
            color: white;
        }
        
        .btn-yes:hover {
            background: #1a1a1a;
        }
        
        .btn:hover {
            background: #2c2c2c;
            color: #ffffff;
        }
        
        .empty-cart {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <% if (successMessage != null && savedOrder != null) { %>
    <!-- Success View -->
    <div class="container" style="max-width: 700px;">
        <div style="width: 100px; height: 100px; border: 3px solid #2c2c2c; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 40px; font-size: 48px; animation: scaleIn 0.6s ease-out;">✓</div>
        
        <style>
            @keyframes scaleIn {
                0% { transform: scale(0); }
                50% { transform: scale(1.1); }
                100% { transform: scale(1); }
            }
        </style>
        
        <div class="header" style="font-size: 32px; letter-spacing: 2px;">ĐẶT MÓN THÀNH CÔNG</div>
        
        <div class="content">
            <div style="color: #666; font-size: 16px; line-height: 1.8; margin-bottom: 30px; text-align: center;">
                Cảm ơn bạn đã đặt món. Đơn hàng của bạn đã được ghi nhận và đang được xử lý.
            </div>
            
            <div style="background: #fafafa; padding: 30px; margin-bottom: 30px; border: 1px solid #e8e8e8;">
                <h3 style="margin-bottom: 20px; color: #2c2c2c; font-size: 16px; font-weight: 500; letter-spacing: 1px; text-align: center;">THÔNG TIN ĐƠN HÀNG</h3>
                
                <div style="display: flex; justify-content: space-between; padding: 15px 0; border-bottom: 1px solid #e8e8e8;">
                    <span style="color: #666; font-weight: 400; font-size: 14px;">Mã đơn hàng</span>
                    <span style="color: #2c2c2c; font-weight: 500; font-size: 14px;">#<%= savedOrder.getOrderID() %></span>
                </div>
                
                <div style="display: flex; justify-content: space-between; padding: 15px 0; border-bottom: 1px solid #e8e8e8;">
                    <span style="color: #666; font-weight: 400; font-size: 14px;">Ngày đặt</span>
                    <span style="color: #2c2c2c; font-weight: 500; font-size: 14px;">Hôm nay</span>
                </div>
                
                <div style="display: flex; justify-content: space-between; padding: 20px 0 15px; border-top: 2px solid #2c2c2c; margin-top: 10px;">
                    <span style="color: #666; font-weight: 400; font-size: 14px;">Tổng tiền</span>
                    <span style="color: #2c2c2c; font-weight: 600; font-size: 18px;"><%= String.format("%,d", savedOrder.getTotalAmount().intValue()) %> VNĐ</span>
                </div>
            </div>
            
            <div style="background: #fafafa; color: #2c2c2c; padding: 20px; margin-bottom: 30px; font-size: 14px; line-height: 1.8; border-left: 3px solid #2c2c2c;">
                <strong>Lưu ý:</strong> Vui lòng đến nhà hàng đúng giờ đã đặt. 
                Nhân viên sẽ phục vụ các món ăn cho bạn ngay khi bạn đến.
            </div>
            
            <div style="text-align: center;">
                <a href="index.jsp" class="btn btn-yes">Về Trang Chủ</a>
            </div>
        </div>
    </div>
    
    <% } else { %>
    <!-- Confirmation View -->
    <div class="container">
        <div class="header">Xác Nhận Đơn Hàng</div>
        
        <div class="content">
            <div class="message-text">
                Vui lòng kiểm tra lại đơn hàng của bạn
            </div>
            
            <div class="order-list">
                <%
                if (cart != null && !cart.isEmpty()) {
                    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                        Dish dish = dishDAO.getDishInfo(entry.getKey());
                        if (dish != null) {
                            int quantity = entry.getValue();
                            BigDecimal lineTotal = dish.getPrice().multiply(BigDecimal.valueOf(quantity));
                            grandTotal = grandTotal.add(lineTotal);
                %>
                <div class="order-item">
                    <div class="dish-info">
                        <div class="dish-name"><%= dish.getName() %></div>
                        <div class="dish-details">
                            Đơn giá: <%= String.format("%,d", dish.getPrice().intValue()) %> VNĐ
                        </div>
                    </div>
                    <div class="dish-price">
                        <div class="quantity">Số lượng: <%= quantity %></div>
                        <div class="price"><%= String.format("%,d", lineTotal.intValue()) %> VNĐ</div>
                    </div>
                </div>
                <%
                        }
                    }
                } else {
                %>
                <div class="empty-cart">
                    Giỏ hàng trống
                </div>
                <%
                }
                %>
            </div>
            
            <% if (cart != null && !cart.isEmpty()) { %>
            <div class="total-section">
                <div class="total-row">
                    <span class="total-label">TỔNG CỘNG:</span>
                    <span class="total-amount"><%= String.format("%,d", grandTotal.intValue()) %> VNĐ</span>
                </div>
            </div>
            <% } %>
            
            <div class="choice-buttons">
                <form action="BillController" method="post" style="margin: 0;">
                    <input type="hidden" name="action" value="save">
                    <%
                    // Kiểm tra xem có thông tin customer chưa
                    model.Customer currentCustomer = (model.Customer) session.getAttribute("currentCustomer");
                    String customerPhone = (String) session.getAttribute("customerPhone");
                    
                    if (currentCustomer == null && (customerPhone == null || customerPhone.isEmpty())) {
                    %>
                    <div style="margin: 20px 0; padding: 15px; background: #f5f5f5; border-radius: 8px;">
                        <label style="display: block; margin-bottom: 10px; font-weight: 500;">Thông tin khách hàng:</label>
                        <input type="text" name="customerName" placeholder="Tên khách hàng" 
                               style="width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 4px;" required>
                        <input type="text" name="customerPhone" placeholder="Số điện thoại" 
                               style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;" required>
                    </div>
                    <% } %>
                    <button type="submit" class="btn btn-yes" <%= (cart == null || cart.isEmpty()) ? "disabled" : "" %>>Xác Nhận</button>
                </form>
                <button type="button" class="btn" 
                        onclick="window.location.href='SelectDish.jsp'">Quay Lại</button>
            </div>
        </div>
    </div>
    <% } %>
</body>
</html>
