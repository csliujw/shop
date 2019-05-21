package org.shop.dao;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.pojo.Product;
import org.shop.pojo.Subdivision;
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
    List<Product> productList();

    boolean productDelete();

    int productDeleteBatch(DeleteVO vo);

    long productAll(Product product);

    /*
    //订单信息
    List<Order> orderList();

    boolean orderDelete();

    int orderDeleteBatch(DeleteVO vo);

    //物流信息
    List<Orders> ordersList();

    boolean ordersDelete();

    int ordersDeleteBatch(DeleteVO vo);*/
}
