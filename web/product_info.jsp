<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>会员登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- 引入自定义css文件 style.css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>

    <style>
        body {
            margin-top: 20px;
            margin: 0 auto;
        }

        .carousel-inner .item img {
            width: 100%;
            height: 300px;
        }
    </style>
</head>
<body>
<!-- 引入header.jsp -->
<jsp:include page="/header.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div
                style="border: 1px solid #e4e4e4; width: 930px; margin-bottom: 10px; margin: 0 auto; padding: 10px; margin-bottom: 10px;">
            <a href="${pageContext.request.contextPath}/products/index.do">首页&nbsp;&nbsp;&gt;</a>
            <a>${productDetail.division.divisionName}&nbsp;&nbsp;&gt;</a>
            <a>${productDetail.subdivision.subdivisionName}</a>
        </div>

        <div style="margin: 0 auto; width: 950px;">
            <div class="col-md-6">
                <img style="opacity: 1; width: 400px; height: 350px;" title=""
                     class="medium"
                     src="${pageContext.request.contextPath }/${productDetail.productImage}">
            </div>

            <div class="col-md-6">
                <div>
                    <strong>${productDetail.productName}</strong>
                </div>
                <div
                        style="border-bottom: 1px dotted #dddddd; width: 350px; margin: 10px 0 10px 0;">
                    <div>编号：${productDetail.productId}</div>
                </div>

                <div style="margin: 10px 0 10px 0;">
                    商城价: <strong style="color: #ef0101;">￥：${productDetail.productShopPrice}元/件</strong> 市场价：
                    <del>￥${productDetail.productMarketPrice}元/份</del>
                </div>

                <div style="margin: 10px 0 10px 0;">
                    促销: <a target="_blank" style="background-color: #66afe9;">限时抢购</a>
                </div>

                <div
                        style="padding: 10px; border: 1px solid #e7dbb1; width: 330px; margin: 15px 0 10px 0;; background-color: #fffee6;">
                    <div
                            style="border-bottom: 1px solid #faeac7; margin-top: 20px; padding-left: 10px;">
                        购买数量:
                        <input id="buyNum" name="buyNum" value="1" maxlength="4" size="10" type="text">
                    </div>
                    <div style="margin: 20px 0 10px 0;; text-align: center;">
                        <input value="加入购物车" type="button" class="btn-default btn-success btn-group" id="addCartItem">
                    </div>
                </div>
                <div>
                    <a href="javascript:history.go(-1)">返回列表页面</a>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div style="width: 950px; margin: 0 auto;">
            <div
                    style="background-color: #d3d3d3; width: 930px; padding: 10px 10px; margin: 10px 0 10px 0;">
                <strong>商品介绍</strong>
            </div>

            <div>
                <img src="${pageContext.request.contextPath }/${productDetail.productImage}">
            </div>

            <div
                    style="background-color: #d3d3d3; width: 930px; padding: 10px 10px; margin: 10px 0 10px 0;">
                <strong>商品参数</strong>
            </div>
            <div style="margin-top: 10px; width: 900px;">
                <table class="table table-bordered">
                    <tbody>
                    <tr class="active">
                        <th colspan="2">基本参数</th>
                    </tr>
                    <tr>
                        <th width="10%">一级子类</th>
                        <td width="30%">${productDetail.division.divisionName}
                    <tr>
                        <th width="10%">二级子类</th>
                        <td width="30%">${productDetail.subdivision.subdivisionName}</td>
                    </tr>
                    <tr>
                        <th width="10%">详细数据</th>
                        <td>${productDetail.productDetail}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>

</body>
<script src="${pageContext.request.contextPath}/layui.js"></script>
<script>
    layui.use(['form', 'layer'], function () {
        let layer = layui.layer;

        //添加商品信息至session中
        $("#addCartItem").click(function () {
            let values = {
                "product": {
                    "productName": "${productDetail.productName}",
                    "productId": "${productDetail.productId}",
                },
                "userId": "${userInfo.userId}",
                "buyNum": $("#buyNum").val(),
            };
            console.log(JSON.stringify(values));
            $.ajax({
                type: "post",
                contentType: "application/json",
                url: "${pageContext.request.contextPath}/cart/add.do",
                dataType: "json",
                data: JSON.stringify(values),
                success: function (json) {
                    if (json.code == "OK") {
                        layer.msg("添加成功");
                    } else {
                        layer.msg("添加失败");
                    }
                }
            });
        });
    });

</script>
</html>