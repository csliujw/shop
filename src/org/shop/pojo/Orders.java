package org.shop.pojo;

/**
 * 订单信息
 * 主要为显示物流信息 用户信息 商品信息
 * 通过order_item表中的orders_id 与之关联
 * orders与order_item 是一对多的关系
 */
public class Orders {
    private String ordersId;
    private String ordersTime;
    private String ordersDate;
    private String ordersTotal;
    private String ordersState;//用户是否已接收快递 用户自行操作
    private String userUsername;
    private String ordersLogistics;
    private String ordersOrDelete;
    private String productName;
    private String userAddress;
    private String userTelephone;
    private String userRealName;
    private User user;

    public String getOrdersId() {
        return ordersId;
    }

    public void setOrdersId(String ordersId) {
        this.ordersId = ordersId;
    }

    public String getOrdersTime() {
        return ordersTime;
    }

    public void setOrdersTime(String ordersTime) {
        this.ordersTime = ordersTime;
    }

    public String getOrdersDate() {
        return ordersDate;
    }

    public void setOrdersDate(String ordersDate) {
        this.ordersDate = ordersDate;
    }

    public String getOrdersTotal() {
        return ordersTotal;
    }

    public void setOrdersTotal(String ordersTotal) {
        this.ordersTotal = ordersTotal;
    }

    public String getOrdersState() {
        return ordersState;
    }

    public void setOrdersState(String ordersState) {
        this.ordersState = ordersState;
    }

    public String getUserUsername() {
        return userUsername;
    }

    public void setUserUsername(String userUsername) {
        this.userUsername = userUsername;
    }

    public String getOrdersLogistics() {
        return ordersLogistics;
    }

    public void setOrdersLogistics(String ordersLogistics) {
        this.ordersLogistics = ordersLogistics;
    }

    public String getOrdersOrDelete() {
        return ordersOrDelete;
    }

    public void setOrdersOrDelete(String ordersOrDelete) {
        this.ordersOrDelete = ordersOrDelete;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserTelephone() {
        return userTelephone;
    }

    public void setUserTelephone(String userTelephone) {
        this.userTelephone = userTelephone;
    }

    public String getUserRealName() {
        return userRealName;
    }

    public void setUserRealName(String userRealName) {
        this.userRealName = userRealName;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
