package org.shop.service;

import org.shop.dao.ProductOperateMapper;
import org.shop.pojo.Division;
import org.shop.pojo.Product;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class ProductOperateService {
    @Autowired
    private ProductOperateMapper productOperateMapper;

    //查询所有信息 一级类别 二级类别 前台js弄成json格式 一级类别直接遍历 二级的追加
    public List<Division> selectAllDetail() {
        return productOperateMapper.selectAllDetail();
    }

    //查询所有数据 为可能存在的分页查询做准备   搜索条件 商品名称 一级类别  二级类别
    public long selectAllProduct(Product product) {
        return productOperateMapper.selectAllProduct(product);
    }

    //查询商品的前10条数据  首页每个类别的查询10条 需要用到一级类别作为查询条件 仅仅是商城首页数据的显示
    public List<Product> selectProductLimit(Division division) {
        return productOperateMapper.selectProductLimit(division);
    }

    //分页查询数据 条件 and 非条件 即便是AJAX也要用分页 一次20条数据 查询条件 商品名称 一级类别 二级类别
    //需要 内部分页设置数据
    public List<Product> selectAllPageConditionProduct(Page<Product> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            page.setLimit("20");
            List<Product> products = productOperateMapper.selectAllPageConditionProduct(page);
            return products;
        } catch (Exception e) {
            return null;
        }
    }

    //查询商品详细信息
    public Product selectSingle(String id) {
        return productOperateMapper.selectSingle(id);
    }

    //商品信息模糊查询
    public List<Product> selectProductByName(Product pro) {
        return productOperateMapper.selectByName(pro);
    }
}
