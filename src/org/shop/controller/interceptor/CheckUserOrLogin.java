package org.shop.controller.interceptor;

import org.shop.pojo.Admin;
import org.shop.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 检测用户是否登录
 */
public class CheckUserOrLogin implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        System.err.println("===========拦截了===========");
        StringBuffer requestURL = request.getRequestURL();
        System.out.println(requestURL);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");
        Admin admin = (Admin) session.getAttribute("admin");
        if (user != null || admin != null) {
            return true;
        }
        //不存在登录的用户
        if (user == null && admin == null) {
            //ajax请求 无法直接跳转 前端根据返回的信息判断是否跳转
            if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
                response.getWriter().write("{\"code\":\"unLogin\"}");
                return false;
            }
            request.getRequestDispatcher("/products/index.do").forward(request, response);//转发到登录界面
            return false;
        }
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/index.html");
            return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
