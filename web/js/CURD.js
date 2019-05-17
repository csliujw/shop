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
        url: "${pageContext.request.contextPath }/" +  urls,// url
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