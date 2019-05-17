package org.shop.service;

import org.shop.dao.UserOperateMapper;
import org.shop.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.UUID;

public class UserOperateService {
    @Autowired
    private UserOperateMapper mapper;

    public User login(User user) {
        return mapper.login(user);
    }

    public User loginTel(User user) {
        return mapper.loginTel(user);
    }

    public boolean register(User user){
        user.setUserId(UUID.randomUUID().toString());
        return mapper.register(user);
    }

    public boolean orExit(String username){
        return mapper.orExit(username);
    }

    public boolean updatePassword(User user){
        return mapper.updatePassword(user);
    }

    public boolean updateAddress(User user){
        return mapper.updateUser(user);
    }

    /**
     * 暂时不用
     * @param user
     * @return
     */
    public boolean updateTel(User user){
        return mapper.updateUser(user);
    }
}
