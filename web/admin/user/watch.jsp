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
<body>
<!-- 操作框 -->
<div style="margin-bottom: 10px;"></div>
<ul class="layui-tab-title main-tab-title">
    <li class="layui-this">查看用戶信息</li>
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
            <input type="text" name="searchUserRealName" id="searchUserRealName" class="layui-input"
                   placeholder="用户真实姓名">
        </div>
        <label class="layui-form-label">是否注销</label>
        <div class="layui-input-inline">
            <select name="is_delete" id="is_delete" class="layui-input">
                <option value="1">已激活</option>
                <option value="0">已注销</option>
            </select>
        </div>
    </div>
    <button class="layui-btn" data-type="reload">查询</button>
</div>

<table id="user" lay-filter="user"></table>
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
            type: "post",// 方法类型
            dataType: "json",// 预期服务器返回的数据类型
            contentType: "application/json",
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

    //layui模块加载
    layui.use(['table', 'form', 'layedit'], function () {
        let table = layui.table;
        let form = layui.form, layer = layui.layer, layedit = layui.layedit;

        table.render({
            elem: '#user'  //绑定table表格  为了找到给那个表格插入数据<table></table>
            , height: 700
            , url: '<%=request.getContextPath()%>/userM/list.do'
            , page: true
            , response: {
                statusName: 'code'
                , statusCode: '0'
                , msgName: 'msg'
                , countName: 'count'
                , dataName: 'data'
            }
            , limit: 10
            , id: 'contentTable'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'autoIncrement', width: 80, title: '序号', fixed: 'left', templet: '#autoIncrement'}
                , {field: 'userUsername', title: '用户昵称', width: 160, fixed: 'left'}
                , {field: 'userRealName', title: '用户姓名', width: 120, fixed: 'left'}
                , {field: 'userEmail', title: '用户邮箱', width: 200, fixed: 'left'}
                , {field: 'userTelephone', title: '用户电话', width: 120, fixed: 'left'}
                , {field: 'userBirthday', title: '用户生日', width: 120, fixed: 'left'}
                , {field: 'userSex', title: '性别', width: 80, fixed: 'left'}
                , {
                    field: 'userState',
                    title: '状态',
                    width: 160,
                    fixed: 'left',
                    templet: '<div>{{d.userState==1?"激活":"已注销"}}</div>'
                }
                , {field: 'userAddress', title: '住址', width: 250, fixed: 'left'}
                , {fixed: 'right', width: 160, align: 'center', toolbar: '#barDemo'}
            ]]
        });
        //监听工具条
        table.on('tool(user)', function (obj) {
            let data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除么', function (index) {
                    let str = {"userId": data.userId};
                    deleteSingle(JSON.stringify(str), "userM/delete.do", obj);
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
                        array += data[i].userId + ",";
                    } else {
                        array += data[i].userId;
                    }
                }
                //批量删除
                deletes(array, "userM/deletes.do");
            }
            , reload: function () {
                /**
                 * searchProductName searchProductOrHot searchDivisionName searchSubdivisionName
                 * */
                let $userRealName = $("#searchUserRealName").val();
                let $userState = $("#is_delete").val();
                table.reload('contentTable', {
                    where: {
                        "userRealName": $userRealName,
                        "userState": $userState
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