package org.shop.utils;

import java.util.List;

public class JSONImage {
    private String code = "0";//状态码 默认为0 0是成功
    private String msg = "";//返回的消息 默认为空
    private List<Image> data;// 查询的数据的总数 为分页做准备

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

    public List<Image> getData() {
        return data;
    }

    public void setData(List<Image> data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "JSONImage{" +
                "code='" + code + '\'' +
                ", msg='" + msg + '\'' +
                ", data='" + data + '\'' +
                '}';
    }
}
