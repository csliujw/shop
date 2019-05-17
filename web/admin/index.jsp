<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>网上商城后台管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/index.css"/>
    <script src="${pageContext.request.contextPath }/js/jquery-1.11.3.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui.js"></script>
</head>

<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <!--
            作者：695466632@qq.com
            时间：2018-07-09
            描述：导航栏
     -->
    <div class="layui-header">
        <div class="layui-logo">网上商城后台管理系统</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="images/007.png" class="layui-nav-img">${user.username}
                </a>
            </li>
            <li class="layui-nav-item">
                <a href="${pageContext.request.contextPath}">退了</a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black blog_side">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->

            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <!-- 用户借阅书籍操作 -->
                <li class="layui-nav-item">
                    <a href="javascript:;">商品一级分类管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="add_division layui-nav-itemed">添加商品一级分类</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="query_division layui-nav-itemed">查看商品一级分类</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">商品二级分类管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="add_subdivision layui-nav-itemed">添加商品二级分类</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="query_subdivision layui-nav-itemed">查看商品二级分类</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">商品信息管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="add_product">新增商品信息</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="query_product">查询图书信息</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">订单信息管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="query_order">查询订单信息</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">物流信息管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="query_orders">查询物流信息</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">用户信息管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="query_user">查询用户信息</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">信息物理删除</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="query_delete_division">商品一级类别</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="query_delete_subdivision">商品二级类别</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="query_delete_product">商品信息</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="query_delete_order">订单信息</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" class="query_delete_orders">物流信息</a>
                        </dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a class="" href="javascript:;">修改个人信息</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" class="updatePassword">修改密码</a   >
                        </dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body iframe-container">
        <iframe id="page" src="${pageContext.request.contextPath}/admin/division/watch.jsp"
                style="width: 100%;height: auto;height: 90%;"></iframe>
    </div>
    <div class="layui-footer">
        © www.baobaoxuxu.cn Payphone版权所有
    </div>
</div>
<script>
    //JavaScript代码区域
    layui.use('element', function () {
        let element = layui.element;
    });
    //新增商品一级类别
    $(".add_division").click(function () {
        $("#page").attr("src", "${pageContext.request.contextPath}/admin/division/write.jsp");
    });
    //查询所有商品一级类别
    $(".query_division").click(function () {
        $("#page").attr("src", "${pageContext.request.contextPath}/admin/division/watch.jsp");
    });
    //新增商品二级类别
    $(".add_subdivision").click(function () {
        $("#page").attr("src", "${pageContext.request.contextPath}/admin/subdivision/write.jsp");
    });
    //查询所有商品二级类别
    $(".query_subdivision").click(function () {
        $("#page").attr("src", "${pageContext.request.contextPath}/admin/subdivision/watch.jsp");
    });
    //新增商品
    $(".add_product").click(function () {
        $("#page").attr("src", "${pageContext.request.contextPath}/admin/product/write.jsp");
    });
    //查询所有商品
    $(".query_product").click(function () {
        $("#page").attr("src", "${pageContext.request.contextPath}/admin/product/watch.jsp");
    });
    //查询订单信息
    $(".query_order").click(function () {
        $("#page").attr("src", "${pageContext.request.contextPath}/admin/order/watch.jsp");
    });
    //查询物流信息
    $(".query_orders").click(function(){
        $("#page").attr("src","${pageContext.request.contextPath}/admin/orders/watch.jsp");
    });
    //查询用户信息
    $(".query_user").click(function(){
        $("#page").attr("src","${pageContext.request.contextPath}/admin/user/watch.jsp");
    });

    /**物理信息删除**/
    $(".query_delete_division").click(function(){
        $("#page").attr("src","${pageContext.request.contextPath}/admin/delete/watch_division.jsp");
    });
    $(".query_delete_subdivision").click(function(){
        $("#page").attr("src","${pageContext.request.contextPath}/admin/delete/watch_subdivision.jsp");
    });
    $(".query_delete_product").click(function(){
        $("#page").attr("src","${pageContext.request.contextPath}/admin/delete/watch_product.jsp");
    });
    $(".query_delete_order").click(function(){
        $("#page").attr("src","${pageContext.request.contextPath}/admin/delete/watch_order.jsp");
    });
    $(".query_delete_orders").click(function(){
        $("#page").attr("src","${pageContext.request.contextPath}/admin/delete/watch_orders.jsp");
    });

</script>
</body>

</html>