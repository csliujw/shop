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
                   placeholder="购买人真实姓名">
        </div>
        <label class="layui-form-label">一级类别</label>
        <div class="layui-input-inline">
            <select name="searchDivisionName" id="searchDivisionName" lay-filter="aihao" class="layui-input">
                <option value="">---请选择---</option>
                <c:forEach items="${division}" var="item" varStatus="s">
                    <option value="${item.divisionId}">${item.divisionName}</option>
                </c:forEach>
            </select>
        </div>
        <label class="layui-form-label">二级类别</label>
        <div class="layui-input-inline">
            <select name="searchSubdivisionName" id="searchSubdivisionName" lay-filter="aihao" class="layui-input">
                <option value='' selected='selected'>---请选择---</option>
            </select>
        </div>
        <label class="layui-form-label">商品名称</label>
        <div class="layui-input-inline">
            <select name="searchSubdivisionName" id="searchProductName" lay-filter="aihao" class="layui-input">
                <option value='' selected='selected'>---请选择---</option>
            </select>
        </div>
        <label class="layui-form-label">购买时间段</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="buyTime" placeholder="">
        </div>
    </div>
    <button class="layui-btn" data-type="reload">查询</button>
</div>

<table id="logistics" lay-filter="logistics"></table>
<script type="text/html" id="autoIncrement">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="barDemo">
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

    //layui模块加载
    layui.use(['table', 'form', 'layedit', 'laydate', 'upload'], function () {
        let table = layui.table;
        let form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
        let upload = layui.upload;
        table.render({
            elem: '#logistics'  //绑定table表格  为了找到给那个表格插入数据<table></table>
            , height: 700
            , url: '<%=request.getContextPath()%>/orders/list.do'
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
                , {field: 'autoIncrement', width: 80, title: '排名', fixed: 'left', templet: '#autoIncrement'}
                , {field: 'productName', title: '商品名称', width: 160, fixed: 'left'}
                , {field: 'ordersId', title: '订单ID', width: 80, fixed: 'left'}
                , {field: 'ordersTotal', title: '订单总价钱', width: 120, fixed: 'left'}
                , {field: 'userRealName', title: '收货人', width: 120, fixed: 'left'}
                , {field: 'userAddress', title: '收货人地址', width: 200, fixed: 'left'}
                , {field: 'userTelephone', title: '联系电话', width: 160}
                , {field: 'ordersLogistics', title: '物流信息', width: 280}
                , {
                    field: 'ordersState',
                    title: '是否到货',
                    width: 120,
                    templet: "<div>{{d.ordersState=='0'?'暂未到货':'已经送达'}}</div>"
                }
                , {
                    field: 'ordersTime',
                    title: '到货日期',
                    width: 160,
                    templet: "<div>{{d.ordersTime!=''?d.ordersTime:'暂未到货'}}</div>"
                }
                , {fixed: 'right', width: 160, align: 'center', toolbar: '#barDemo'}//
            ]]
        });
        //监听工具条
        table.on('tool(logistics)', function (obj) {
            let data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除么', function (index) {
                    let str = {"ordersId": data.ordersId};
                    deleteSingle(str, "orders/delete.do", obj);
                    layer.close(index);
                });
            }
        });
        let $ = layui.jquery, active = {
            getCheckData: function () {//获取选中数据
                let checkStatus = table.checkStatus('contentTable')
                    , data = checkStatus.data;
                let length = data.length;
                let array = "";
                for (let i = 0; i < length; i++) {
                    if (i < length - 1) {
                        array += data[i].ordersId + ",";
                    } else {
                        array += data[i].ordersId;
                    }
                }
                console.log(array + "我时批量删除");
                //批量删除
                deletes(array, "orders/deletes.do");
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