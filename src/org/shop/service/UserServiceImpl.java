package org.shop.service;

import com.google.gson.Gson;
import org.shop.dao.UserMapper;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.User;
import org.shop.utils.JSONData;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 管理員 管理用戶信息
 */
@Service
public class UserServiceImpl implements IBaseService<User> {
    @Autowired
    private UserMapper mapper;

    @Override
    public boolean add(User user) {
        return false;
    }

    @Override
    public boolean update(User user) {
        return false;
    }

    //刪除
    @Override
    public boolean delete(User user) {
        return mapper.deleteUser(user);
    }

    //批量刪除
    @Override
    public boolean deleteBatch(DeleteVO vo) {
        int i = mapper.deleteBatchUser(vo);
        return i == vo.getIds().length;
    }

    //非條件 條件查詢 总数
    @Override
    public long selectAll(User user) {
        return mapper.selectAllUser(user);
    }

    //非條件 條件查詢 非总数
    @Override
    public String selectAllPageCondition(Page<User> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<User> list = mapper.selectAllPageConditionUser(page);
            long count = mapper.selectAllUser(page.getCondition());
            return new Gson().toJson(new JSONData<>(count + "", list));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<User>("0", null));
        }
    }

    @Override
    public String selectSingle(User user) {
        return null;
    }

    @Override
    public List<User> selectAllDetail() {
        return null;
    }
}