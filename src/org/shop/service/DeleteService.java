package org.shop.service;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.pojo.Product;
import org.shop.pojo.Subdivision;
import org.shop.utils.Page;
import org.springframework.stereotype.Service;

/**
 * 信息物理删除
 */
@Service
public class DeleteService {
    //商品一级类别
    public String divisionList(Page<Division> page) {
        return "";
    }

    public String divisionDelete(Division div) {
        return "";
    }

    public String divisionDeleteBatch(DeleteVO vo) {
        System.out.println("hello");
        return "";
    }

    //商品二级类别
    public String subdivisionList(Page<Subdivision> page) {
        return "";
    }

    public String subdivisionDelete(Subdivision sub) {
        return "";
    }

    public String subdivisionDeleteBatch(DeleteVO vo) {
        return "";
    }

    //商品信息
    public String productList(Page<Product> page) {
        return "";
    }

    public String productDelete(Product product) {
        return "";
    }

    public String productDeleteBatch(DeleteVO vo) {
        return "";
    }

    //订单信息
    public String orderList() {
        return "";
    }

    public String orderDelete() {
        return "";
    }

    public String orderDeleteBatch(DeleteVO vo) {
        return "";
    }


    //物流信息
    public String ordersList() {
        return "";
    }

    public String ordersDelete() {
        return "";
    }

    public String ordersDeleteBatch(DeleteVO vo) {
        return "";
    }
}
