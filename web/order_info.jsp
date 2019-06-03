<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订单付款</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui.js"></script>
    <style>
        body {
            margin-top: 20px;
            margin: 0 auto;
        }

        .carousel-inner .item img {
            width: 100%;
            height: 300px;
        }

        .col-sm-11 {
            width: 91.66666667%;
            margin-bottom: 20px;
        }
    </style>

</head>

<body>
<!-- 引入header.jsp -->
<jsp:include page="/header.jsp"></jsp:include>
<br/>
<br/>
<div class="col-md-4 col-md-offset-6" style="margin-top: -39px; color: red">
    ${orderMessage}
</div>
<c:if test="${!empty currentOrderItemList}">
    <div class="container">
        <div class="content content-nav-base shopcart-content">
            <div class="cart w1200" style="padding-bottom: 30px">
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
                </div>
                <div class="OrderList">
                    <div class="order-content" id="list-cont">
                        <!-- 遍历提交至数据库的且存在于购物车中的数据  即 当前的订单信息 -->
                        <c:forEach items="${sessionScope.currentOrderItemList}" var="item">
                            <ul class="item-content layui-clear">
                                <li class="th th-item" class="left: -50px;">
                                    <div class="item-cont">
                                        <img src="/${item.product.productImage}">
                                        <div class="text">
                                            <div class="title">${item.product.productName}</div>
                                        </div>
                                    </div>
                                </li>
                                <li class="th th-price">
                                    <span class="th-su">${item.product.productShopPrice}</span>
                                </li>
                                <li class="th th-amount">
                                        ${item.buyNum}
                                </li>
                                <li class="th th-sum">
                                    <span class="sum">${item.subtotal}</span>
                                </li>
                            </ul>
                        </c:forEach>
                    </div>
                </div>

                <div class="FloatBarHolder layui-clear">
                    <div class="th total">
                        <p>应付：<span class="pieces-total">${sessionScope.cart.total}</span></p>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <hr/>
            <c:if test="${empty message}">
                <form id="orderForm" action="${pageContext.request.contextPath }/cart/orders.do" method="post"
                      style="margin-top: 5px; margin-left: 150px;">
                    <div class="form-group">
                        <label for="userAddress" class="col-sm-1 control-label">地址</label>
                        <div class="col-sm-11">
                            <input type="text" class="form-control" id="userAddress" name="userAddress"
                                   value="${userInfo.userAddress}" required="required">
                        </div>
                    </div>
                    <br/>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">收货人</label>
                        <div class="col-sm-11">
                            <input type="text" class="form-control" required="required" readonly="readonly"
                                   value="${userInfo.userRealName}">
                        </div>
                    </div>
                    <br/>
                    <div class="form-group">
                        <label for="userTelephone" class="col-sm-1 control-label">电话</label>
                        <div class="col-sm-11">
                            <input type="tel" class="form-control" id="userTelephone" name="userTelephone"
                                   required="required" value="${userInfo.userTelephone }">
                        </div>
                        <br/>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-12">
                            <input type="submit" class="form-control btn-default btn-success" id="pay" name="pay"
                                   value="确认订单">
                        </div>
                    </div>
                </form>
            </c:if>
            <hr/>
            <br/>
            <br/>
        </div>
    </div>
</c:if>


<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>

</body>

</html>