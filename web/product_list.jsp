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
            width: 100%;
        }

        .carousel-inner .item img {
            width: 100%;
            height: 300px;
        }

        .row p {
            margin: 0;
            text-align: center;
        }
    </style>
</head>

<body>


<!-- 引入header.jsp -->
<jsp:include page="/header.jsp"></jsp:include>


<div class="row" style="width: 1210px; margin: 0 auto;">
    <div class="col-md-12">
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/products/index.do">首页</a></li>
        </ol>
    </div>

    <c:forEach items="${products }" var="pro">
        <c:if test="${empty pro}">
            暂无商品
        </c:if>
        <c:if test="${pro!=null}">
            <div class="col-md-2" style="height:250px">
                <a href="${pageContext.request.contextPath }/products/detail.do?productId=${pro.productId}">
                    <img src="${pageContext.request.contextPath }/${pro.productImage}" width="170" height="170"
                         style="display: inline-block;">
                </a>
                <p>
                    <a href="${pageContext.request.contextPath }/products/detail.do?productId=${pro.productId}"
                       style='color: green'>${pro.productName }</a>
                </p>
                <p>
                    <font color="#FF0000"><s>市场价：&yen;${pro.productShopPrice }</s></font>
                </p>
                <p>
                    <font color="black">商城价：&yen;${pro.productMarketPrice }</font>
                </p>
            </div>
        </c:if>
    </c:forEach>
    <div id="append"></div>
    <div class="col-md-12">
        <p class="btn-default btn-success" id="more_product"
           style="height: 40px;border-radius: 3px;padding-top: 10px;margin-bottom: 10px;">查看更多</p>
    </div>
    <input style="display: none" value="${products[0].division.divisionId}" id="divisionId">
</div>
<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>

</body>
<script>
    let page = 2;//记录当前要请求数据的页数 最开始是第一页，所以从2开始请求
    let $appendDiv = $("#append");//在哪里追加内容
    let $divisionId = $("#divisionId").val();//检索条件
    //触发事件
    $("#more_product").click(function () {
        let values = "page=" + page + "&limit=24&division.divisionId=" + $divisionId;
        $.ajax({
            url: "${pageContext.request.contextPath}/products/more.do",
            dataType: "json",
            data: values,
            type: "POST",
            success: function (json) {
                if(json.length<1){
                    alert("没有商品啦~~")
                }
                let str="";
                str = concatStr(json,str);
                page = page + 1;
                $appendDiv.append(str);
                console.log(str);
            },
            error: function (json) {
            }
        })
    });

    function concatStr(json, str) {
        for (let i=0;i<json.length;i++) {
            str+=`<div class="col-md-2" style="height:250px">
            <a href="${pageContext.request.contextPath }/products/detail.do?productId=` + json[i].productId + `">
            <img src="/` + json[i].productImage + `" width='170' height='170' style="display: inline-block;">
            </a>
            <p>
            <a href="${pageContext.request.contextPath }/products/detail.do?productId=` + json[i].productId + `" style='color: green'>` + json[i].productName + `</a>
            </p>
            <p>
            <font color="#FF0000"><s>市场价：&yen;` + json[i].productMarketPrice +`</s></font><br>
            <font color="black">商城价：&yen;` + json[i].productShopPrice + `</font>
        </p>
        </div>`
        }
        return str;
    }
</script>
</html>