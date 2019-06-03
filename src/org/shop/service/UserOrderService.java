package org.shop.service;

import org.shop.dao.UserOrderMapper;
import org.shop.pojo.Orders;
import org.shop.pojo.UserOrder;
import org.shop.pojo.UserOrderVO;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class UserOrderService {
    @Autowired
    private UserOrderMapper mapper;

    //查询订单信息
    public List<Orders> selectOrders(Orders orders) {
        return mapper.selectOrders(orders);
    }

    //确认收货
    public boolean updateOrders(Orders orders) {
        return mapper.updateOrders(orders);
    }

    //查询未付款订单信息
    public List<UserOrder> selectUnpay(UserOrderVO vo) {
        return mapper.selectUnpay(vo);
    }

    //查询付款订单信息
    public List<UserOrder> selectPay(UserOrderVO vo) {
        return mapper.selectPay(vo);
    }

}
