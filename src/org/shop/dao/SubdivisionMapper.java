package org.shop.dao;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Subdivision;
import org.shop.utils.Page;

import java.util.List;

public interface SubdivisionMapper {
    //新增
    boolean addSubdivision(Subdivision Subdivision);

    //修改
    boolean updateSubdivision(Subdivision Subdivision);

    //删除
    boolean deleteSubdivision(Subdivision Subdivision);

    //批量删除
    int deleteBatchSubdivision(DeleteVO vo);

    //查询所有
    long selectAllSubdivision(Subdivision Subdivision);

    //条件分页查询 当条件全为空时 即无条件查询
    List<Subdivision> selectAllPageConditionSubdivision(Page<Subdivision> page);

    //查询单条数据信息
    Subdivision selectSingle(Subdivision Subdivision);
}
