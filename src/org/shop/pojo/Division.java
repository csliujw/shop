package org.shop.pojo;

import java.util.List;

/**
 * 商品一级分类
 * 一级分类中包含多个子类，故用Subdivision作为其字段
 * 一对多的关系
 */
public class Division {
    private String divisionId;
    private String divisionName;
    private String divisionOrDelete;
    private List<Subdivision> subdivision;

    public String getDivisionId() {
        return divisionId;
    }

    public void setDivisionId(String divisionId) {
        this.divisionId = divisionId;
    }

    public String getDivisionName() {
        return divisionName;
    }

    public void setDivisionName(String divisionName) {
        this.divisionName = divisionName;
    }

    public String getDivisionOrDelete() {
        return divisionOrDelete;
    }

    public void setDivisionOrDelete(String divisionOrDelete) {
        this.divisionOrDelete = divisionOrDelete;
    }

    public List<Subdivision> getSubdivision() {
        return subdivision;
    }

    public void setSubdivision(List<Subdivision> subdivision) {
        this.subdivision = subdivision;
    }

    @Override
    public String toString() {
        return "Division{" +
                "divisionId='" + divisionId + '\'' +
                ", divisionName='" + divisionName + '\'' +
                ", divisionOrDelete='" + divisionOrDelete + '\'' +
                ", subdivision=" + subdivision +
                '}';
    }
}
