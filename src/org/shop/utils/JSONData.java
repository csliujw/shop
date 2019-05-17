package org.shop.utils;

import java.util.List;

public class JSONData<T> {

    private String code = "0";//状态码 默认为0 0是成功
    private String msg = "";//返回的消息 默认为空
    private String count;// 查询的数据的总数 为分页做准备
    private List<T> data;// 分页查询查询到的数据

    public JSONData(){}

    public JSONData(String count,List<T> data){
        this.count = count;
        this.data = data;
    }
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

}
