<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head></head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>会员注册</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<!-- 引入表单校验jquery插件 -->
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
<script src="${pageContext.request.contextPath}/layui.js"></script>

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
        color: #3164af;
        font-size: 18px;
        font-weight: normal;
        padding: 0 10px;
    }

    .error {
        color: red
    }
</style>

</head>
<body>

<!-- 引入header.jsp -->
<jsp:include page="/header.jsp"></jsp:include>
<div class="container"
     style="width: 100%; background: url('img/bg.jpg');">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8"
             style="background: #fff; padding: 40px 80px; margin: 30px;">

            <form id="myform" class="form-horizontal" action="${pageContext.request.contextPath }/user/register.do"
                  method="post" style="margin-top: 5px;">
                <div class="form-group">
                    <label class="col-sm-6 control-label"><h2>欢迎注册</h2></label>
                </div>
                <div class="form-group">
                    <label for="userUsername" class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="userUsername" name="userUsername"
                               required="required"
                               placeholder="请输入用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label for="userPassword" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="userPassword" name="userPassword"
                               required="required"
                               placeholder="请输入密码">
                    </div>
                </div>
                <div class="form-group">
                    <label for="repassword" class="col-sm-2 control-label">确认密码</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="repassword" name="repassword"
                               required="required"
                               placeholder="请输入确认密码">
                    </div>
                </div>
                <div class="form-group">
                    <label for="userEmail" class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-6">
                        <input type="email" class="form-control" id="userEmail" name="userEmail" required="required"
                               placeholder="Email">
                    </div>
                </div>
                <div class="form-group">
                    <label for="userRealName" class="col-sm-2 control-label">真实姓名</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="userRealName" name="userRealName"
                               required="required"
                               placeholder="请输真实姓名">
                    </div>
                </div>
                <div class="form-group opt">
                    <label class="col-sm-2 control-label">性别</label>
                    <div class="col-sm-6">
                        <label class="radio-inline">
                            <input type="radio" name="userSex" value="男" checked="checked">男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="userSex" value="女">女
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="userBirthday" class="col-sm-2 control-label">出生日期</label>
                    <div class="col-sm-6">
                        <input type="date" class="form-control" name="userBirthday" id="userBirthday" value="1997-11-11"
                               required="required">
                    </div>
                </div>

                <div class="form-group">
                    <label for="code" class="col-sm-2 control-label">手机号</label>
                    <div class="col-sm-4">
                        <input type="tel" class="form-control" name="userTelephone" id="userTelephone"
                               required="required">
                    </div>
                    <div class="col-sm-3">
                        <button type="button" class="btn btn-success" style="margin-left: 10px" id="getCode">获取验证码
                        </button>
                    </div>
                </div>

                <div class="form-group">
                    <label for="code" class="col-sm-2 control-label">验证码</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" name="code" id="code" required="required">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" width="100" value="注册" name="submit"
                               id="button" class="btn btn-primary" style="width: 470px">
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-2"></div>
    </div>
</div>
<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>
</body>
<script>
    layui.use(['table', 'form', 'layedit', 'laydate', 'upload'], function () {
        let table = layui.table;
        let form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
        //校验数据
        $("#button").click(function () {
            if ($("#userPassword").val() != $("#repassword").val()) {
                layer.alert("两次密码不一致！")
                event.preventDefault();
            }
        });
        //获取验证码
        $("#getCode").click(function () {
            let tel = $("input[name='userTelephone']").val();
            if (tel.trim()==''){
                layer.msg("请输入手机号!!");
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/user/code.do",
                dataType: "text",
                data: "tel=" + tel,
                type: "POST",
                success: function (json) {
                    if (json == "OK") {
                        layer.msg("验证码已发送，请及时填写!")
                    } else {
                        layer.msg("请检查手机号是否正确!")
                    }
                },
                error: function (json) {
                    layer.msg("网络错误!");
                }
            });
            event.preventDefault();
        });

        //用户名检查
        $("#userUsername").blur(function () {
            let username = $("#userUsername").val();
            if(username.trim()=='') return;
            $.ajax({
                url: "${pageContext.request.contextPath}/user/checkUsername.do",
                dataType: "json",
                data: "username=" + username,
                type: "POST",
                success: function (json) {
                    layer.msg(json.code)
                },
                error: function (json) {
                    layer.msg(json.code)
                }
            });
        })
    })
</script>
</html>




