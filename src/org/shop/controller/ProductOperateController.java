package org.shop.controller;

import org.shop.pojo.Division;
import org.shop.pojo.Product;
import org.shop.service.ProductOperateService;
import org.shop.service.UserOperateService;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * 商品首页数据显示
 * 查询
 * 商品详情
 */
@Controller
@RequestMapping("products")
public class ProductOperateController {

    @Resource(name = "productOperateService")
    private ProductOperateService product;

    @Autowired
    @Qualifier("userOperateService")//通过注解和bean配置的方式混合注入
    private UserOperateService service;

    @RequestMapping("index.do")
    public String index(Model model, HttpServletRequest request) {
        List<Division> divisions = product.selectAllDetail();
        List<List<Product>> productList = new ArrayList<>();
        for (Division div : divisions) {
            List<Product> products = product.selectProductLimit(div);
            if (products.size() > 0) {
                productList.add(products);
            }
        }
        model.addAttribute("divisions", divisions);
        model.addAttribute("productList", productList);

        return "forward:/index.jsp";//项目级别的路径
    }

    /**
     * 一级二级类别搜索
     *
     * @param page
     * @param model
     * @param pro
     * @return
     */
    @RequestMapping("search.do")
    public String search(Page<Product> page, Model model, Product pro) {
        page.setCondition(pro);
        setLimitAndPage(page);
        List<Product> products = product.selectAllPageConditionProduct(page);
        model.addAttribute("products", products);
        if (pro.getDivision() != null) {
            return "forward:/product_list.jsp";
        } else {
            return "forward:/product_list_sub.jsp";
        }

    }

    //按名称查询
    @RequestMapping("searchByName.do")
    public String searchByName(Product pro, Model model) {
        if (pro.getProductName() == null) {
            pro.setProductName("");
        }
        List<Product> productList = product.selectProductByName(pro);
        model.addAttribute("products", productList);
        return "forward:/search_list.jsp";
    }

    @RequestMapping("more.do")
    @ResponseBody
    public List<Product> more(Page<Product> page, Product pro) {
        System.out.println(1231);
        page.setCondition(pro);
        setLimitAndPage(page);
        List<Product> list = product.selectAllPageConditionProduct(page);
        return list;
    }

    @RequestMapping("detail.do")
    public String detali(String productId, Model model) {
        Product pro = product.selectSingle(productId);
        model.addAttribute("productDetail", pro);
        return "forward:/product_info.jsp";
    }

    private void setLimitAndPage(Page<Product> page) {
        if (page.getLimit() == null || "".equals(page.getLimit())) {
            page.setLimit("24");
        }
        if (page.getPage() == null || "".equals(page.getPage())) {
            page.setPage("1");
        }
    }
}
