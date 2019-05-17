/**
 * 该插件基于JQuery
 */
class FormUtils {
    constructor() {
        console.log("这是一个表单工具类，用于序列化表单的!")
    }

    /**
     *表单数据序列化 isStr为true时表示返回字符串
     */
    serializeArray(formID,isStr) {
        var values = {};
        var params = formID.serializeArray();
        for (var temp in params) {
            values[params[temp].name] = params[temp].value;
        }
        if(isStr==true){
            return JSON.stringify(values);
        }else{
            return values;
        }
    }

    //获取表单数据进行异步操作 增删改都可
    addForm(urlStr, values) {
        var result = false;
        $.ajax({
            url: ulrStr,
            dataType: "json",
            async: true,
            data: values,
            type: "POST",
            success: function (json) {
                result = true;
                console.log("success");
                return result;
            },
            error: function (json) {
                console.log("error");
                return result;
            }
        });
    }

    //获取表单数据 异步查询
    select(urlStr, values) {
        var responseValues = "";
        $.ajax({
            url: ulrStr,
            dataType: "json",
            async: true,
            data: values,
            type: "POST",
            success: function (json) {
                responseValues = json;
                console.log("操作成功")
            },
            error: function (json) {
                console.log("操作失败")
            }
        });
        return responseValues;
    }
}
