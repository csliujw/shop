package org.shop.pojo;

/**
 * 商品信息
 * 商品一级类别
 * 商品二级类别
 * 采用对象充当属性，方便查询一二节类别的名称
 */
public class Product {
    private String productId;
    private String productName;
    private Double productShopPrice;
    private Double productMarketPrice;
    private String productImage;
    private String productDate;
    private String productOrHot;
    private String productDetail;
    private String productOrDelete;
    private Division division;//商品一级类别
    private Subdivision subdivision;//商品二级类别

    public Double getProductShopPrice() {
        return productShopPrice;
    }

    public void setProductShopPrice(Double productShopPrice) {
        this.productShopPrice = productShopPrice;
    }

    public Double getProductMarketPrice() {
        return productMarketPrice;
    }

    public void setProductMarketPrice(Double productMarketPrice) {
        this.productMarketPrice = productMarketPrice;
    }

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

    public String getProductDate() {
        return productDate;
    }

    public void setProductDate(String productDate) {
        this.productDate = productDate;
    }

    public String getProductOrHot() {
        return productOrHot;
    }

    public void setProductOrHot(String productOrHot) {
        this.productOrHot = productOrHot;
    }

    public String getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(String productDetail) {
        this.productDetail = productDetail;
    }

    public String getProductOrDelete() {
        return productOrDelete;
    }

    public void setProductOrDelete(String productOrDelete) {
        this.productOrDelete = productOrDelete;
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
}
