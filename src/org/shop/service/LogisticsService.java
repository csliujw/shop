package org.shop.service;

import com.google.gson.Gson;
import org.shop.dao.LogisticsMapper;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.Orders;
import org.shop.utils.JSONData;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class LogisticsService {
    @Autowired
    private LogisticsMapper mapper;

    // 查询物流信息 条件 非条件
    public String selectAllByPage(Page<Orders> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<Orders> list = mapper.selectAllByPage(page);
            long count = mapper.selectAll(page.getCondition());
            return new Gson().toJson(new JSONData<Orders>(count + "", list));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<Orders>("0", null));
        }
    }

    // 数据总数
    public long selectAll(Orders orders) {
        return mapper.selectAll(orders);
    }

    // 删除
    public boolean delete(Orders orders) {
        return mapper.delete(orders);

    }

    // 批量删除
    public boolean deleteBatch(DeleteVO vo) {
        int length = vo.getIds().length;
        int count = mapper.deleteBatch(vo);
        return count == length;
    }

    // 更新 发货信息 订单状态
    public boolean update(Orders orders) {
        return mapper.update(orders);
    }
}
