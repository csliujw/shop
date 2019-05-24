package org.shop.controller;

import com.google.gson.Gson;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.pojo.Subdivision;
import org.shop.service.IBaseService;
import org.shop.service.SubdivisionServiceImpl;
import org.shop.utils.JSONResult;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 商品二级分类controller
 */
@Controller
@RequestMapping(value = "subdivision", produces = "application/json;charset=utf-8")
public class SubdivisionController {

    @Autowired
    private SubdivisionServiceImpl subdivisionService;
    @Autowired
    private IBaseService divisionServiceImpl;

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
    public String add(Subdivision sub, Division division, HttpSession session) {
        sub.setDivision(division);
        boolean add = subdivisionService.add(sub);
        if (add) updateSession(session);
        return JSONResult.add(add);
    }

    @RequestMapping("update.do")
    @ResponseBody
    public String update(Subdivision sub, Division division, HttpSession session) {
        sub.setDivision(division);
        boolean update = subdivisionService.update(sub);
        if (update) updateSession(session);
        return JSONResult.update(update);
    }

    @RequestMapping("delete.do")
    @ResponseBody
    public String delete(Subdivision sub, HttpSession session) {
        boolean delete = subdivisionService.delete(sub);
        if (delete) updateSession(session);
        return JSONResult.delete(delete);
    }

    @RequestMapping("deletes.do")
    @ResponseBody
    public String deletes(DeleteVO vo, HttpSession session) {
        boolean deletes = subdivisionService.deleteBatch(vo);
        if (deletes) updateSession(session);
        return JSONResult.deletes(deletes);
    }

    /**
     * 更新session域
     *
     * @param session
     */
    public void updateSession(HttpSession session) {
        //查询   未被标记为删除的
        List<Division> divisionUnDelete = divisionServiceImpl.selectAllDetail(false);
        session.setAttribute("division", divisionUnDelete);
        Gson gson = new Gson();
        String s1 = gson.toJson(divisionUnDelete);
        session.setAttribute("s", s1);
    }
}
