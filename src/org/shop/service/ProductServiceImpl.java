package org.shop.service;

import com.google.gson.Gson;
import org.shop.dao.ProductMapper;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.Product;
import org.shop.utils.JSONData;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class ProductServiceImpl implements IBaseService<Product> {
    @Autowired
    private ProductMapper productMapper;

    @Override
    public boolean add(Product product) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        product.setProductDate(sdf.format(new Date()));
        product.setProductId(UUID.randomUUID().toString());
        boolean add = productMapper.addProduct(product);
        return add;
    }

    @Override
    public boolean update(Product product) {
        boolean update = productMapper.updateProduct(product);
        return update;
    }

    @Override
    public boolean delete(Product product) {
        boolean delete = productMapper.deleteProduct(product);
        return delete;
    }

    @Override
    public boolean deleteBatch(DeleteVO vo) {
        int count = productMapper.deleteBatchProduct(vo);
        return count == vo.getIds().length;
    }

    @Override
    public long selectAll(Product product) {
        long count = productMapper.selectAllProduct(product);
        return count;
    }

    @Override
    public String selectAllPageCondition(Page<Product> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<Product> products = productMapper.selectAllPageConditionProduct(page);
            long count = productMapper.selectAllProduct(page.getCondition());
            return new Gson().toJson(new JSONData<Product>(count + "", products));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<Product>("0", null));
        }
    }

    @Override
    public String selectSingle(Product product) {
        return null;
    }

    @Override
    public List<Product> selectAllDetail(boolean orDelete) {
        return null;
    }
}
