package org.shop.service;

import com.google.gson.Gson;
import org.shop.dao.DeleteMapper;
import org.shop.pojo.*;
import org.shop.utils.JSONData;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 信息物理删除
 */
@Service
public class DeleteService {
    @Autowired
    private DeleteMapper mapper;


    //商品一级类别查询
    public String divisionList(Page<Division> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<Division> list = mapper.divisionList(page);
            long count = mapper.divisionAll(page.getCondition());
            return new Gson().toJson(new JSONData<>(count + "", list));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<Division>("0", null));
        }
    }

    //商品一级类别删除
    public boolean divisionDelete(Division div) {
        return mapper.divisionDelete(div);
    }

    //商品一级类别批量删除
    public boolean divisionDeleteBatch(DeleteVO vo) {
        return vo.getIds().length == mapper.divisionDeleteBatch(vo);
    }

    //商品二级类别查询
    public String subdivisionList(Page<Subdivision> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<Subdivision> list = mapper.subdivisionList(page);
            long count = mapper.subdivisionAll(page.getCondition());
            return new Gson().toJson(new JSONData<>(count + "", list));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<Subdivision>("0", null));
        }
    }

    //商品二级类别删除
    public boolean subdivisionDelete(Subdivision sub) {
        return mapper.subdivisionDelete(sub);
    }

    //商品二级类别批量删除
    public boolean subdivisionDeleteBatch(DeleteVO vo) {
        return vo.getIds().length == mapper.subdivisionDeleteBatch(vo);
    }

    //商品信息查询
    public String productList(Page<Product> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<Product> list = mapper.productList(page);
            long count = mapper.productAll(page.getCondition());
            return new Gson().toJson(new JSONData<>(count + "", list));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<Product>("0", null));
        }
    }

    //商品信息删除
    public boolean productDelete(Product product) {
        return mapper.productDelete(product);
    }

    //商品信息批量删除
    public boolean productDeleteBatch(DeleteVO vo) {
        return vo.getIds().length == mapper.productDeleteBatch(vo);
    }

    //订单信息
    public String orderList(Page<OrderItem> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<OrderItem> list = mapper.orderList(page);
            long count = mapper.orderAll(page.getCondition());
            return new Gson().toJson(new JSONData<>(count + "", list));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<OrderItem>("0", null));
        }
    }

    public boolean orderDelete(OrderItem orderItem) {
        return mapper.orderDelete(orderItem);
    }

    public boolean orderDeleteBatch(DeleteVO vo) {
        return vo.getIds().length == mapper.orderDeleteBatch(vo);
    }


    //物流信息
    public String ordersList(Page<Orders> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<Orders> list = mapper.ordersList(page);
            long count = mapper.ordersAll(page.getCondition());
            return new Gson().toJson(new JSONData<>(count + "", list));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<Orders>("0", null));
        }
    }

    public boolean ordersDelete(Orders orders) {
        return mapper.ordersDelete(orders);
    }

    public boolean ordersDeleteBatch(DeleteVO vo) {
        return vo.getIds().length == mapper.ordersDeleteBatch(vo);
    }
}
