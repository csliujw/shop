package org.shop.controller;

import com.google.gson.Gson;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.service.IBaseService;
import org.shop.utils.JSONResult;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 商品一级分类controller
 */
@Controller
@RequestMapping(value = "division", produces = "application/json; charset=utf-8")
public class DivisionController {

    @Autowired
    private IBaseService divisionServiceImpl;

    /**
     * @return 跳转至前端视图
     */
    @RequestMapping("index.do")
    public String index(HttpSession session) {
        List<Division> divisions = divisionServiceImpl.selectAllDetail();
        session.setAttribute("division", divisions);
        Gson gson = new Gson();
        String s = gson.toJson(divisions);
        session.setAttribute("s", s);
        return "index";
    }

    /**
     * @param page
     * @return 无条件分页查询的结果
     */
    @RequestMapping("list.do")
    @ResponseBody()
    public String list(Page<Division> page, Division division) {
        //查询所有
        page.setCondition(division);
        String list = divisionServiceImpl.selectAllPageCondition(page);
        return list;
    }

    /**
     * @param division
     * @return 新增成功与否
     */
    @RequestMapping("add.do")
    @ResponseBody()
    public String add(Division division) {
        boolean add = divisionServiceImpl.add(division);
        return JSONResult.add(add);
    }

    @RequestMapping("update.do")
    @ResponseBody()
    public String update(Division division) {
        boolean update = divisionServiceImpl.update(division);
        return JSONResult.update(update);
    }

    /**
     * @param division
     * @return 删除成功与否
     */
    @RequestMapping("delete.do")
    @ResponseBody()
    public String delete(Division division) {
        boolean delete = divisionServiceImpl.delete(division);
        return JSONResult.deleteDivision(delete);

    }

    /**
     * @param vo
     * @return 批量删除成功与否
     */
    @RequestMapping("deletes.do")
    @ResponseBody()
    public String deleteBatch(DeleteVO vo) {
        boolean deletes = divisionServiceImpl.deleteBatch(vo);
        return JSONResult.deletesDivision(deletes);
    }

    /**
     * @param page
     * @return 批量删除成功与否
     */
    @RequestMapping("condition.do")
    @ResponseBody()
    public String selectAllPageCondition(Page<Division> page) {
        String str = divisionServiceImpl.selectAllPageCondition(page);
        return str;
    }

}
