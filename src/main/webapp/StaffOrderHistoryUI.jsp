<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Kiểm tra đăng nhập
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
    <title>Lịch Sử Đơn Hàng - Nhân Viên</title>
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
            max-width: 1400px;
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
        
        .page-subtitle {
            color: #666;
            font-size: 14px;
            margin-top: 10px;
        }
        
        .container {
            background: white;
            max-width: 1400px;
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
        
        .stats-bar {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: #fafafa;
            padding: 25px;
            border: 1px solid #e8e8e8;
            text-align: center;
        }
        
        .stat-label {
            font-size: 12px;
            color: #999;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 32px;
            color: #2c2c2c;
            font-weight: 600;
        }
        
        .order-card {
            background: #ffffff;
            border: 1px solid #e8e8e8;
            margin-bottom: 30px;
            transition: all 0.3s;
        }
        
        .order-card:hover {
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }
        
        .order-header {
            background: #fafafa;
            padding: 20px 30px;
            border-bottom: 1px solid #e8e8e8;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            align-items: center;
        }
        
        .order-id {
            font-size: 16px;
            font-weight: 600;
            color: #2c2c2c;
            letter-spacing: 0.5px;
        }
        
        .order-date {
            font-size: 13px;
            color: #666;
        }
        
        .customer-info {
            font-size: 13px;
            color: #666;
        }
        
        .customer-name {
            font-weight: 500;
            color: #2c2c2c;
        }
        
        .order-body {
            padding: 30px;
        }
        
        .order-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
            padding-bottom: 30px;
            border-bottom: 1px solid #e8e8e8;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .info-label {
            font-size: 12px;
            color: #999;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        
        .info-value {
            font-size: 15px;
            color: #2c2c2c;
            font-weight: 500;
        }
        
        .table-items {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #e8e8e8;
        }
        
        .table-items th {
            background: #fafafa;
            border: 1px solid #e8e8e8;
            padding: 12px 15px;
            font-weight: 500;
            text-align: left;
            color: #2c2c2c;
            font-size: 12px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        
        .table-items td {
            border: 1px solid #e8e8e8;
            padding: 12px 15px;
            font-size: 14px;
            color: #333;
        }
        
        .table-items tr:hover {
            background: #fafafa;
        }
        
        .total-row {
            background: #2c2c2c !important;
            color: white !important;
            font-weight: 600;
        }
        
        .total-row td {
            color: white !important;
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
        
        .btn:hover {
            background: #2c2c2c;
            color: #ffffff;
        }
        
        .empty-state {
            text-align: center;
            padding: 80px 20px;
        }
        
        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }
        
        .empty-text {
            color: #999;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="page-header">
        <h2>Lịch Sử Đơn Hàng</h2>
        <div class="page-subtitle">Quản lý tất cả đơn hàng trong hệ thống</div>
    </div>
    
    <div class="container">
        <div class="header">Danh Sách Đơn Hàng</div>
        
        <div class="content">
            <c:choose>
                <c:when test="${not empty allOrders}">
                    <!-- Thống kê -->
                    <div class="stats-bar">
                        <div class="stat-card">
                            <div class="stat-label">Tổng Đơn Hàng</div>
                            <div class="stat-value">${allOrders.size()}</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">Tổng Doanh Thu</div>
                            <div class="stat-value">
                                <c:set var="totalRevenue" value="0" />
                                <c:forEach var="order" items="${allOrders}">
                                    <c:set var="totalRevenue" value="${totalRevenue + order.totalAmount}" />
                                </c:forEach>
                                <fmt:formatNumber value="${totalRevenue / 1000}" type="number" maxFractionDigits="0" />K
                            </div>
                        </div>
                    </div>
                    
                    <!-- Danh sách đơn hàng -->
                    <c:forEach var="bill" items="${bills}">
                        <div class="order-card">
                            <div class="order-header">
                                <div>
                                    <div class="order-id">ĐƠN #${bill.billID}</div>
                                </div>
                                <div>
                                    <div class="order-date">
                                        <fmt:formatDate value="${bill.billDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </div>
                                </div>
                                <div class="customer-info">
                                    <div class="customer-name">👤 ${bill.customerName}</div>
                                    <div>📞 ${bill.customerPhone}</div>
                                </div>
                                <div>
                                    <div class="info-value" style="color: #2c2c2c; font-size: 18px;">
                                        <fmt:formatNumber value="${bill.totalAmount}" type="number" groupingUsed="true" /> VNĐ
                                    </div>
                                </div>
                            </div>
                            
                            <div class="order-body">
                                <div class="order-info">
                                    <div class="info-item">
                                        <span class="info-label">Bàn</span>
                                        <span class="info-value">${bill.tableDescription}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">Trạng thái</span>
                                        <span class="info-value">${bill.status}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">Số món</span>
                                        <span class="info-value">${bill.orderItems.size()} món</span>
                                    </div>
                                </div>
                                
                                <table class="table-items">
                                    <thead>
                                        <tr>
                                            <th>Tên Món</th>
                                            <th style="width: 100px; text-align: center;">Số Lượng</th>
                                            <th style="width: 120px;">Đơn Giá</th>
                                            <th style="width: 150px;">Thành Tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${bill.orderItems}">
                                            <tr>
                                                <td>${item.dish.name}</td>
                                                <td style="text-align: center;">${item.quantity}</td>
                                                <td><fmt:formatNumber value="${item.dish.price}" type="number" groupingUsed="true" /> VNĐ</td>
                                                <td><fmt:formatNumber value="${item.lineTotal}" type="number" groupingUsed="true" /> VNĐ</td>
                                            </tr>
                                        </c:forEach>
                                        <tr class="total-row">
                                            <td colspan="3" style="text-align: right; padding-right: 20px;">TỔNG CỘNG</td>
                                            <td><fmt:formatNumber value="${bill.totalAmount}" type="number" groupingUsed="true" /> VNĐ</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">📋</div>
                        <div class="empty-text">Chưa có đơn hàng nào trong hệ thống</div>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <div class="button-group">
                <button type="button" class="btn" 
                        onclick="window.location.href='MainStaffUI.jsp'">Quay Lại</button>
            </div>
        </div>
    </div>
</body>
</html>

