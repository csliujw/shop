<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商城首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<style>

    body {
        background: rgb(242, 242, 242);
    }

    .item-list {
        width: 280px;
        height: 330px;
        background: #fff;
        margin: 0px 15.5px 14px 0;
    }

    .index-ul {
        z-index: 800;
        list-style: none;
        font-size: 16px;
        height: 599px;
        width: 100%;
        background: rgb(19, 59, 69);
        color: whitesmoke;
        position: absolute;
        margin: 0;
        padding: 0;
        left: 15px;
    }

    .index-ul-li-data {
        display: none;
        width: 100%;
        width: 800px;
        height: 500px;
    }

    .index-ul > li {
        margin: 0px 00px 10px 0px;
        padding: 10px 20px 10px 60px;
    }

    .index-ul > li:hover {
        background: red;
    }

    .index-ul > li:hover > div {
        z-index: 1000;
        background: whitesmoke;
        display: block;
        position: absolute;
        top: 0px;
        left: 307px;
        color: black;
    }

    .detail-product {
        list-style: none;
        margin-top: 10px;
        margin-bottom: 10px;
        padding: 10px;
    }

    .detail-product img {
        width: 100px;
        height: 100px;
    }

    a {
        text-decoration: none;
        color: inherit;
    }
    p{
        margin: 21px 0 10px;
        text-align: center;
    }
</style>
<body>
<div class="container-fluid">

    <!-- 引入header.jsp -->
    <jsp:include page="/header.jsp"></jsp:include>

    <!-- 轮播图 -->
    <div class="container-fluid">
        <div class="col-md-1">
        </div>
        <div class="col-md-2">
            <ul class="index-ul">
                <br><br>
                <c:forEach items="${divisions}" var="item">
                    <li>${item.divisionName}
                        <div class="col-md-8 index-ul-li-data">
                            <ul class="detail-product">
                                <li>
                                    <div class="col-md-12">
                                        <c:forEach items="${item.subdivision}" var="subItem">
                                            <div class="col-md-3" style="margin-right: 10px">
                                                <a href="${pageContext.request.contextPath}/products/search.do?subdivision.subdivisionId=${subItem.subdivisionId}">
                                                    <div class="col-md-12" style="padding-left: 5px;padding-top: 20px">
                                                        <p style="margin: 15px 47px 11px;">${subItem.subdivisionName}</p>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="col-md-8">
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <!-- 轮播图的中的小点 -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>
                <!-- 轮播图的轮播图片 -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <img style="height: 599px;" src="${pageContext.request.contextPath}/img/1.jpg">
                        <div class="carousel-caption">
                            <!-- 轮播图上的文字 -->
                        </div>
                    </div>
                    <div class="item">
                        <img style="height: 599px" src="${pageContext.request.contextPath}/img/2.jpg">
                        <div class="carousel-caption">
                            <!-- 轮播图上的文字 -->
                        </div>
                    </div>
                    <div class="item">
                        <img style="height: 599px" src="${pageContext.request.contextPath}/img/3.jpg">
                        <div class="carousel-caption">
                            <!-- 轮播图上的文字 -->
                        </div>
                    </div>
                </div>

                <!-- 上一张 下一张按钮 -->
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>

    <c:forEach items="${productList}" var="list" varStatus="status">
        <div class="container-fluid">
            <div class="col-md-12">
                <div class="col-md-12">
                    <div class="col-md-9">
                        <h2 style="margin-left: 144px;">&nbsp;热门商品: ${list[0].division.divisionName}类</h2>
                    </div>
                    <div class="col-md-3" style="margin-right: 0px">
                        <h3 style="margin-left: 150px;"><a href="${pageContext.request.contextPath}/products/search.do?division.divisionId=${list[0].division.divisionId}">查看全部</a></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="col-md-10 col-md-offset-1">
                    <c:forEach items="${list}" var="product">
                        <div class="col-md-3 item-list">
                            <a href="${pageContext.request.contextPath}/products/detail.do?productId=${product.productId}">
                                <img src="/${product.productImage}" width="254px" height="220px"
                                     style="display: inline-block;margin-top: 15px;">
                            </a>
                            <p>${product.productName}</p>
                            <div style="text-align: center;">
                                <span style="color: red;"><s>市场价${product.productMarketPrice}</s></span>
                                &nbsp;&nbsp;
                                <span>商城价${product.productShopPrice}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:forEach>
    <!-- 引入footer.jsp -->
    <jsp:include page="/footer.jsp"></jsp:include>

</div>
</body>

</html>