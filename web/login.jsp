<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>会员登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/layui.js"></script>
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

        font {
            color: #666;
            font-size: 22px;
            font-weight: normal;
            padding-right: 17px;
        }

        .login-bg {
            width: 100%;
            height: 700px;
        }

        .login-bg {
            background: url('${pageContext.request.contextPath}/img/bg.jpg') no-repeat;
            height: 100%;
            width: 100%;
            overflow: hidden;
            background-size: cover;
        }

        .layui-tab {
            margin-left: 1000px;
            margin-top: 200px;
            background: #fff;
            width: 529px;
        }
    </style>
</head>
<body>

<!-- 引入header.jsp -->
<jsp:include page="/header.jsp"></jsp:include>
<div class="login-bg" style="height: 700px">
    <div style="margin-left: 300px"></div>
    <div>
        <div class="layui-tab" style="width:500px;">
            <h3 style="color:red;color: red;text-align: center;padding-top: 20px;"> ${message}</h3>
            <br>
            <ul class="layui-tab-title">
                <li class="layui-this">
                    <legend>密码登录</legend>
                </li>
                <li>
                    <legend>手机号登录</legend>
                </li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <form class="layui-form" action="${pageContext.request.contextPath}/user/login.do" method="post">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">用户名</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="userUsername" required="required"
                                           autocomplete="off"
                                           style="width: 403px;"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">密码</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="userPassword" required="required"
                                           autocomplete="off"
                                           style="width: 403px;"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item login-btn">
                            <div class="layui-input-block">
                                <button class="layui-btn"
                                        style="width: 404px; margin-left: -31px;background: #cfb2f6;">登录
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="layui-tab-item">
                    <form class="layui-form" action="${pageContext.request.contextPath}/user/loginTel.do" method="post">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">用户名</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="userUsername" required="required"
                                           autocomplete="off"
                                           style="width: 403px;"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">手机号</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="userTelephone" required="required" id="userTelephone"
                                           aria-required="true"
                                           style="width: 280px;"
                                           class="layui-input">

                                </div>
                                <div class="layui-input-inline" style="width: 50px;margin-left: 100px">
                                    <button class="layui-btn" id="getCode">获取验证码</button>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">验证码</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="code" required="required"
                                           autocomplete="off"
                                           style="width: 403px;"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item login-btn">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit="" lay-filter="demo1"
                                        style="width: 404px; margin-left: -31px;background: #cfb2f6;">登录
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    //注意：选项卡 依赖 element 模块，否则无法进行功能性操作
    layui.use(['element', 'layer'], function () {
        let element = layui.element;
        let layer = layui.layer;
    });

    $("#getCode").click(function () {
        let tel = $("input[name='userTelephone']").val();
        if (tel == '') {
            layer.msg("请输入手机号码！");
            event.preventDefault();
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/user/code.do",
            dataType: "text",
            data: "tel=" + tel,
            type: "POST",
            success: function (json) {
                if (json == "OK") {
                    layer.msg("验证码已发送请及时填写");
                } else {
                    layer.msg("请检查手机号是否正确");
                }
            },
            error: function (json) {
                layer.msg("网络错误！");
            }
        });
        event.preventDefault();
    })
</script>
<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>

</body>
</html>