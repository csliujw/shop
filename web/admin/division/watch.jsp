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
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
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

<!-- 隐藏的表单 -->
<div class="layui-row" id="updateDivisionForm" style="display: none;">
    <br><br>
    <div class="layui-col-md10">
        <form class="layui-form">
            <div class="layui-tab-item layui-show">
                <input type="text" hidden="none" id="divisionId" name="divisionId">
                <div class="layui-form-item">
                    <label class="layui-form-label">名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="divisionName" id="divisionName"
                               lay-verify="required" autocomplete="off" placeholder="请输入名称"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="updateBook" lay-filter="updateBook" id="updateBook">立即提交
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<table id="test" lay-filter="test"></table>
<script type="text/html" id="autoIncrement">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath }/layui.js" charset="utf-8"></script>
<script>
    //更新数据 传入json字符串 及项目名后面的url即可
    function update(str, urls) {
        $.ajax({
            type: "POST",// 方法类型
            dataType: "json",// 预期服务器返回的数据类型
            data: str,
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
                if (json.message.indexOf('成功') != -1) {
                    obj.del();
                }
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

    layui.use(['table', 'form', 'layedit', 'laydate'], function () {
        let table = layui.table;
        let form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
        table.render({
            elem: '#test'  //绑定table表格  为了找到给那个表格插入数据<table></table> 
            , height: 700
            , url: '<%=request.getContextPath()%>/division/list.do'
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
                , {fixed: 'right', width: 178, align: 'center', toolbar: '#barDemo'}//
            ]]
        });

        //自定义验证规则
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
        });
        //监听工具条
        table.on('tool(test)', function (obj) {
            let data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除么', function (index) {
                    let str = {"divisionId": data.divisionId};
                    deleteSingle(str, "division/delete.do", obj);
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                layer.open({
                    type: 1,
                    title: "修改商品一级类别信息 ",
                    area: ['520px', '200px'],
                    content: $("#updateDivisionForm"),//引用的弹出层的页面层的方式加载修改界面表单
                    success: function (layero, index) {
                        //数据回显
                        $("#divisionName").val(data.divisionName);
                        $("#divisionId").val(data.divisionId);
                    }
                });
                form.on('submit(updateBook)', function (data) {
                    let $divisionName = $("#divisionName").val();
                    let $divisionId = $("#divisionId").val();
                    let str = {
                        "divisionName": $divisionName,
                        "divisionId": $divisionId
                    };
                    update(str, "division/update.do");
                    //操作dom刷新数据 哈哈哈哈哈
                    obj.update({
                        divisionName: $divisionName,
                    });
                    event.preventDefault();
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
                deletes(array, "division/deletes.do");
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