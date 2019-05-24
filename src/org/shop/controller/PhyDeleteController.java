package org.shop.controller;

import com.google.gson.Gson;
import org.shop.pojo.*;
import org.shop.service.DeleteService;
import org.shop.service.IBaseService;
import org.shop.utils.JSONResult;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 那些信息的物流删除操作
 */
@Controller
@RequestMapping(value = "phy", produces = "application/json;charset=utf-8")
public class PhyDeleteController {
    @Autowired
    @Qualifier("deleteService")
    private DeleteService service;

    @Autowired
    private IBaseService divisionServiceImpl;

    //商品一级类别
    @RequestMapping("divisionList.do")
    @ResponseBody
    public String divisionList(Page<Division> page, Division div) {
        page.setCondition(div);
        return service.divisionList(page);
    }

    @RequestMapping("divisionDelete.do")
    @ResponseBody
    public String divisionDelete(Division div, HttpSession session) {
        boolean delete = service.divisionDelete(div);
        if (delete) updateSession(session);
        return JSONResult.deleteDivision(delete);
    }

    @RequestMapping("divisionDeleteBatch.do")
    @ResponseBody
    public String divisionDeleteBatch(DeleteVO vo, HttpSession session) {
        boolean deletes = service.divisionDeleteBatch(vo);
        if (deletes) updateSession(session);
        return JSONResult.deletesDivision(deletes);
    }

    //商品二级类别
    @RequestMapping("subdivisionList.do")
    @ResponseBody
    public String subdivisionList(Page<Subdivision> page, Subdivision sub) {
        page.setCondition(sub);
        return service.subdivisionList(page);
    }

    @RequestMapping("subdivisionDelete.do")
    @ResponseBody
    public String subdivisionDelete(Subdivision sub, HttpSession session) {
        boolean delete = service.subdivisionDelete(sub);
        if (delete) updateSession(session);
        return JSONResult.delete(delete);
    }

    @RequestMapping("subdivisionDeleteBatch.do")
    @ResponseBody
    public String subdivisionDeleteBatch(DeleteVO vo, HttpSession session) {
        boolean deletes = service.subdivisionDeleteBatch(vo);
        if (deletes) updateSession(session);
        return JSONResult.deletes(deletes);
    }

    //商品信息
    @RequestMapping("productList.do")
    @ResponseBody
    public String productList(Page<Product> page, Product product) {
        page.setCondition(product);
        return service.productList(page);
    }

    @RequestMapping("productDelete.do")
    @ResponseBody
    public String productDelete(Product product) {
        boolean delete = service.productDelete(product);
        return JSONResult.delete(delete);
    }

    @RequestMapping("productDeleteBatch.do")
    @ResponseBody
    public String productDeleteBatch(DeleteVO vo) {
        boolean deletes = service.productDeleteBatch(vo);
        return JSONResult.deletes(deletes);
    }

    //订单信息
    @RequestMapping("orderList.do")
    @ResponseBody
    public String orderList(Page<OrderItem> page, OrderItem item) {
        page.setCondition(item);
        return service.orderList(page);
    }

    @RequestMapping("orderDelete.do")
    @ResponseBody
    public String orderDelete(OrderItem item) {
        boolean delete = service.orderDelete(item);
        return JSONResult.delete(delete);
    }

    @RequestMapping("orderDeleteBatch.do")
    @ResponseBody
    public String orderDeleteBatch(DeleteVO vo) {
        boolean deletes = service.orderDeleteBatch(vo);
        return JSONResult.deletes(deletes);
    }


    //物流信息
    @RequestMapping("ordersList.do")
    @ResponseBody
    public String ordersList(Page<Orders> page, Orders orders) {
        page.setCondition(orders);
        return service.ordersList(page);
    }

    @RequestMapping("ordersDelete.do")
    @ResponseBody
    public String ordersDelete(Orders orders) {
        boolean delete = service.ordersDelete(orders);
        return JSONResult.delete(delete);
    }

    @RequestMapping("ordersDeleteBatch.do")
    @ResponseBody
    public String ordersDeleteBatch(DeleteVO vo) {
        boolean deletes = service.ordersDeleteBatch(vo);
        return JSONResult.deletes(deletes);
    }


    /**
     * 更新session域
     *
     * @param session
     */
    public void updateSession(HttpSession session) {
        //查询   被标记为删除的
        List<Division> divisionDelete = divisionServiceImpl.selectAllDetail(true);
        session.setAttribute("divisionDelete", divisionDelete);
        Gson gson = new Gson();
        String s2 = gson.toJson(divisionDelete);
        session.setAttribute("ss", s2);
    }
}
