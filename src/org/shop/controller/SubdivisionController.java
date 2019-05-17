package org.shop.controller;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.pojo.Subdivision;
import org.shop.service.SubdivisionServiceImpl;
import org.shop.utils.JSONResult;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 商品二级分类controller
 */
@Controller
@RequestMapping(value = "subdivision", produces = "application/json;charset=utf-8")
public class SubdivisionController {

    @Autowired
    private SubdivisionServiceImpl subdivisionService;

    /**
     * 查询数据
     *
     * @return
     */
    @RequestMapping("list.do")
    @ResponseBody
    public String list(Page<Subdivision> page, Subdivision sub, Division division) {
        sub.setDivision(division);
        page.setCondition(sub);
        String list = subdivisionService.selectAllPageCondition(page);
        return list;
    }

    @RequestMapping("add.do")
    @ResponseBody
    public String add(Subdivision sub, Division division) {
        sub.setDivision(division);
        boolean add = subdivisionService.add(sub);
        return JSONResult.add(add);
    }

    @RequestMapping("update.do")
    @ResponseBody
    public String update(Subdivision sub, Division division) {
        sub.setDivision(division);
        boolean update = subdivisionService.update(sub);
        return JSONResult.update(update);
    }

    @RequestMapping("delete.do")
    @ResponseBody
    public String delete(Subdivision sub) {
        boolean delete = subdivisionService.delete(sub);
        return JSONResult.delete(delete);
    }

    @RequestMapping("deletes.do")
    @ResponseBody
    public String deletes(DeleteVO vo) {
        boolean deletes = subdivisionService.deleteBatch(vo);
        return JSONResult.deletes(deletes);
    }

}
