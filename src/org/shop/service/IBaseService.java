package org.shop.service;

import org.shop.pojo.DeleteVO;
import org.shop.utils.Page;

import java.util.List;

/**
 * 基本增删改查接口
 */
public interface IBaseService<T> {

    //新增
    boolean add(T t);

    //修改
    boolean update(T t);

    //删除
    boolean delete(T t);

    //批量删除
    boolean deleteBatch(DeleteVO vo);

    //查询所有
    long selectAll(T t);

    //分页有条件查询
    String selectAllPageCondition(Page<T> page);

    //查询单条数据信息
    String selectSingle(T t);

    //查询何种类别的数据 true被标记为删除的 false未被标记未删除的
    List<T> selectAllDetail(boolean orDelete);
}
