package org.shop.dao;

import org.shop.pojo.Admin;

public interface AdminMapper {
    //登录
    Admin login(Admin admin);

    //查询个人信息
    Admin adminInfo(Admin admin);

    //修改信息
    boolean updateAdmin(Admin admin);
}
