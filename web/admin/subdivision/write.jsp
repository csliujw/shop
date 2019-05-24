<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<div style="margin-top: 30px;"></div>
<div class="layui-tab layui-tab-brief main-tab-container">
    <ul class="layui-tab-title main-tab-title">
        <li class="layui-this">新增商品二级类别</li>
    </ul>
    <div style="margin-top: 30px;"></div>
    <form class="layui-form" action="" id="addSubdivisionForm">
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-block">
                <input type="text" name="subdivisionName" lay-verify="required|title" autocomplete="off"
                       placeholder="请输入名称"
                       class="layui-input">
            </div>
            <br>
            <div class="layui-form-item">
                <label class="layui-form-label">单行选择框</label>
                <div class="layui-input-block">
                    <select name="divisionId" id="divisionId" lay-filter="aihao">
                        <c:forEach items="${divisions}" var="item" varStatus="s">
                            <option value="${item.divisionId}">${item.divisionName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="addSubdivision" lay-filter="addSubdivision" id="addSubdivision">
                    立即提交
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
            //自定义验证规则
            form.verify({
                title: function (value) {
                    if (value.length < 2) {
                        return '至少得2个字符!';
                    }
                }
            });

            //监听提交
            form.on('submit(addSubdivision)', function (data) {
                var params = $('#addSubdivisionForm').serializeArray();
                var values = {};
                for (var x in params) {
                    values[params[x].name] = params[x].value;
                }
                console.log(values);
                $.ajax({
                    type: "POST",// 方法类型
                    dataType: "json",// 预期服务器返回的数据类型
                    data: values,
                    url: "${pageContext.request.contextPath}/subdivision/add.do",// url
                    success: function (json) {
                        layer.alert("操作成功", {
                            title: json.message
                        })
                    },
                    error: function (json) {
                        layer.alert("操作失败", {
                            title: json.message
                        })
                    }
                });
                event.preventDefault();
            });
        });
</script>
</html>