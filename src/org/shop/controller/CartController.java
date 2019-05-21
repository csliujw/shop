package org.shop.controller;

import org.shop.pojo.*;
import org.shop.service.CartService;
import org.shop.service.ProductOperateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping(value = "cart", produces = "application/json;charset=utf-8")
public class CartController {

    @Autowired
    @Qualifier("cartService")
    private CartService service;
    @Autowired
    @Qualifier("productOperateService")
    private ProductOperateService productSerivce;

    /**
     * 添加一件商品至购物车中
     *
     * @return
     */
    @RequestMapping("add.do")
    @ResponseBody
    public String addCart(@RequestBody CartItem item, HttpSession session) {
        try {
            if (item != null) {
                int intStr = item.getBuyNum();
                if (intStr < 0 || intStr - Math.floor(intStr) > 0.0000000001) {
                    return "{\"code\":\"Default\"}";
                }
            }
        } catch (Exception e) {
            return "{\"code\":\"Default\"}";
        }

        User user = (User) session.getAttribute("userInfo");
        item.setUserId(user.getUserId());
        item.setOrderItemId(UUID.randomUUID().toString());
        Cart cart = (Cart) session.getAttribute("cart");
        //获得商品信息
        Product product = productSerivce.selectSingle(item.getProduct().getProductId());
        item.setSubtotal(product.getProductShopPrice() * item.getBuyNum());
        item.setProduct(product);
        if (cart == null) {
            cart = new Cart();
            cart.getCartItems().put(item.getProduct().getProductName(), item);
        } else {
            CartItem temp = cart.getCartItems().get(item.getProduct().getProductName());
            if (temp != null) {
                //判断是否存在该物品，存在则count累加
                int tempCount = temp.getBuyNum();
                tempCount += item.getBuyNum();
                double tempSubtotal = temp.getSubtotal();
                tempSubtotal += item.getSubtotal();
                temp.setBuyNum(tempCount);
                temp.setSubtotal(tempSubtotal);
            } else {
                //不存在则直接放进去
                cart.getCartItems().put(item.getProduct().getProductName(), item);
            }
        }
        session.setAttribute("cart", cart);
        return "{\"code\":\"OK\"}";
    }

    /**
     * 从购物车中移除商品
     *
     * @return
     */
    @RequestMapping("remove.do")
    public String removeCart(String productName, HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.getCartItems().remove(productName);
        }
        session.setAttribute("cart", cart);
        return "redirect:/cart/currentOrder.do";
    }

    //查看session中的订单信息
    @RequestMapping("currentOrder.do")
    public String selectCurrentOrder(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            Map<String, CartItem> cartItems = cart.getCartItems();
            double sub = 0.0;
            Set<String> cartSet = cartItems.keySet();
            //计算商品总价格
            for (String temp : cartSet) {
                sub += cartItems.get(temp).getSubtotal();
            }
            cart.setTotal(sub);
            cart.setCartItems(cartItems);
        } else {
            cart = new Cart();
            cart.setCartItems(new HashMap<String, CartItem>());
        }
        session.setAttribute("cart", cart);
        return "redirect:/cart.jsp";
    }

    /**
     * 提交商品至数据库
     *
     * @param session
     * @return
     */
    @RequestMapping("addProduct.do")
    public String addProduct(HttpSession session, String userId) {
        Cart cart = (Cart) session.getAttribute("cart");
        Set<String> setStr = cart.getCartItems().keySet();
        List<CartItem> list = new ArrayList<>();
        for (String s : setStr) {
            CartItem cartItem = cart.getCartItems().get(s);
            cartItem.setOrderItemId(UUID.randomUUID().toString());
            list.add(cartItem);
        }
        //购物车中的数据写入数据库
        service.addProduct(list);
        //同时更新购物车信息
        session.setAttribute("cart", cart);
        //跳转至 将购物车和数据库中同时存在的数据遍历存储起来
        return "redirect:/cart/selectOrders.do?userId=" + userId;
    }

    /**
     * 查询所有未付款订单的信息
     */
    @RequestMapping("selectOrders.do")
    public String selectOrders(String userId, HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        Map<String, CartItem> cartItems = cart.getCartItems();
        List<OrderItem> orderItems = service.selectOrderItem(userId);
        List<CartItem> temp = new ArrayList<>();
        //购物车中的，且写入数据库的为当前订单信息 item是冲数据库中查询的
        for (OrderItem item : orderItems) {
            //购物车中的数据信息 如何避免重复的数据
            CartItem cartItem = cartItems.get(item.getProduct().getProductName());
            if (cartItem != null && item.getOrderItemId().equals(cartItem.getOrderItemId())) {
                temp.add(cartItem);
            }
        }
        //方便下一次写入数据库直接拿
        session.setAttribute("currentOrderItemList", temp);
        //跳转至订单视图界面
        return "forward:/order_info.jsp";
    }

    @RequestMapping("orders.do")
    public String orders(HttpSession session, User user, Model model) {
        double price = 0.0;
        List<CartItem> list = (List<CartItem>) session.getAttribute("currentOrderItemList");
        if (list == null) {
            session.setAttribute("orderMessage", "暂无订单信息!");
            return "redirect:/order_info.jsp";
        }
        System.out.println("real?");
        for (CartItem temp : list) {
            price += temp.getSubtotal();
        }
        User userInfo = (User) session.getAttribute("userInfo");
        userInfo.setUserAddress(user.getUserAddress());
        userInfo.setUserTelephone(user.getUserTelephone());
        Orders orders = new Orders();
        orders.setUser(userInfo);
        String ordersId = UUID.randomUUID().toString();
        //跟新那些order_item的数据
        CartVO vo = new CartVO();
        vo.setList(list);
        vo.setOrdersId(ordersId);
        service.updateOrderItem(vo);
        //更新订单表
        orders.setOrdersId(ordersId);
        orders.setOrdersLogistics("正在加紧发送，请耐心等待!");
        orders.setOrdersTotal(price + "");
        boolean b = service.addOrders(orders);
        session.removeAttribute("currentOrderItemList");
        session.removeAttribute("cart");
        session.setAttribute("orderMessage", "提交成功!请耐心等待发货!");
        return "redirect:/order_info.jsp";
    }

    @RequestMapping("addOrders.do")
    public String addOrders(Orders orders) {
        boolean add = service.addOrders(orders);
        return add ? "{\"code\":\"OK\"}" : "{\"code\":\"default\"}";
    }

    //未付款订单付款
    @RequestMapping("pay.do")
    public String pay(String orderItemId, HttpSession session) {
        OrderItem orderItem = service.selectOrderItemById(orderItemId);
        List<CartItem> list = new ArrayList<>();
        CartItem cartItem = new CartItem();
        cartItem.setProduct(orderItem.getProduct());
        cartItem.setOrderItemId(orderItem.getOrderItemId());
        cartItem.setSubtotal(orderItem.getOrderItemSubtotal());
        cartItem.setBuyNum(orderItem.getOrderItemCount());
        list.add(cartItem);
        session.setAttribute("currentOrderItemList", list);
        return "forward:/order_info.jsp";
    }
}
