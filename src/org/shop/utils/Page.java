package org.shop.utils;

/**
 * Page分页工具类
 */
public class Page<T> {
    //起始页号
    private String page;
    //分页查询起始索引
    private String start;
    //查询数目
    private String limit;
    //查询条件
    private T condition;

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getLimit() {
        return limit;
    }

    public void setLimit(String limit) {
        this.limit = limit;
    }

    public T getCondition() {
        return condition;
    }

    public void setCondition(T condition) {
        this.condition = condition;
    }
}
