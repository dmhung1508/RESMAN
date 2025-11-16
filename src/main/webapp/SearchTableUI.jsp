<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Bàn Đã Đặt</title>
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
            max-width: 700px;
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
        
        .form-group {
            margin-bottom: 30px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 12px;
            font-weight: 400;
            font-size: 13px;
            color: #2c2c2c;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .form-input {
            width: 100%;
            padding: 15px;
            border: 1px solid #e8e8e8;
            font-size: 14px;
            background: #fafafa;
            transition: all 0.3s;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #2c2c2c;
            background: #ffffff;
        }
        
        .table-result {
            width: 100%;
            border-collapse: collapse;
            margin-top: 40px;
            border: 1px solid #e8e8e8;
        }
        
        .table-result th {
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
        
        .table-result td {
            border: 1px solid #e8e8e8;
            padding: 20px 15px;
            font-size: 14px;
            color: #333;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 40px;
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
        
        .error-message {
            background: #fff5f5;
            color: #c53030;
            padding: 15px;
            margin-bottom: 25px;
            border-left: 3px solid #c53030;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <div class="page-header">
        <h2>Đặt Món Online</h2>
    </div>
    
    <div class="container">
        <div class="header">Tìm Bàn Đã Đặt</div>
        
        <div class="content">
            <c:if test="${not empty successMessage}">
                <div style="background: #f0fff4; color: #22543d; padding: 15px; margin-bottom: 25px; border-left: 3px solid #22543d; font-size: 14px;">
                    ${successMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div style="background: #e6f7ff; color: #0066cc; padding: 15px; margin-bottom: 25px; border-left: 3px solid #0066cc; font-size: 14px;">
                    ${message}
                </div>
            </c:if>
            
            <form action="TableController" method="post">
                <input type="hidden" name="action" value="searchByCustomer">
                
                <div class="form-group">
                    <label class="form-label">Tên khách hàng hoặc Số điện thoại</label>
                    <input type="text" class="form-input" name="customerInfo" 
                           value="${param.customerInfo}" placeholder="Nhập tên hoặc số điện thoại khách hàng" required>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Tìm Kiếm</button>
                </div>
            </form>
            
            <%
                if (request.getAttribute("foundTables") != null) {
                    java.util.List<model.Table> foundTables = (java.util.List<model.Table>) request.getAttribute("foundTables");
                    if (!foundTables.isEmpty()) {
            %>
                <table class="table-result">
                    <thead>
                        <tr>
                            <th>Thông tin bàn</th>
                            <th>Trạng thái</th>
                            <th style="width: 150px; text-align: center;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (model.Table table : foundTables) {
                        %>
                        <tr>
                            <td><%= table.getDescription() %></td>
                            <td><%= table.getStatus() %></td>
                            <td style="text-align: center;">
                                <form action="TableController" method="post" style="margin: 0;">
                                    <input type="hidden" name="action" value="select">
                                    <input type="hidden" name="tableId" value="<%= table.getId() %>">
                                    <button type="submit" class="btn btn-primary" style="padding: 10px 30px;">Chọn Bàn</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                    } else {
            %>
                <div style="text-align: center; padding: 40px; color: #999;">
                    Không tìm thấy bàn đã đặt cho khách hàng này
                </div>
            <%
                    }
                }
            %>
            
            <div class="button-group">
                <button type="button" class="btn" 
                        onclick="window.location.href='index.jsp'">Quay Lại</button>
            </div>
        </div>
    </div>
</body>
</html>
