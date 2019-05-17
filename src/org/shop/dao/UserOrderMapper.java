package org.shop.dao;

import org.shop.pojo.Orders;
import org.shop.pojo.UserOrder;
import org.shop.pojo.UserOrderVO;

import java.util.List;

/**
 * 用户自身的订单操作
 * 查询订单 根据订单状态排序  未付款 已付款
 * 确认收货 -- update
 */
public interface UserOrderMapper {
    //查询订单信息
    List<Orders> selectOrders(Orders orders);

    //确认收货
    boolean updateOrders(Orders orders);

    //查询未付款订单信息
    List<UserOrder> selectUnpay(UserOrderVO vo);

    //查询付款订单信息
    List<UserOrder> selectPay(UserOrderVO vo);
}
