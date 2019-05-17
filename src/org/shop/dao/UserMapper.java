package org.shop.dao;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.User;
import org.shop.utils.Page;

import java.util.List;

public interface UserMapper {
    //删除
    boolean deleteUser(User User);

    //批量删除
    int deleteBatchUser(DeleteVO vo);

    //查询所有
    long selectAllUser(User User);

    //条件分页查询 当条件全为空时 即无条件查询
    List<User> selectAllPageConditionUser(Page<User> page);

    //查询单条数据信息
    User selectSingle(User User);
}
