<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
    <script src="${pageContext.request.contextPath }/layui.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/util/FormUtils.js"></script>
</head>
<body>
<div style="margin-top: 30px;"></div>
<div class="layui-tab layui-tab-brief main-tab-container">
    <ul class="layui-tab-title main-tab-title">
        <li class="layui-this">新增商品信息</li>
    </ul>
    <div style="margin-top: 30px;"></div>
    <form class="layui-form" id="addProductForm">
        <label class="layui-form-label">商品名称</label>
        <div class="layui-input-block">
            <input type="text" name="productName" lay-verify="required|title" autocomplete="off"
                   placeholder="请输入名称"
                   class="layui-input">
        </div>
        <br>
        <label class="layui-form-label">市场价格</label>
        <div class="layui-input-block">
            <input type="text" name="productMarketPrice" lay-verify="required|number" autocomplete="off"
                   placeholder="请输入名称"
                   class="layui-input">
        </div>
        <br>
        <label class="layui-form-label">商城价格</label>
        <div class="layui-input-block">
            <input type="text" name="productShopPrice" lay-verify="required|number" autocomplete="off"
                   placeholder="请输入名称"
                   class="layui-input">
        </div>
        <br>
        <label class="layui-form-label">是否热门</label>
        <div class="layui-input-block">
            <select name="productOrHot" lay-verify="required">
                <option value="0" selected="selected">不热门</option>
                <option value="1">热门</option>
            </select>
        </div>
        <br>
        <label class="layui-form-label">一级类别</label>
        <div class="layui-input-block">
            <select name="divisionId" id="divisionId" lay-filter="selectDivisionId">
                <option value="">---请选择---</option>
                <c:forEach items="${division}" var="item" varStatus="s">
                    <option value="${item.divisionId}">${item.divisionName}</option>
                </c:forEach>
            </select>
        </div>
        <br>
        <label class="layui-form-label">二级类别</label>
        <div class="layui-input-block">
            <select name="subdivisionId" id="subdivisionId" lay-verify="required">
                <option>请选择</option>
            </select>
        </div>
        <br>
        <label class="layui-form-label">商品详情</label>
        <div class="layui-input-block">
                    <textarea name="productDetail" placeholder="请输入内容" class="layui-textarea"
                              lay-verify="required"></textarea>
        </div>
        <br>
        <label class="layui-form-label">商品图片</label>
        <div class="layui-upload layui-input-block">
            <button type="button" class="layui-btn" id="uploadProductImage">上传图片</button>
            <div class="layui-upload-list">
                <img class="layui-upload-img" id="productImage" name="productImage">
                <p id="demoText"></p>
            </div>
        </div>
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="addProduct" lay-filter="addProduct"
                    id="addProduct">
                立即提交
            </button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath }/layui.js"></script>
<script>
    //layui模块加载
    layui.use(
        ['form', 'layer', 'upload'],
        function () {
            let form = layui.form, layer = layui.layer;
            let upload = layui.upload;
            //普通图片上传
            let imgUrl = "";//图片的地址
            let uploadInst = upload.render({
                elem: '#uploadProductImage'
                , url: '${pageContext.request.contextPath}/upload.do'
                , before: function (obj) {
                    obj.preview(function (index, file, result) {
                        $('#productImage').attr('src', result);
                    });
                    form.render();
                }
                , done: function (res) {
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('上传失败');
                    } else {
                        imgUrl = res.data[0].src;
                        return layer.msg('上传成功');
                    }
                }
            });
            //自定义验证规则
            form.verify({
                title: function (value) {
                    if (value.length < 2) {
                        return '至少得2个字符!';
                    }
                },
                number: function (value) {
                    if (isNaN(value)) {
                        return '请输入数字！'
                    } else if (value < 0) {
                        return '请输入大于0的数字!'
                    }
                }
            });
            //二级联动
            form.on('select(selectDivisionId)', function (data) {
                let divisionValue = $("select[name='divisionId']").val();
                console.log(divisionValue);
                let str = JSON.parse('${s}');
                let temp;
                for (let i = 0; i < str.length; i++) {
                    if (str[i].divisionId == divisionValue) {
                        temp = str[i].subdivision;
                    }
                }
                let insert = "<option value='' selected='selected'>请选择</option>";
                for (let x = 0; x < temp.length; x++) {
                    insert += "<option value=" + temp[x].subdivisionId + ">" + temp[x].subdivisionName + "</option>"
                }
                $("#subdivisionId").html(insert);
                form.render();
            });
            //监听提交
            form.on('submit(addProduct)', function (data) {
                let formUtils = new FormUtils();
                //将表单中的数据序列化为JSON格式数据
                let values = formUtils.serializeArray($('#addProductForm', false));
                values["productImage"] = imgUrl;
                values["division"] = {"divisionId": $("select[name='divisionId']").val()};
                values["subdivision"] = {"subdivisionId": $("select[name='subdivisionId']").val()};
                if (imgUrl == '') {
                    layer.msg('请上传图片！');
                } else {
                    layer.msg(imgUrl);
                    $.ajax({
                        type: "POST",// 方法类型
                        dataType: "json",// 预期服务器返回的数据类型
                        data: JSON.stringify(values),
                        contentType: 'application/json;charset=utf-8',
                        url: "${pageContext.request.contextPath}/product/add.do",// url
                        success: function (json) {
                            layer.msg(json.message);
                        },
                        error: function (json) {
                            layer.msg(json.message);
                        }
                    });
                }
                event.preventDefault();
            });
        });
</script>
</html>