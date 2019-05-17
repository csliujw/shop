package org.shop.pojo;

/**
 * 用户订单信息VO
 */
public class UserOrderVO {
    private String userId;
    private String start;
    private String end;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }
}
