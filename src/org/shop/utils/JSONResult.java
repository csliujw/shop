package org.shop.utils;

public class JSONResult {
    public static String add(boolean condition) {
        return condition ? "{\"message\":\"添加成功\"}" : "{\"message\":\"添加失败,请检查是否已存在该名称\"}";
    }

    public static String update(boolean condition) {
        return condition ? "{\"message\":\"更新成功\"}" : "{\"message\":\"更新失败\"}";
    }

    public static String deleteDivision(boolean condition) {
        return condition ? "{\"message\":\"删除成功\"}" : "{\"message\":\"删除失败,请确认所选类别无二级子类！\"}";
    }

    public static String deletesDivision(boolean condition) {
        return condition ? "{\"message\":\"全部删除成功\"}" : "{\"message\":\"部分删除失败，请确认所选类别无二级子类！\"}";
    }

    public static String deleteUser(boolean condition) {
        return condition ? "{\"message\":\"删除成功\"}" : "{\"message\":\"删除失败,请检查用户是否已经注销！\"}";
    }

    public static String deletesUser(boolean condition) {
        return condition ? "{\"message\":\"全部删除成功\"}" : "{\"message\":\"删除失败,请检查用户是否已经注销！\"}";
    }

    public static String delete(boolean condition) {
        return condition ? "{\"message\":\"删除成功\"}" : "{\"message\":\"删除失败！\"}";
    }

    public static String deletes(boolean condition) {
        return condition ? "{\"message\":\"全部删除成功\"}" : "{\"message\":\"部分删除失败！\"}";
    }
}
