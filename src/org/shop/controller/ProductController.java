package org.shop.controller;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.pojo.Product;
import org.shop.pojo.Subdivision;
import org.shop.service.IBaseService;
import org.shop.utils.JSONResult;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "product", produces = "application/json; charset=utf-8")
public class ProductController {

    @Autowired
    private IBaseService productServiceImpl;

    @RequestMapping("list.do")
    @ResponseBody
    public String list(Page<Product> page, Product product, Division division, Subdivision subdivision) {
        product.setDivision(division);
        product.setSubdivision(subdivision);
        page.setCondition(product);
        String list = productServiceImpl.selectAllPageCondition(page);
        return list;
    }

    @RequestMapping("add.do")
    @ResponseBody
    public String add(@RequestBody Product product) {
        boolean add = productServiceImpl.add(product);
        return JSONResult.add(add);
    }

    @RequestMapping("update.do")
    @ResponseBody
    public String update(@RequestBody Product product) {
        boolean update = productServiceImpl.update(product);
        return JSONResult.update(update);
    }

    @RequestMapping("delete.do")
    @ResponseBody
    public String delete(Product product) {
        boolean delete = productServiceImpl.delete(product);
        return JSONResult.delete(delete);
    }

    @RequestMapping("deletes.do")
    @ResponseBody
    public String deletes(DeleteVO vo) {
        boolean deletes = productServiceImpl.deleteBatch(vo);
        return JSONResult.deletes(deletes);
    }
}
