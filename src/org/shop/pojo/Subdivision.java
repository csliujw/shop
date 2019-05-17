package org.shop.pojo;

/**
 * 商品二级类别信息
 */
public class Subdivision {
    private String subdivisionId;
    private String subdivisionName;
    private Division division;
    private String subdivisionOrDelete;

    public String getSubdivisionId() {
        return subdivisionId;
    }

    public void setSubdivisionId(String subdivisionId) {
        this.subdivisionId = subdivisionId;
    }

    public String getSubdivisionName() {
        return subdivisionName;
    }

    public void setSubdivisionName(String subdivisionName) {
        this.subdivisionName = subdivisionName;
    }

    public Division getDivision() {
        return division;
    }

    public void setDivision(Division division) {
        this.division = division;
    }

    public String getSubdivisionOrDelete() {
        return subdivisionOrDelete;
    }

    public void setSubdivisionOrDelete(String subdivisionOrDelete) {
        this.subdivisionOrDelete = subdivisionOrDelete;
    }

    @Override
    public String toString() {
        return "Subdivision{" +
                "subdivisionId='" + subdivisionId + '\'' +
                ", subdivisionName='" + subdivisionName + '\'' +
                ", division=" + division +
                ", subdivisionOrDelete='" + subdivisionOrDelete + '\'' +
                '}';
    }
}
