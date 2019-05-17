package org.shop.pojo;

/**
 * 用户订单信息pojo
 */
public class UserOrder {
    private String productId;
    private String productName;
    private String productImage;
    private String productShopPrice;
    private String orderItemId;
    private String orderItemCount;//购买数目
    private String orderItemSubtotal;//总价钱
    private String ordersLogistics;
    private String ordersSate;//订单状态

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public String getProductShopPrice() {
        return productShopPrice;
    }

    public void setProductShopPrice(String productShopPrice) {
        this.productShopPrice = productShopPrice;
    }

    public String getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(String orderItemId) {
        this.orderItemId = orderItemId;
    }

    public String getOrderItemCount() {
        return orderItemCount;
    }

    public void setOrderItemCount(String orderItemCount) {
        this.orderItemCount = orderItemCount;
    }

    public String getOrderItemSubtotal() {
        return orderItemSubtotal;
    }

    public void setOrderItemSubtotal(String orderItemSubtotal) {
        this.orderItemSubtotal = orderItemSubtotal;
    }

    public String getOrdersLogistics() {
        return ordersLogistics;
    }

    public void setOrdersLogistics(String ordersLogistics) {
        this.ordersLogistics = ordersLogistics;
    }

    public String getOrdersSate() {
        return ordersSate;
    }

    public void setOrdersSate(String ordersSate) {
        this.ordersSate = ordersSate;
    }
}
