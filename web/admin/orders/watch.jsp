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
    <div class="layui-col-lg12">
        <label class="layui-form-label">删除操作</label>
        <div class="layui-inline">
            <button class="layui-btn" data-type="getCheckData">批量刪除</button>
        </div>
    </div>
    <hr/>
    <div class="layui-inline">
        <label class="layui-form-label">用户姓名</label>
        <div class="layui-input-inline">
            <input type="text" name="searchUserRealName" id="searchUserRealName" class="layui-input"
                   placeholder="请输入购买人真实姓名">
        </div>

        <label class="layui-form-label">商品名称</label>
        <div class="layui-input-inline">
            <input name="searchProductName" id="searchProductName" class="layui-input" placeholder="请输入商品名称">
        </div>
    </div>
    <button class="layui-btn" data-type="reload">查询</button>
</div>

<table id="logistics" lay-filter="logistics"></table>
<!--
    修改物流信息
    显示 商品名称
    总价
    收货人姓名
    收货人地址
    联系电话
    物流信息  修改项
    提示，同一快递的一起更新
-->
<!-- 隐藏的表单 -->
<div class="layui-row" id="updateOrdersForm" style="display: none;">
    <br/>
    <div class="layui-col-md10">
        <form class="layui-form">
            <input type="text" style="display: none" id="ordersId">
            <div class="layui-form-item">
                <input type="text" hidden="none" id="productId" name="productId">
                <label class="layui-form-label">商品名称</label>
                <div class="layui-input-block">
                    <input type="text" id="productName" lay-verify="required|title" class="layui-input"
                           disabled="disabled">
                </div>
                <br>
                <label class="layui-form-label">订单总价</label>
                <div class="layui-input-block">
                    <input type="text" id="ordersTotal" class="layui-input" disabled="disabled">
                </div>
                <br>
                <label class="layui-form-label">收货人姓名</label>
                <div class="layui-input-block">
                    <input type="text" id="userRealName" class="layui-input" disabled="disabled">
                </div>
                <br/>
                <label class="layui-form-label">收货人电话</label>
                <div class="layui-input-block">
                    <input type="text" id="userTelephone" class="layui-input" disabled="disabled">
                </div>
                <br>
                <label class="layui-form-label">收货人地址</label>
                <div class="layui-input-block">
                    <input type="text" id="userAddress" class="layui-input" disabled="disabled">
                </div>
                <br>
                <div class="layui-form-item">
                    <label class="layui-form-label">物流信息</label>
                    <div class="layui-input-block">
                        <textarea name="ordersLogistics" id="ordersLogistics" lay-verify="required"
                                  class="layui-textarea"></textarea>
                    </div>
                </div>
                <br>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="updateOrders" lay-filter="updateOrders" id="updateOrders">
                            立即提交
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/html" id="autoIncrement">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="arrive">确认到货</a>
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
                , {field: 'ordersTotal', title: '订单总价钱', width: 120, fixed: 'left'}
                , {field: 'userRealName', title: '收货人姓名', width: 120, fixed: 'left'}
                , {field: 'userAddress', title: '收货人地址', width: 200, fixed: 'left'}
                , {field: 'userTelephone', title: '联系电话', width: 160}
                , {field: 'ordersLogistics', title: '物流信息', width: 280}
                , {field: 'ordersTime', title: '订单提交时间', width: 160}
                , {field: 'ordersDate', title: '收货时间', width: 160}
                , {
                    field: 'ordersState',
                    title: '是否到货',
                    width: 120,
                    templet: "<div>{{d.ordersState=='0'?'暂未到货':'已经送达'}}</div>"
                }
                , {fixed: 'right', width: 200, align: 'center', toolbar: '#barDemo'}//
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
            } else if (obj.event === 'arrive') {
                //確認收貨
                layer.confirm('确认未经用户允确认收货吗?', function (index) {
                    let str = {"ordersId": data.ordersId};
                    update(JSON.stringify(str), "orders/arrive.do");
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                layer.open({
                    type: 1,
                    title: "修改物流信息 ",
                    area: ['600px', '525px'],
                    content: $("#updateOrdersForm"),//引用的弹出层的页面层的方式加载修改界面表单
                    success: function (layero, index) {
                        //数据回显
                        $("#productName").val(data.productName);
                        $("#ordersTotal").val(data.ordersTotal);
                        $("#userRealName").val(data.userRealName);
                        $("#ordersLogistics").val(data.ordersLogistics);
                        $("#userTelephone").val(data.userTelephone);
                        $("#userAddress").val(data.userAddress);
                        $("#ordersId").val(data.ordersId);
                    }
                });
                form.on('submit(updateOrders)', function (data) {
                    //获得数据
                    let $ordersLogistics = $("#ordersLogistics").val();
                    let $ordersId = $("#ordersId").val();
                    let jsonStr = {
                        "ordersLogistics": $ordersLogistics,
                        "ordersId": $ordersId
                    };
                    update(JSON.stringify(jsonStr), "orders/update.do");
                    event.preventDefault();
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
                let $userRealName = $("#searchUserRealName").val();
                table.reload('contentTable', {
                    where: {
                        "productName": $productName,
                        "userRealName": $userRealName,
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