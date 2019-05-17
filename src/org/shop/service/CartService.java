package org.shop.service;

import org.shop.dao.CartMapper;
import org.shop.pojo.CartItem;
import org.shop.pojo.CartVO;
import org.shop.pojo.OrderItem;
import org.shop.pojo.Orders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {
    @Autowired
    private CartMapper cartMapper;

    /**
     * 提交购物车信息时将购物车中的数据写入数据库
     *
     * @param list
     * @return
     */
    public boolean addProduct(List<CartItem> list) {
        int count = 0;
        for (CartItem item : list) {
            count += cartMapper.addProduct(item);
        }
        return count > 0;
    }

    /**
     * 付款成功后 添加至物流信息表。
     *
     * @param orders
     * @return
     */
    public boolean addOrders(Orders orders) {
        int i = cartMapper.addOrders(orders);
        return i > 0;
    }

    /**
     * 查询本人的所有订单信息
     *
     * @param userId
     * @return
     */
    public List<OrderItem> selectOrderItem(String userId) {
        return cartMapper.selectOrderItem(userId);
    }

    public boolean updateOrderItem(CartVO vo) {
        return cartMapper.updateOrderItem(vo);
    }

    public OrderItem selectOrderItemById(String orderItemId) {
        return cartMapper.selectOrderItemById(orderItemId);
    }
}
