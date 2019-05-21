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
    <li class="layui-this">查看订单信息</li>
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
                   placeholder="购买人真实姓名">
        </div>
        <label class="layui-form-label">商品名称</label>
        <div class="layui-input-inline">
            <input type="text" name="searchProductName" id="searchProductName" class="layui-input"
                   placeholder="商品名">
        </div>
        <label class="layui-form-label">一级类别</label>
        <div class="layui-input-inline">
            <select name="searchDivisionName" id="searchDivisionName" class="layui-input">
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
    </div>
    <button class="layui-btn" data-type="reload">查询</button>
</div>

<table id="order" lay-filter="order"></table>
<script type="text/html" id="autoIncrement">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
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
        //日期范围
        laydate.render({
            elem: '#searchBuyTime'
            , range: true
        });
        table.render({
            elem: '#order'  //绑定table表格  为了找到给那个表格插入数据<table></table>
            , height: 700
            , url: '<%=request.getContextPath()%>/phy/orderList.do'
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
                , {
                    field: 'productName',
                    title: '商品名称',
                    width: 160,
                    fixed: 'left',
                    templet: '<div>{{d.product.productName}}</div>'
                }
                , {
                    field: 'productShopPrice',
                    title: '商品单价',
                    width: 100,
                    fixed: 'left',
                    templet: '<div>{{d.product.productShopPrice}}</div>'
                }
                , {field: 'orderItemCount', title: '购买数目', width: 100, fixed: 'left'}
                , {field: 'orderItemSubtotal', title: '总价', width: 120, fixed: 'left'}
                , {
                    field: 'orderItemStatu',
                    title: '订单状态',
                    width: 120,
                    fixed: 'left',
                    templet: '<div>{{d.orderItemStatu==1?"已付款":"未付款"}}</div>'
                }
                , {
                    field: 'orderItemDate',
                    title: '订单创建时间',
                    width: 160,
                    fixed: 'left',
                    templet: '<div>{{d.orderItemDate}}</div>'
                }
                , {
                    field: 'userUsername',
                    title: '用户昵称',
                    width: 160,
                    fixed: 'left',
                    templet: '<div>{{d.user.userUsername}}</div>'
                }
                , {
                    field: 'userRealName',
                    title: '用户真实姓名',
                    width: 160,
                    fixed: 'left',
                    templet: '<div>{{d.user.userRealName}}</div>'
                }
                , {field: 'divisionName', title: '一级类别', width: 120, templet: '<div>{{d.division.divisionName}}</div>'}
                , {
                    field: 'subdivisionName',
                    title: '二级类别',
                    width: 120,
                    templet: '<div>{{d.subdivision.subdivisionName}}</div>'
                }
                , {fixed: 'right', width: 80, align: 'center', toolbar: '#barDemo'}//
            ]]
        });

        //监听工具条
        table.on('tool(order)', function (obj) {
            let data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除么', function (index) {
                    let str = {"orderItemId": data.orderItemId};
                    deleteSingle(str, "order/delete.do", obj);
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
                        array += data[i].orderItemId + ",";
                    } else {
                        array += data[i].orderItemId;
                    }
                }
                //批量删除
                deletes(array, "order/deletes.do");
            }
            , reload: function () {
                /**
                 * */
                let $searchUserRealName = $("#searchUserRealName").val();
                let $searchDivisionName = $("#searchDivisionName").val();
                let $searchSubdivisionName = $("#searchSubdivisionName").val();
                let $searchProductName = $("#searchProductName").val();

                table.reload('contentTable', {
                    where: {
                        "user.userRealName": $searchUserRealName,
                        "division.divisionId": $searchDivisionName,
                        "subdivision.subdivisionId": $searchSubdivisionName,
                        "product.productName": $searchProductName
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