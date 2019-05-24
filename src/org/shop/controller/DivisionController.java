package org.shop.controller;

import com.google.gson.Gson;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.service.IBaseExtend;
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
    private IBaseExtend divisionServiceImpl;

    /**
     * @return 跳转至前端视图
     */
    @RequestMapping("index.do")
    public String index(HttpSession session) {
        updateSession(session);
        return "index";
    }

    /**
     * @param page
     * @return 无条件分页查询的结果
     */
    @RequestMapping("list.do")
    @ResponseBody
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
    @ResponseBody
    public String add(Division division, HttpSession session) {
        boolean add = divisionServiceImpl.add(division);
        if (add) updateSession(session);
        return JSONResult.add(add);
    }

    @RequestMapping("update.do")
    @ResponseBody
    public String update(Division division, HttpSession session) {
        boolean update = divisionServiceImpl.update(division);
        if (update) updateSession(session);
        return JSONResult.update(update);
    }

    /**
     * @param division
     * @return 删除成功与否
     */
    @RequestMapping("delete.do")
    @ResponseBody
    public String delete(Division division, HttpSession session) {
        boolean delete = divisionServiceImpl.delete(division);
        if (delete) updateSession(session);
        return JSONResult.deleteDivision(delete);
    }

    /**
     * @param vo
     * @return 批量删除成功与否
     */
    @RequestMapping("deletes.do")
    @ResponseBody
    public String deleteBatch(DeleteVO vo, HttpSession session) {
        boolean deletes = divisionServiceImpl.deleteBatch(vo);
        if (deletes) updateSession(session);
        return JSONResult.deletesDivision(deletes);
    }

    /**
     * @param page
     * @return 条件查询
     */
    @RequestMapping("condition.do")
    @ResponseBody
    public String selectAllPageCondition(Page<Division> page) {
        String str = divisionServiceImpl.selectAllPageCondition(page);
        return str;
    }

    /**
     * 更新session域
     *
     * @param session
     */
    @RequestMapping("updateSession.do")
    @ResponseBody
    public String updateSession(HttpSession session) {
        //查询所有 Division
        List list1 = divisionServiceImpl.selectAllInfo(false);
        List list2 = divisionServiceImpl.selectAllInfo(true);
        //查询未被标记为删除的
        List<Division> divisionUnDelete = divisionServiceImpl.selectAllDetail(false);
        //查询被标记为删除的
        List<Division> divisionDelete = divisionServiceImpl.selectAllDetail(true);
        session.setAttribute("divisions", list1);
        session.setAttribute("divisionsDelete", list2);
        session.setAttribute("division", divisionUnDelete);
        session.setAttribute("divisionDelete", divisionDelete);

        Gson gson = new Gson();
        String s1 = gson.toJson(divisionUnDelete);
        String s2 = gson.toJson(divisionDelete);
        session.setAttribute("s", s1);
        session.setAttribute("ss", s2);
        return "{\"message\":\"刷新成功！\"}";
    }
}
