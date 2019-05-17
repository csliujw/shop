<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商城购物车</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui.js"></script>
    <!-- 引入自定义css文件 style.css -->
</head>
<style>
</style>
<body>
<!-- 引入header.jsp -->
<jsp:include page="/header.jsp"></jsp:include>
    <div class="content content-nav-base shopcart-content">
        <div class="cart w1200">
            <div class="cart-table-th">
                <div class="th th-item">
                    <div class="th-inner">
                        商品
                    </div>
                </div>
                <div class="th th-price">
                    <div class="th-inner">
                        单价
                    </div>
                </div>
                <div class="th th-amount">
                    <div class="th-inner">
                        数量
                    </div>
                </div>
                <div class="th th-sum">
                    <div class="th-inner">
                        小计
                    </div>
                </div>
                <div class="th th-op">
                    <div class="th-inner">
                        操作
                    </div>
                </div>
            </div>
            <div class="OrderList">
                <div class="order-content" id="list-cont">
                    <!-- 遍历购物车中的数据 -->
                    <c:forEach items="${sessionScope.cart.cartItems}" var="item">
                        <ul class="item-content layui-clear">
                            <li class="th th-item" class="left: -50px;">
                                <div class="item-cont">
                                    <img src="${pageContext.request.contextPath}/${item.value.product.productImage}">
                                    <div class="text">
                                        <div class="title">${item.key}</div>
                                    </div>
                                </div>
                            </li>
                            <li class="th th-price">
                                <span class="th-su">${item.value.product.productShopPrice}</span>
                            </li>
                            <li class="th th-amount">
                                    ${item.value.buyNum}
                            </li>
                            <li class="th th-sum">
                                <span class="sum">${item.value.subtotal}</span>
                            </li>
                            <li class="th th-op">
                                <a href="${pageContext.request.contextPath}/cart/remove.do?productName=${item.value.product.productName}"><span class="dele-btn">删除</span></a>
                            </li>
                        </ul>
                    </c:forEach>
                </div>
            </div>

            <div class="FloatBarHolder layui-clear">
                <div class="th Settlement">
                    <a href="${pageContext.request.contextPath}/cart/addProduct.do?userId=${userInfo.userId}"><button class="layui-btn" id="addProduct">结算</button></a>
                </div>
                <div class="th total">
                    <p>应付：<span class="pieces-total">${sessionScope.cart.total}</span></p>
                </div>
            </div>
        </div>
    </div>
<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>
</body>

</html>