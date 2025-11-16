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
    <title>Quản Lý Món Ăn</title>
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
            max-width: 900px;
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
        
        .search-row {
            display: flex;
            gap: 15px;
            margin-bottom: 40px;
            align-items: center;
        }
        
        .search-input {
            flex: 1;
            padding: 12px;
            border: 1px solid #e8e8e8;
            background: #fafafa;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .search-input:focus {
            outline: none;
            border-color: #2c2c2c;
            background: #ffffff;
        }
        
        .table-dishes {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
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
        
        .btn-edit {
            background: #ffffff;
            color: #2c2c2c;
            padding: 8px 20px;
            border: 1px solid #e8e8e8;
            font-size: 12px;
        }
        
        .btn-edit:hover {
            background: #2c2c2c;
            color: white;
            border-color: #2c2c2c;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            justify-content: center;
        }
        
        .btn:hover {
            background: #2c2c2c;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="page-header">
        <h2>Quản Lý Nhân Viên</h2>
    </div>
    
    <div class="container">
        <div class="header">Quản Lý Món Ăn</div>
        
        <div class="content">
            <form action="DishController" method="post">
                <input type="hidden" name="action" value="search">
                <div class="search-row">
                    <input type="text" class="search-input" name="dishName" 
                           value="${searchName}" placeholder="Nhập tên món hoặc loại món cần tìm">
                    <button type="submit" class="btn btn-primary" style="padding: 12px 40px;">Tìm Kiếm</button>
                </div>
            </form>
            
            <c:if test="${not empty successMessage}">
                <div style="background: #f0fff4; color: #22543d; padding: 15px; margin-bottom: 25px; border-left: 3px solid #22543d; font-size: 14px;">
                    ${successMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div style="background: #fff5f5; color: #c53030; padding: 15px; margin-bottom: 25px; border-left: 3px solid #c53030; font-size: 14px;">
                    ${errorMessage}
                </div>
            </c:if>
            
            <table class="table-dishes">
                <thead>
                    <tr>
                        <th>Tên Món</th>
                        <th style="width: 150px; text-align: center;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty dishList}">
                            <c:forEach var="dish" items="${dishList}">
                                <tr>
                                    <td>${dish.name}</td>
                                    <td style="text-align: center;">
                                        <form action="DishController" method="post" style="margin: 0;">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="dishID" value="${dish.id}">
                                            <button type="submit" class="btn-edit">Chỉnh Sửa</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="2" style="text-align: center; color: #999;">
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
            
            <div class="button-group">
                <button type="button" class="btn" 
                        onclick="window.location.href='MainStaffUI.jsp'">Quay Lại</button>
            </div>
        </div>
    </div>
</body>
</html>
