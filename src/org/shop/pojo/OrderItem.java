package org.shop.pojo;

/**
 * 订单项
 * 其于用户属于一对一。
 * 与商品属于一对一，一个订单项对应一个商品
 */
public class OrderItem {
    private String orderItemId;
    private int orderItemCount;
    private double orderItemSubtotal;
    private Product product;
    private User user;
    private Division division;
    private Subdivision subdivision;
    private String ordersId;
    private String orderItemOrDelete;
    private String orderItemStatu;
    private String orderItemDate;

    public String getOrderItemDate() {
        return orderItemDate;
    }

    public void setOrderItemDate(String orderItemDate) {
        this.orderItemDate = orderItemDate;
    }

    public Division getDivision() {
        return division;
    }

    public void setDivision(Division division) {
        this.division = division;
    }

    public Subdivision getSubdivision() {
        return subdivision;
    }

    public void setSubdivision(Subdivision subdivision) {
        this.subdivision = subdivision;
    }

    public String getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(String orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderItemCount() {
        return orderItemCount;
    }

    public void setOrderItemCount(int orderItemCount) {
        this.orderItemCount = orderItemCount;
    }

    public double getOrderItemSubtotal() {
        return orderItemSubtotal;
    }

    public void setOrderItemSubtotal(double orderItemSubtotal) {
        this.orderItemSubtotal = orderItemSubtotal;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getOrdersId() {
        return ordersId;
    }

    public void setOrdersId(String ordersId) {
        this.ordersId = ordersId;
    }

    public String getOrderItemOrDelete() {
        return orderItemOrDelete;
    }

    public void setOrderItemOrDelete(String orderItemOrDelete) {
        this.orderItemOrDelete = orderItemOrDelete;
    }

    public String getOrderItemStatu() {
        return orderItemStatu;
    }

    public void setOrderItemStatu(String orderItemStatu) {
        this.orderItemStatu = orderItemStatu;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "orderItemId='" + orderItemId + '\'' +
                ", orderItemCount=" + orderItemCount +
                ", orderItemSubtotal=" + orderItemSubtotal +
                ", product=" + product +
                ", user=" + user +
                ", ordersId='" + ordersId + '\'' +
                ", orderItemOrDelete='" + orderItemOrDelete + '\'' +
                '}';
    }
}
