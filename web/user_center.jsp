<%--
  Created by IntelliJ IDEA.
  User: 69546
  Date: 2019/5/6
  Time: 18:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户中心</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/layui.js"></script>
</head>
<body>
<!-- 引入header.jsp -->
<jsp:include page="/header.jsp"></jsp:include>
<div class="container-fluid">
    <div class="col-lg-12 col-md-12 col-xs-12">
        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
                    <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne"
                           aria-expanded="false"
                           aria-controls="collapseOne">
                            用户个人信息
                        </a>
                    </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                    <div class="panel-body">
                        <div class="col-lg-12 col-md-12 col-xs-12">
                            <div class="col-lg-1 col-md-1 col-xs-1"><label for="userRealName">用户名</label></div>
                            <div class="col-lg-10 col-md-10 col-xs-10"><input type="text" id="userRealName"
                                                                              name="userRealName" class="form-control"
                                                                              aria-describedby="helpBlock"
                                                                              value="${userInfo.userRealName}"
                                                                              readonly="readonly"></div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12"><br/></div>
                        <div class="col-lg-12 col-md-12 col-xs-12">
                            <div class="col-lg-1 col-md-1 col-xs-1"><label for="userRealName">用户名昵称</label></div>
                            <div class="col-lg-10 col-md-10 col-xs-10"><input type="text" id="userUsername"
                                                                              name="userUsername" class="form-control"
                                                                              aria-describedby="helpBlock"
                                                                              value="${userInfo.userUsername}"
                                                                              readonly="readonly"></div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12"><br/></div>
                        <div class="col-lg-12 col-md-12 col-xs-12">
                            <div class="col-lg-1 col-md-1 col-xs-1"><label for="userAddress">用户地址</label></div>
                            <div class="col-lg-10 col-md-10 col-xs-10"><input type="text" class="form-control"
                                                                              aria-describedby="helpBlock"
                                                                              value="${userInfo.userAddress}"
                                                                              readonly="readonly"></div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12"><br/></div>
                        <div class="col-lg-12 col-md-12 col-xs-12">
                            <div class="col-lg-1 col-md-1 col-xs-1"><label for="userTelephone">用户电话</label></div>
                            <div class="col-lg-10 col-md-10 col-xs-10"><input type="text" class="form-control"
                                                                              aria-describedby="helpBlock"
                                                                              value="${userInfo.userTelephone}"
                                                                              readonly="readonly"></div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12"><br/></div>
                        <div class="col-lg-12 col-md-12 col-xs-12">
                            <div class="col-lg-offset-1 col-md-offset-1 col-xs-offset-1 col-lg-10 col-md-10 col-xs-10">
                                <div class="alert alert-info" role="alert">修改个人密码</div>
                            </div>
                            <div class="col-lg-offset-1 col-md-offset-1 col-xs-offset-1 col-lg-10 col-md-10 col-xs-10">
                                <form class="col-lg-12 col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="userPassword">旧密码</label>
                                        <input type="password" class="form-control" id="userPassword"
                                               name="userPassword"
                                               required="required">
                                    </div>
                                    <div class="form-group">
                                        <label for="newPwd">新密码</label>
                                        <input type="password" class="form-control" id="newPwd" name="newPwd"
                                               required="required">
                                    </div>
                                    <div class="form-group">
                                        <label for="renewPwd">确认密码</label>
                                        <input type="password" class="form-control" id="renewPwd" name="renewPwd"
                                               required="required">
                                    </div>
                                    <div class="form-group">
                                        <button class="form-control btn-block btn-success" id="updatePassowrd">修改密码
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingTwo">
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                           href="#collapseTwo"
                           aria-expanded="false" aria-controls="collapseTwo">
                            订单信息
                        </a>
                    </h4>
                </div>
                <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                    <div class="panel-body" style="text-align: center;">
                        <div>
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation"><a href="#unpaymentOrders" aria-controls="unpaymentOrders"
                                                           role="tab" id="aunpaymentOrders"
                                                           data-toggle="tab">未付款订单</a></li>
                                <li role="presentation"><a href="#paymentOrders" aria-controls="paymentOrders"
                                                           role="tab"
                                                           id="apaymentOrders"
                                                           data-toggle="tab">已付款订单</a></li>
                            </ul>
                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane" id="unpaymentOrders">
                                    <div class="row">
                                        <div class="col-lg-12" style="line-height: 110px;">
                                            <div class="col-lg-3 col-md-3 col-xs-3">商品名称</div>
                                            <div class="col-lg-2 col-md-2 col-xs-2">商品图片</div>
                                            <div class="col-lg-3 col-md-3 col-xs-3">商品价格</div>
                                            <div class="col-lg-1 col-md-1 col-xs-1">数目</div>
                                            <div class="col-lg-1 col-md-1 col-xs-1">总价</div>
                                            <div class="col-lg-1 col-md-1 col-xs-1">操作</div>
                                        </div>
                                        <hr/>

                                        <div class="form-group">
                                            <input type="button" class="form-control btn-success"
                                                   id="lookMoreUnpaymentOrders" value="查看更多未付款订单">
                                        </div>
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane" id="paymentOrders">
                                    <div class="row">
                                        <div class="col-lg-12" style="line-height: 110px;">
                                            <div class="col-lg-3 col-md-3 col-xs-3">商品名称</div>
                                            <div class="col-lg-2 col-md-2 col-xs-2">商品图片</div>
                                            <div class="col-lg-1 col-md-1 col-xs-1">商品价格</div>
                                            <div class="col-lg-1 col-md-1 col-xs-1">数目</div>
                                            <div class="col-lg-1 col-md-1 col-xs-1">总价</div>
                                            <div class="col-lg-4 col-md-4 col-xs-4">物流信息</div>
                                        </div>
                                        <hr/>
                                        <div class="form-group">
                                            <input type="button" class="form-control btn-success"
                                                   id="lookMorePaymentOrders"
                                                   value="查看更多已付款信息">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingThree">
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                           href="#collapseThree"
                           aria-expanded="false" aria-controls="collapseThree">
                            修改收货信息
                        </a>
                    </h4>
                </div>
                <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                    <div class="panel-body">
                        <form class="col-lg-12 col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="userTelephone">手机号</label>
                                <input type="tel" class="form-control" id="userTelephone" name="userTelephone"
                                       required="required" value="${userInfo.userTelephone}">
                            </div>
                            <div class="form-group">
                                <label for="userAddress">收货地址</label>
                                <input type="text" class="form-control" id="userAddress" name="userAddress"
                                       required="required" value="${userInfo.userAddress}">
                            </div>
                            <div class="form-group">
                                <input type="button" class="form-control btn-success" id="updateGetInfo" value="修改收货信息">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>
</body>
<script src="layui.js"></script>

<script>
    let unStart = 0;
    let unEnd = 6;
    let Start = 0;
    let End = 6;

    /**
     * @param {Object} urls 服务器路径
     * @param {Object} values json格式数据需要转成字符串
     */
    function update(urls, values) {
        $.ajax({
            type: "post",
            url: urls,
            dataType: "json",
            data: values,
            contentType: "application/json",
            success: function (json) {
                layer.msg(json.message);
            },
            error: function () {
                layer.msg("操作失败，稍后再试！");
            }
        });
    }

    /**
     * @param {Object} urls 服务器路径全路径
     * @param {Object} values 需要传递的参数 JSON请转成str格式
     * @param {Object} divStr 服务器返回的数据将拼接至divStr
     */
    function getInfoUnpay(urls, values) {
        let divStr = "";
        $.ajax({
            type: "post",
            url: urls + "",
            dataType: "json",
            data: values,
            contentType: "application/json",
            success: function (json) {
                //未付款
                if (json.length == 0&&unStart!=0) {
                    layer.msg("无未付款订单数据!");
                    this.event.preventDefault();
                }
                for (let i = 0; i < json.length; i++) {
                    let url = "${pageContext.request.contextPath}/cart/pay.do?orderItemId=" + json[i].orderItemId;
                    divStr +=
                        `<div class="col-lg-12" style="line-height: 110px;">
						<div class="col-lg-3 col-md-3 col-xs-3">` + json[i].productName + `</div>
						<div class="col-lg-2 col-md-2 col-xs-2"><img style='width: 150px;height: 100px;' src='` + json[i].productImage + `'></div>
						<div class="col-lg-3 col-md-3 col-xs-3">` + json[i].productShopPrice + `</div>
						<div class="col-lg-1 col-md-1 col-xs-1">` + json[i].orderItemCount + `</div>
						<div class="col-lg-1 col-md-1 col-xs-1">` + json[i].orderItemSubtotal + `</div>
                        <div class="col-lg-1 col-md-1 col-xs-1"><a href='` + url + `'>付款</a></div>
						</div>
					<hr />`
                }
                $("#lookMoreUnpaymentOrders").before(divStr);
                unStart += 1;
                divStr = "";
            },
            error: function () {
                layer.msg("自动获取订单数据失败，稍后再试！");
            }
        });
    }

    function getInfoPay(urls, values) {
        let divStr = "";
        $.ajax({
            type: "post",
            url: urls + "",
            dataType: "json",
            data: values,
            contentType: "application/json",
            success: function (json) {
                console.log(json.length);
                if (json.length==0&&Start!=0) {
                    layer.msg("已无付款订单数据!");
                } else {
                    for (let i = 0; i < json.length; i++) {
                        divStr +=
                            `<div class="col-lg-12" style="line-height: 110px;">
						<div class="col-lg-3 col-md-3 col-xs-3" title="点击商品名称 查看具体信息">` + json[i].productName + `</div>
						<div class="col-lg-2 col-md-2 col-xs-2"><img style='width: 150px;height: 100px;' src='` + json[i].productImage + `'></div>
						<div class="col-lg-1 col-md-1 col-xs-1">` + json[i].productShopPrice + `</div>
						<div class="col-lg-1 col-md-1 col-xs-1">` + json[i].orderItemCount + `</div>
						<div class="col-lg-1 col-md-1 col-xs-1">` + json[i].orderItemSubtotal + `</div>
                        <div class="col-lg-4 col-md-4 col-xs-4"><a class='lookwuliu' name='` + json[i].ordersLogistics + `'>` + json[i].ordersLogistics + `阿斯顿发大水发大水发射点发射点发射点发</a></div>
						</div>
					<hr />`
                    }
                    $("#lookMorePaymentOrders").before(divStr);
                    Start += 1;
                    divStr = "";
                }

            },
            error: function () {
                layer.msg("获取失败，稍后再试！");
            }
        });

    }

    layui.use(['form', 'layer'], function () {
        let layer = layui.layer;
        /*###############################加载订单数据并进行渲染####################################*/
        /** 加载未付款的信息 **/
        let values1 = {
            "userId": "${userInfo.userId}",
            "start": 0,
            "end": unEnd
        };
        let urls1 = "${pageContext.request.contextPath}/user/selectUnpay.do";
        getInfoUnpay(urls1, JSON.stringify(values1));
        /** 加载付款的信息 **/
        let values2 = {
            "userId": "${userInfo.userId}",
            "start": 0,
            "end": End
        };
        let urls2 = "${pageContext.request.contextPath}/user/selectPay.do";
        getInfoPay(urls2, JSON.stringify(values2));
        /*###################################################################*/

        //修改密码
        $("#updatePassowrd").click(function () {
            let values;
            let $oldPwd = $("#userPassword").val();
            let $renewPwd = $("#renewPwd").val();
            let $newPwd = $("#newPwd").val();
            if ($renewPwd.trim() != '' && $newPwd.trim() != '') {
                if ($renewPwd != $newPwd) {
                    layer.msg("两次密码不一致");
                    event.preventDefault();
                } else {
                    values = {
                        "userPassword": $oldPwd,
                        "newPassword": $newPwd,
                        "userId": '${userInfo.userId}'
                    }
                    let urls = "${pageContext.request.contextPath}/user/updatePassword.do";
                    layer.msg(urls);
                    update(urls, JSON.stringify(values));
                    event.preventDefault();
                    //执行修改密码的ajax操作
                }
            }
        });
        //修改 收货地址
        $("#updateGetInfo").click(function () {
            let values;
            let $userTelephone = $("#userTelephone").val();
            let $userAddress = $("#userAddress").val();
            if ($userTelephone == '' || $userAddress == '') return;
            values = {
                "userTelephone": $userTelephone,
                "userAddress": $userAddress,
                "userId": '${userInfo.userId}'
            }
            let urls = "${pageContext.request.contextPath}/user/updateAddress.do";
            update(urls, JSON.stringify(values));
            layer.msg("下次购物时开始生效!");
            event.preventDefault();
        });

        $("#lookMoreUnpaymentOrders").click(function () {
            let values = {
                "userId": "${userInfo.userId}",
                "start": unStart * unEnd,
                "end": unEnd
            };
            let urls = "${pageContext.request.contextPath}/user/selectUnpay.do";
            getInfoUnpay(urls, JSON.stringify(values));
        });
        $("#lookMorePaymentOrders").click(function () {
            let values = {
                "userId": "${userInfo.userId}",
                "start": Start * End,
                "end": End
            };
            let urls = "${pageContext.request.contextPath}/user/selectPay.do";
            getInfoPay(urls, JSON.stringify(values));
        });
        $("a[class='lookwuliu']").click(function () {
            console.log(123);
        })
    });
</script>
</html>

