<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!-- 登录 注册 购物车... -->
<div class="container-fluid">
    <div class="col-md-4">
        假装有图片
        <%--<img src="img/logo2.png" />--%>
    </div>
    <div class="col-md-5">
    </div>
    <div class="col-md-3" style="padding-top:20px">
        <ol class="list-inline">
            <c:if test="${empty userInfo }">
                <li><a href="${pageContext.request.contextPath}/login.jsp">登录</a></li>
                <li><a href="${pageContext.request.contextPath}/register.jsp">注册</a></li>
            </c:if>
            <c:if test="${!empty userInfo }">
                <li style="color:green">欢迎您，${userInfo.userUsername }</li>
                <li><a href="${pageContext.request.contextPath }/user/logout.do">退出</a></li>
                <li><a href="${pageContext.request.contextPath }/user_center.jsp">个人中心</a></li>
                <li><a href="${pageContext.request.contextPath}/cart/currentOrder.do">购物车</a></li>
                <li><a href="${pageContext.request.contextPath }/order_info.jsp">当前订单</a></li>
            </c:if>
        </ol>
    </div>
</div>

<!-- 导航条 -->
<div class="container-fluid">
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/products/index.do">首页</a>
            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <form class="navbar-form navbar-right" role="search"
                      action="${pageContext.request.contextPath}/products/searchByName.do" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="商品名称" name="productName"
                               required="required">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>
            </div>
        </div>
    </nav>
</div>