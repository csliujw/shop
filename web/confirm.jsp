<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>确认收货</title>
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
                    总价
                </div>
            </div>
            <div class="th th-amount">
                <div class="th-inner">
                    物流信息
                </div>
            </div>
            <div class="th th-sum">
                <div class="th-inner">
                    操作
                </div>
            </div>
        </div>
        <div class="OrderList">
            <div class="order-content" id="list-cont">
                <!-- 遍历购物车中的数据 -->
                <ul class="item-content layui-clear">
                    <li class="th th-item" class="left: -50px;">
                        <div class="item-cont">
                            <span class="th-su">${ordersItem.productName}</span>
                        </div>
                    </li>
                    <li class="th th-price">
                        <span class="th-su">${ordersItem.ordersTotal}</span>
                    </li>
                    <li class="th th-sum">
                        ${ordersItem.ordersLogistics}
                    </li>
                    <li class="th th-inner">
                        <div class="th-inner">
                            <button id="confirmOrders" style="margin-left: 72px;margin-top:-10px;"
                                    class="btn btn-success">确认收货
                            </button>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>
</body>
<script>
    layui.use(['table', 'form', 'layedit', 'laydate'], function () {
        let layer = layui.layer;
        $("#confirmOrders").click(function () {
            if ('${ordersItem.ordersLogistics}'.indexOf('已送达') != -1) {
                alert("请勿重复确认!");
                event.preventDefault();
            } else {
                let ordersId = '${ordersItem.ordersId}';
                console.log(ordersId);
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/arrive.do",    //请求的url地址
                    contentType: "application/json",
                    dataType: "json",   //返回格式为json
                    data: JSON.stringify({"ordersId": ordersId}),    //参数值
                    type: "POST",   //请求方式
                    success: function (json) {
                        if (json.message == 'OK') {
                            layer.msg("确认收货成功!");
                        } else {
                            layer.msg("确认失败，请稍后再试!");
                        }
                    },
                    error: function () {
                        layer.msg("网络故障，请检查你的网络！");
                    }
                });
            }
        });
    });

</script>
</html>