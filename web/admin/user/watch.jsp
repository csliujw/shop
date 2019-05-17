<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
    <script src="${pageContext.request.contextPath }/layui.js" charset="utf-8"></script>
</head>
<style>
    .layui-table-cell {
        height: 100px;
        line-height: 100px;
        text-align: center;
    }
</style>
<body>
<!-- 操作框 -->
<div style="margin-bottom: 10px;"></div>
<ul class="layui-tab-title main-tab-title">
    <li class="layui-this">查看商品信息</li>
</ul>
<div style="margin-top: 30px;"></div>
<div class="layui-form-item">
    <button class="layui-btn" data-type="getCheckData">批量刪除</button>
    <div class="layui-inline">
        <label class="layui-form-label">检索条件</label>
        <div class="layui-input-inline">
            <input type="text" name="searchUserRealName" id="searchUserRealName" class="layui-input"
                   placeholder="用户真实姓名/昵称">
        </div>
        <label class="layui-form-label">是否注销</label>
        <select name="is_delete" id="is_delete">
            <option value="0">未注销</option>
            <option value="0">已注销</option>
        </select>
    </div>
    <button class="layui-btn" data-type="reload">查询</button>
</div>

<table id="product" lay-filter="product"></table>
<script type="text/html" id="autoIncrement">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>

    //弄成一个工具类ECM6
    //更新数据 传入json字符串 及项目名后面的url即可
    function update(str, urls) {
        $.ajax({
            type: "POST",// 方法类型
            dataType: "json",// 预期服务器返回的数据类型
            data: str,
            contentType: 'application/json;charset=utf-8',
            url: "${pageContext.request.contextPath }/" + urls,// url
            success: function (json) {
                layer.open({
                    title: "操作信息",
                    content: json.message //这里content是一个普通的String
                });

                function close() {
                    layer.closeAll();
                }

                setTimeout(close, 2000);
            },
            error: function () {
                layer.open({
                    title: "操作信息",
                    content: "操作失败" //这里content是一个普通的String
                });
                event.preventDefault();
            }
        });
    }

    //删除单个数据 传入{id:value}格式数据及urls和obj对象（layui的对象）
    function deleteSingle(data, urls, obj) {
        $.ajax({
            type: "GET",// 方法类型
            dataType: "json",// 预期服务器返回的数据类型
            data: data,
            url: "${pageContext.request.contextPath }/" + urls,// url
            success: function (json) {
                layer.open({
                    title: "操作信息",
                    content: json.message
                });
                obj.del();
            },
            error: function () {
                layer.open({
                    title: "操作信息",
                    content: "操作失败"
                });
            }
        });
    }

    //批量输出 传入要输出数据的数组及urls
    function deletes(array, urls) {
        $.ajax({
            type: "POST",// 方法类型
            dataType: "json",// 预期服务器返回的数据类型
            data: {
                "ids": array
            },
            url: "${pageContext.request.contextPath }/" + urls,// url
            success: function (json) {
                layer.open({
                    title: "操作信息",
                    content: "删除成功,请刷新" //这里content是一个普通的String
                });
            },
            error: function () {
                layer.open({
                    title: "操作信息",
                    content: "删除失败" //这里content是一个普通的String
                });
            }
        });
    }

    //修改表单的二级联动初始数据
    function selectOption() {
        let divisionValue = $("select[name='divisionId']").val();
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
    }

    //二级联动
    $("#searchDivisionName").change(function () {
        let divisionValue = $("select[name='searchDivisionName']").val();
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
        $("#searchSubdivisionName").html(insert);
    });
    //layui模块加载
    layui.use(['table', 'form', 'layedit', 'laydate', 'upload'], function () {
        let table = layui.table;
        let form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
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
                    return layer.msg('上传成功' + imgUrl);
                }
            }
        });

        table.render({
            elem: '#product'  //绑定table表格  为了找到给那个表格插入数据<table></table>
            , height: 700
            , url: '<%=request.getContextPath()%>/product/list.do'
            , page: true
            , response: {
                statusName: 'code'
                , statusCode: '0'
                , msgName: 'msg'
                , countName: 'count'
                , dataName: 'data'
            }
            , limit: 10
            , id: 'contentTable'//标识符  找东西 找到他。 id 唯一。primary key 唯一
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'autoIncrement', width: 80, title: '排名', fixed: 'left', templet: '#autoIncrement'}
                , {field: 'productName', title: '商品名称', width: 160, fixed: 'left'}
                , {field: 'productMarketPrice', title: '市场价', width: 80, fixed: 'left'}
                , {field: 'productShopPrice', title: '商城价', width: 80, fixed: 'left'}
                , {
                    field: 'productImage',
                    title: '商品图片',
                    width: 120,
                    fixed: 'left',
                    templet: '<div><img src="${pageContext.request.contextPath}/{{ d.productImage }}"></div>'
                }
                , {field: 'productDate', title: '入库日期', width: 120, fixed: 'left'}
                , {
                    field: 'productOrHot',
                    title: '热门',
                    width: 60,
                    fixed: 'left',
                    templet: '<div>{{d.productOrHot==1?"热门":"不热门"}}</div>'
                }
                , {field: 'productDetail', title: '详情', width: 160, fixed: 'left'}
                , {field: 'divisionName', title: '一级类别', width: 120, templet: '<div>{{d.division.divisionName}}</div>'}
                , {
                    field: 'subdivisionName',
                    title: '二级类别',
                    width: 120,
                    templet: '<div>{{d.subdivision.subdivisionName}}</div>'
                }
                , {fixed: 'right', width: 160, align: 'center', toolbar: '#barDemo'}
            ]]
        });
        //监听工具条
        table.on('tool(product)', function (obj) {
            let data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除么', function (index) {
                    let str = {"productId": data.productId};
                    deleteSingle(str, "product/delete.do", obj);
                    layer.close(index);
                });
            }
        });
        //用的是渲染的table的id：contentTable
        //不是div 中的那个id
        let $ = layui.jquery, active = {
            getCheckData: function () {//获取选中数据
                let checkStatus = table.checkStatus('contentTable')
                    , data = checkStatus.data;
                let length = data.length;
                let array = "";
                for (let i = 0; i < length; i++) {
                    if (i < length - 1) {
                        array += data[i].productId + ",";
                    } else {
                        array += data[i].productId;
                    }
                }
                //批量删除
                deletes(array, "product/deletes.do");
            }
            , reload: function () {
                /**
                 * searchProductName searchProductOrHot searchDivisionName searchSubdivisionName
                 * */
                let $productName = $("#searchProductName").val();
                let $productOrHot = $("#searchProductOrHot").val();
                let $divisionName = $("#searchDivisionName").val();//其实获取的是select中option的val~~
                let $subdivisionName = $("#searchSubdivisionName").val();
                table.reload('contentTable', {
                    where: {
                        "productName": $productName,
                        "productOrHot": $productOrHot,
                        "divisionId": $divisionName,
                        "subdivisionId": $subdivisionName
                    }
                });
                form.render();
            }
        };
        $('i').on('click', function () {
            let type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('.layui-btn').on('click', function () {
            let type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('.demoTable .layui-btn').on('click', function () {
            let type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });

</script>
</body>
</html>