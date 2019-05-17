package org.shop.controller;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Orders;
import org.shop.service.LogisticsService;
import org.shop.utils.JSONResult;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "orders", produces = "application/json;charset=utf-8")
public class LogisticsController {
    @Autowired
    @Qualifier("logisticsService")
    private LogisticsService service;

    @RequestMapping("list.do")
    @ResponseBody
    public String list(Page<Orders> page, Orders orders) {
        page.setCondition(orders);
        return service.selectAllByPage(page);
    }

    /**
     * 单条数据删除
     *
     * @return
     */
    @RequestMapping("delete.do")
    @ResponseBody
    public String delete(Orders orders) {
        boolean delete = service.delete(orders);
        return JSONResult.delete(delete);

    }

    /**
     * 批量删除
     *
     * @return
     */
    @RequestMapping("deletes.do")
    @ResponseBody
    public String deletes(DeleteVO vo) {
        boolean deletes = service.deleteBatch(vo);
        return JSONResult.deletes(deletes);
    }

    /**
     * 更新数据 如 物流信息 确认收货的状态
     *
     * @param order
     * @return
     */
    @RequestMapping("update.do")
    @ResponseBody
    public String update(Orders order) {
        boolean update = service.update(order);
        return JSONResult.update(update);
    }
}
