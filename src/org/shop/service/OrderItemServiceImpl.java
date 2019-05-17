package org.shop.service;

import com.google.gson.Gson;
import org.shop.dao.OrderItemMapper;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.pojo.OrderItem;
import org.shop.utils.JSONData;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemServiceImpl implements IBaseService<OrderItem> {
    @Autowired
    private OrderItemMapper mapper;

    @Override
    public boolean add(OrderItem orderItem) {
        return false;
    }

    @Override
    public boolean update(OrderItem orderItem) {
        return false;
    }

    @Override
    public boolean delete(OrderItem orderItem) {
        return mapper.delete(orderItem);
    }

    @Override
    public boolean deleteBatch(DeleteVO vo) {
        int result = mapper.deleteBatch(vo);
        if (vo.getIds().length == result)
            return true;
        return false;
    }

    @Override
    public long selectAll(OrderItem orderItem) {
        return mapper.selectAll(orderItem);
    }

    @Override
    public String selectAllPageCondition(Page<OrderItem> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<OrderItem> list = mapper.selectAllPageCondition(page);
            long count = mapper.selectAll(page.getCondition());
            return new Gson().toJson(new JSONData<OrderItem>(count + "", list));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<OrderItem>("0", null));
        }
    }

    @Override
    public String selectSingle(OrderItem orderItem) {
        return null;
    }

    @Override
    public List<OrderItem> selectAllDetail() {
        return null;
    }
}
