<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<div style="margin-top: 30px;"></div>
<div class="layui-tab layui-tab-brief main-tab-container">
    <ul class="layui-tab-title main-tab-title">
        <li class="layui-this">修改密码</li>
    </ul>
    <div style="margin-top: 30px;"></div>
    <form class="layui-form" action="" id="updateForm">
        <div class="layui-form-item">
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-block">
                <input type="password" name="newpwd" id="newpwd" lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-block">
                <input type="password" name="renewpwd" id="renewpwd" lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="update" lay-filter="update" id="update">修改
                </button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath }/layui.js"></script>
<script>
    layui.use(
        ['form', 'layer'],
        function () {
            var form = layui.form, layer = layui.layer;
            //监听提交
            form.on('submit(update)', function (data) {
                let newpwd = $("#newpwd").val();
                let renewpwd = $("#renewpwd").val();
                console.log(newpwd);
                console.log(renewpwd);
                if (newpwd != renewpwd) {
                    layer.msg("两次密码不一致!");
                } else {
                    $.ajax({
                        type: "POST",// 方法类型
                        contentType: "application/json",
                        dataType: "json",// 预期服务器返回的数据类型
                        data: JSON.stringify({"adminPassword": newpwd, "adminId": '${admin.adminId}'}),
                        url: "${pageContext.request.contextPath}/admin/update.do",// url
                        success: function (json) {
                            if (json.codes == 'OK') {
                                layer.msg("修改成功，下次登录时生效!");
                            } else {
                                layer.msg("修改失败，请稍后再试!")
                            }
                        },
                        error: function (json) {
                            layer.msg("请检查网络是否正常!")
                        }
                    });
                }
                event.preventDefault();
            });
        });
</script>
</html>