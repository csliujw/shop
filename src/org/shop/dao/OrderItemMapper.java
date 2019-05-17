package org.shop.dao;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.OrderItem;
import org.shop.utils.Page;

import java.util.List;

public interface OrderItemMapper {
    //删除
    boolean delete(OrderItem orderItem);

    //批量删除
    int deleteBatch(DeleteVO vo);

    //查询总数
    long selectAll(OrderItem orderItem);

    //分页查询数据 条件|非条件
    List<OrderItem> selectAllPageCondition(Page<OrderItem> page);

}
