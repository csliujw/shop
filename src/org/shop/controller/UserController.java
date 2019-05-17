package org.shop.controller;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.User;
import org.shop.service.UserServiceImpl;
import org.shop.utils.JSONResult;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 用户信息删除 查询
 * 查询条件 姓名 状态
 */
@Controller
@RequestMapping(value = "userM", produces = "application/json;charset=utf-8")
public class UserController {

    @Autowired
    private UserServiceImpl service;

    @RequestMapping("list.do")
    @ResponseBody
    public String list(Page<User> page, User user) {
        page.setCondition(user);
        return service.selectAllPageCondition(page);
    }

    @RequestMapping("delete.do")
    @ResponseBody
    public String delete(@RequestBody User user) {
        boolean delete = service.delete(user);
        return JSONResult.deleteUser(delete);
    }

    @RequestMapping("deletes.do")
    @ResponseBody
    public String deletes(DeleteVO vo) {
        boolean deletes = service.deleteBatch(vo);
        return JSONResult.deletesUser(deletes);
    }
}
