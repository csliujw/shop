package org.shop.controller;

import org.shop.pojo.User;
import org.shop.pojo.UserOrder;
import org.shop.pojo.UserOrderVO;
import org.shop.service.UserOperateService;
import org.shop.service.UserOrderService;
import org.shop.utils.RegisterCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "user", produces = "application/json;charset=utf-8")
/**
 * 用户个人操作
 */
public class UserOperateController {
    //短信注册码
    private static String code = "-1";
    @Autowired
    @Qualifier("userOperateService")//通过注解和bean配置的方式混合注入
    private UserOperateService service;
    @Autowired
    @Qualifier("userOrderService")
    private UserOrderService userOrderService;

    /**
     * 查询未付款的
     *
     * @param vo
     * @return
     */
    @RequestMapping("selectUnpay.do")
    @ResponseBody
    public List<UserOrder> selectUnpay(@RequestBody UserOrderVO vo) {
        List<UserOrder> list = userOrderService.selectUnpay(vo);
        return list;
    }

    /**
     * 查询付款了的
     *
     * @param vo
     * @return
     */
    @RequestMapping("selectPay.do")
    @ResponseBody
    public List<UserOrder> selectPay(@RequestBody UserOrderVO vo) {
        List<UserOrder> list = userOrderService.selectPay(vo);
        return list;
    }

    @RequestMapping("login.do")
    public String loginByPassword(HttpServletRequest request, User user) {
        //用户登录查询
        User u = service.login(user);
        if (u != null && u.getUserId() != null && !"".equals(u.getUserId())) {
            request.getSession().setAttribute("userInfo", u);
            System.err.println(u.getUserId() + "用户ID如前");
            return "redirect:/products/index.do";
        }
        request.setAttribute("message", "用户名或密码错误!");
        return "forward:/login.jsp";

    }

    @RequestMapping("loginTel.do")
    public String loginByTel(HttpServletRequest request, User user) {
        String telCode = request.getParameter("code");
        if (telCode.equals(code)) {
            User u = service.loginTel(user);
            if (u != null && u.getUserId() != null && !"".equals(u.getUserId())) {
                request.getSession().setAttribute("userInfo", u);
                return "redirect:/products/index.do";
            }
        }
        request.setAttribute("message", "短信验证码错误!");
        return "forward:/login.jsp";
    }


    @RequestMapping("register.do")
    public String register(HttpServletRequest request, User user) {
        String telCode = request.getParameter("code");
        if (telCode.equals(code)) {
            boolean register = service.register(user);
            if (register) {
                return "redirect:/login.jsp";
            }
        }
        request.setAttribute("message", "注册失败，请检查输入数据的合法性");
        return "forward:/register.jsp";
    }

    @RequestMapping("logout.do")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/products/index.do";
    }

    @RequestMapping("checkUsername.do")
    @ResponseBody
    public String checkName(String username) {
        boolean result = service.orExit(username);
        if (result) {
            return "{\"code\":\"用户名已存在请更换\"}";
        }
        return "{\"code\":\"用户名可使用\"}";
    }

    @RequestMapping("updatePassword.do")
    @ResponseBody
    public String updatePassword(@RequestBody User user) {
        boolean result = service.updatePassword(user);
        if (result) {
            return "{\"message\":\"修改成功!下次使用时生效！\"}";
        }
        return "{\"message\":\"修改失败，请检查旧密码是否正确!\"}";
    }

    @RequestMapping("updateAddress.do")
    @ResponseBody
    public String updateAddress(@RequestBody User user) {
        boolean result = service.updateAddress(user);
        if (result) {
            return "{\"message\":\"修改成功!下次使用时生效！\"}";
        }
        return "{\"message\":\"修改失败，请稍后再试!\"}";
    }

    @RequestMapping("code.do")
    @ResponseBody
    public String sendMessage(String tel) {
        String telCode = RegisterCode.sendMessage(tel);
        if (!"-1".equals(telCode)) {
            code = telCode;
            return "OK";
        }
        return "default";
    }
}
