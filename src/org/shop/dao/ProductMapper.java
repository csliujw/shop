package org.shop.dao;

import org.shop.pojo.DeleteVO;
import org.shop.pojo.Product;
import org.shop.utils.Page;

import java.util.List;

public interface ProductMapper {
    //新增
    boolean addProduct(Product Product);

    //修改
    boolean updateProduct(Product Product);

    //删除
    boolean deleteProduct(Product Product);

    //批量删除
    int deleteBatchProduct(DeleteVO vo);

    //查询所有
    long selectAllProduct(Product Product);

    //条件分页查询 当条件全为空时 即无条件查询
    List<Product> selectAllPageConditionProduct(Page<Product> page);

    //查询单条数据信息
    Product selectSingle(Product Product);
}
