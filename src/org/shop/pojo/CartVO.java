package org.shop.pojo;

import java.util.List;

public class CartVO {
    private String ordersId;
    private List<CartItem> list;

    public String getOrdersId() {
        return ordersId;
    }

    public void setOrdersId(String ordersId) {
        this.ordersId = ordersId;
    }

    public List<CartItem> getList() {
        return list;
    }

    public void setList(List<CartItem> list) {
        this.list = list;
    }
}
