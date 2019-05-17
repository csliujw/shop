package org.shop.dao;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.utils.Page;

import java.util.List;

public interface DivisionMapper {
    //新增
    boolean addDivision(Division division);

    //修改
    boolean updateDivision(Division division);

    //删除
    boolean deleteDivision(Division division);

    //批量删除
    int deleteBatchDivision(DeleteVO vo);

    //查询所有
    long selectAllDivision(Division division);

    //条件分页查询 当条件全为空时 即无条件查询
    List<Division> selectAllPageConditionDivision(Page<Division> page);

    //是否存在
    boolean orExit(Division division);

    //查询单条数据信息
    Division selectSingle(Division division);

    //查询所有信息
    List<Division> selectAllDetail();
}
