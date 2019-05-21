package org.shop.controller;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.pojo.Subdivision;
import org.shop.service.DeleteService;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 那些信息的物流删除操作
 */
@Controller
@RequestMapping(value = "phy", produces = "application/json;charset=utf-8")
public class PhyDeleteController {
    @Autowired
    @Qualifier("deleteService")
    private DeleteService service;

    //商品一级类别
    @RequestMapping("divisionList.do")
    @ResponseBody
    public String divisionList(Page<Division> page, Division div) {
        page.setCondition(div);
        return service.divisionList(page);
    }

    @RequestMapping("divisionDelete.do")
    @ResponseBody
    public String divisionDelete(Division div) {
        service.divisionDelete(div);
        return "";
    }

    @RequestMapping("divisionDeleteBatch.do")
    @ResponseBody
    public String divisionDeleteBatch(DeleteVO vo) {
        service.divisionDeleteBatch(vo);
        return "";
    }

    //商品二级类别
    @RequestMapping("subdivisionList.do")
    @ResponseBody
    public String subdivisionList(Page<Subdivision> page, Subdivision sub) {
        page.setCondition(sub);
        service.subdivisionList(page);
        return "";
    }

    @RequestMapping("subdivisionDelete.do")
    @ResponseBody
    public String subdivisionDelete(Subdivision sub) {
        service.subdivisionDelete(sub);
        return "";
    }

    @RequestMapping("subdivisionDeleteBatch.do")
    @ResponseBody
    public String subdivisionDeleteBatch(DeleteVO vo) {
        service.subdivisionDeleteBatch(vo);
        return "";
    }

    //商品信息
    @RequestMapping("productList.do")
    @ResponseBody
    public String productList() {
        return "";
    }

    @RequestMapping("productDelete.do")
    @ResponseBody
    public String productDelete() {
        return "";
    }

    @RequestMapping("productDeleteBatch.do")
    @ResponseBody
    public String productDeleteBatch(DeleteVO vo) {
        return "";
    }

    //订单信息
    @RequestMapping("orderList.do")
    @ResponseBody
    public String orderList() {
        return "";
    }

    @RequestMapping("orderDelete.do")
    @ResponseBody
    public String orderDelete() {
        return "";
    }

    @RequestMapping("orderDeleteBatch.do")
    @ResponseBody
    public String orderDeleteBatch(DeleteVO vo) {
        return "";
    }


    //物流信息
    @RequestMapping("ordersList.do")
    @ResponseBody
    public String ordersList() {
        return "";
    }

    @RequestMapping("ordersDelete.do")
    @ResponseBody
    public String ordersDelete() {
        return "";
    }

    @RequestMapping("ordersDeleteBatch.do")
    @ResponseBody
    public String ordersDeleteBatch(DeleteVO vo) {
        return "";
    }


}
