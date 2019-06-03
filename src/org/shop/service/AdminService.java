package org.shop.service;

import org.shop.dao.AdminMapper;
import org.shop.pojo.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    @Autowired
    private AdminMapper mapper;

    public Admin login(Admin admin) {
        return mapper.login(admin);
    }

    public Admin findPassword(Admin admin) {
        Admin obj = mapper.adminInfo(admin);
        return obj;
    }

    public boolean updatePassword(Admin admin) {
        return mapper.updateAdmin(admin);
    }
}
