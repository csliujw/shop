package org.shop.dao;

import org.shop.pojo.CartItem;
import org.shop.pojo.CartVO;
import org.shop.pojo.OrderItem;
import org.shop.pojo.Orders;

import java.util.List;

/**
 * 添加进购物车 移除购物车的操作全部在session中进行 无需数据库
 * 提交订单时插入数据库 -- 插入操作
 * 付款 将订单信息写入物流表中
 * 两个操作，插入a表
 * 插入b表
 */
public interface CartMapper {
    //添加购物车信息至数据库
    int addProduct(CartItem item);

    //添加数据至物流表
    int addOrders(Orders orders);

    //查询所有未付款订单信息
    List<OrderItem> selectOrderItem(String userId);

    boolean updateOrderItem(CartVO vo);

    OrderItem selectOrderItemById(String orderItemId);
}
