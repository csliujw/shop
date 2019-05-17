package org.shop.dao;

import org.shop.pojo.Division;
import org.shop.pojo.Product;
import org.shop.utils.Page;

import java.util.List;

/**
 * 首页数据显示  商品一级类别 商品一级类别的二级类别
 *              各种类别数据的前10条
 * 浏览商品
 *              查看更多，按商品的分类进行搜索数据
 * 搜索商品
 *              按商品的名称搜索
 * 查看商品详情
 *              根据id查询商品的详细信息
 * */
public interface ProductOperateMapper {
    //查询所有信息 一级类别 二级类别 前台js弄成json格式 一级类别直接遍历 二级的追加
    List<Division> selectAllDetail();

    //查询所有数据 为可能存在的分页查询做准备   搜索条件 商品名称 一级类别  二级类别
    long selectAllProduct(Product product);

    //查询商品的前10条数据  首页每个类别的查询10条 需要用到一级类别作为查询条件 仅仅是商城首页数据的显示
    List<Product> selectProductLimit(Division division);

    //分页查询数据 条件 and 非条件 即便是AJAX也要用分页 一次20条数据 查询条件 商品名称 一级类别 二级类别
    List<Product> selectAllPageConditionProduct(Page<Product> page);

    //查询商品详细信息
    Product selectSingle(String id);

    //模糊查询
    List<Product> selectByName(Product pro);
}
