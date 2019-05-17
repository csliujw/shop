package org.shop.dao;

import org.shop.pojo.User;

/**
 * 用户的各种操作
 * 登录 注册
 * 查询个人信息
 * 修改个人信息：修改密码 ，修改收货地址
 * */
public interface UserOperateMapper {
    //登录
    User login(User user);
    //短信登录
    User loginTel(User user);
    //注册
    boolean register(User user);
    //修改密码
    boolean updatePassword(User user);

    //查询个人信息 当然是用来修改信息的 密码 收货地址 手机号
    User selectUser(String id);
    //修改个人信息
    boolean updateUser(User user);
    //用户名是否重复
    boolean orExit(String username);
}
