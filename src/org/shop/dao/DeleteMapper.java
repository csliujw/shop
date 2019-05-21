package org.shop.dao;

import org.shop.pojo.*;
import org.shop.utils.Page;

import java.util.List;

/***
 * 物理信息删除
 */
public interface DeleteMapper {

    //商品一级类别
    List<Division> divisionList(Page<Division> page);

    boolean divisionDelete(Division div);

    int divisionDeleteBatch(DeleteVO vo);

    long divisionAll(Division division);

    //商品二级类别
    List<Subdivision> subdivisionList(Page<Subdivision> page);

    boolean subdivisionDelete(Subdivision sub);

    int subdivisionDeleteBatch(DeleteVO vo);

    long subdivisionAll(Subdivision subdivision);

    //商品信息
    List<Product> productList(Page<Product> page);

    boolean productDelete(Product product);

    int productDeleteBatch(DeleteVO vo);

    long productAll(Product product);

    //订单信息
    List<OrderItem> orderList(Page<OrderItem> order);

    boolean orderDelete(OrderItem order);

    int orderDeleteBatch(DeleteVO vo);

    long orderAll(OrderItem order);

    //物流信息
    List<Orders> ordersList(Page<Orders> orders);

    boolean ordersDelete(Orders orders);

    int ordersDeleteBatch(DeleteVO vo);

    long ordersAll(Orders orders);
}
