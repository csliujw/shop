package org.shop.controller;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.OrderItem;
import org.shop.service.OrderItemServiceImpl;
import org.shop.utils.JSONResult;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 用户订单管理
 * 对用户的订单进行增删改查
 */
@Controller
@RequestMapping(value = "order", produces = "application/json;charset=utf-8")
public class OrderController {
    @Autowired
    @Qualifier("orderItemServiceImpl")
    private OrderItemServiceImpl service;

    /**
     * 查询 条件非条件都是这个
     * @param page
     * @param item
     * @return
     */
    @RequestMapping("list.do")
    @ResponseBody
    public String list(Page<OrderItem> page, OrderItem item) {
        page.setCondition(item);
        String str = service.selectAllPageCondition(page);
        return str;
    }

    /**
     * 单条数据删除
     * @return
     */
    @RequestMapping("delete.do")
    @ResponseBody
    public String delete(OrderItem item) {
        boolean delete = service.delete(item);
        return JSONResult.delete(delete);

    }

    /**
     * 批量删除
     * @return
     */
    @RequestMapping("deletes.do")
    @ResponseBody
    public String deletes(DeleteVO vo) {
        boolean deletes = service.deleteBatch(vo);
        return JSONResult.deletes(deletes);
    }

}
