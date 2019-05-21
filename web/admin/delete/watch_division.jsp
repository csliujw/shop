<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css" media="all">
</head>
<body>
<!-- 操作框 -->
<div style="margin-bottom: 10px;"></div>
<ul class="layui-tab-title main-tab-title">
    <li class="layui-this">查看商品一级类别</li>
</ul>
<div style="margin-top: 30px;"></div>
<div class="layui-form-item">
    <div class="layui-col-lg12">
        <label class="layui-form-label">删除操作</label>
        <div class="layui-inline">
            <button class="layui-btn" data-type="getCheckData">批量刪除</button>
        </div>
    </div>
    <hr/>
    <div class="layui-inline">
        <label class="layui-form-label">检索条件</label>
        <div class="layui-input-inline">
            <input type="text" name="searchDivisionName" id="searchDivisionName" class="layui-input" placeholder="类别名称">
        </div>
    </div>
    <button class="layui-btn" data-type="reload">查询</button>
</div>

<table id="test" lay-filter="test"></table>
<script type="text/html" id="autoIncrement">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath }/layui.js" charset="utf-8"></script>
<script>
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
                    content: json.message //这里content是一个普通的String
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

    layui.use(['table', 'form', 'layedit', 'laydate'], function () {
        let table = layui.table;
        let form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
        table.render({
            elem: '#test'  //绑定table表格  为了找到给那个表格插入数据<table></table> 
            , height: 700
            , url: '<%=request.getContextPath()%>/phy/divisionList.do'
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
                , {field: 'divisionName', title: '商品一级类别名称', width: 200, fixed: 'left', unresize: true}
                , {fixed: 'right', width: 80, align: 'center', toolbar: '#barDemo'}//
            ]]
        });
        //监听工具条
        table.on('tool(test)', function (obj) {
            let data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除么', function (index) {
                    let str = {"divisionId": data.divisionId};
                    deleteSingle(str, "phy/divisionDelete.do", obj);
                    layer.close(index);
                });
            }
        });
        //用的是渲染的table的id：contentTable
        let $ = layui.jquery, active = {
            getCheckData: function () {//获取选中数据
                let checkStatus = table.checkStatus('contentTable')
                    , data = checkStatus.data;
                let length = data.length;
                let array = "";
                for (let i = 0; i < length; i++) {
                    if (i < length - 1) {
                        array += data[i].divisionId + ",";
                    } else {
                        array += data[i].divisionId;
                    }
                }
                deletes(array, "phy/divisionDeleteBatch.do");
            }
            , reload: function () {
                let $searchDivisionName = $("#searchDivisionName").val();
                table.reload('contentTable', {
                    where: {
                        "divisionName": $searchDivisionName
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