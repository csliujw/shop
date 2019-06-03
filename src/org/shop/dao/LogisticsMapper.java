package org.shop.dao;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Orders;
import org.shop.utils.Page;

import java.util.List;

public interface LogisticsMapper {
    // 物流信息
    List<Orders> selectAllByPage(Page<Orders> page);

    // 数据总数
    long selectAll(Orders orders);

    // 删除
    boolean delete(Orders orders);

    // 批量删除
    int deleteBatch(DeleteVO vo);

    // 更新 物流信息 订单状态（是否发货了）
    boolean update(Orders orders);

    // 订单是否送达
    boolean arrive(Orders order);

    // 查询单条数据信息
    Orders selectOne(String id);
}
