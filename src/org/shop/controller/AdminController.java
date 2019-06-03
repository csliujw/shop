package org.shop.controller;

import org.shop.pojo.Admin;
import org.shop.service.AdminService;
import org.shop.utils.RegisterCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "admin", produces = "application/json;charset=utf-8")
public class AdminController {

    @Autowired
    @Qualifier("adminService")
    private AdminService service;

    @RequestMapping("login.do")
    @ResponseBody
    public String login(@RequestBody Admin admin, HttpSession session) {
        Admin login = service.login(admin);
        if (login != null) {
            session.setAttribute("admin", login);
            System.err.println(login.toString());
        }
        return login != null ? "{\"codes\":\"OK\"}" : "{\"codes\":\"default\"}";
    }

    @RequestMapping("find.do")
    @ResponseBody
    public String findPassword(@RequestBody Admin admin) {
        Admin password = service.findPassword(admin);
        String result = "";
        //发短信
        System.err.println(password);
        if (password != null) {
            result = RegisterCode.sendPassword(password.getAdminTel(), password.getAdminPassword());
        }
        return "1".equals(result) ? "{\"codes\":\"OK\"}" : "{\"codes\":\"default\"}";
    }

    @RequestMapping("update.do")
    @ResponseBody
    public String updatePassword(@RequestBody Admin admin) {
        boolean update = service.updatePassword(admin);
        return update ? "{\"codes\":\"OK\"}" : "{\"codes\":\"default\"}";
    }

    @RequestMapping("getCode.do")
    @ResponseBody
    public String getCode(Admin admin) {
        String result = RegisterCode.sendMessage(admin.getAdminTel());
        return "1".equals(result) ? "{\"codes\":\"OK\"}" : "{\"codes\":\"default\"}";
    }

    @RequestMapping("logout.do")
    public String logout(HttpSession session) {
        session.removeAttribute("admin");
        return "redirect:/admin/index.html";
    }
}
