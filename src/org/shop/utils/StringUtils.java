package org.shop.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串校验工具类
 */
public class StringUtils {
    /**
     * @param str
     * @return
     */
    public boolean orNumeric(String str) {
        Pattern pattern = Pattern.compile("[0-9]*");
        Matcher isNum = pattern.matcher(str);
        return isNum.matches();
    }

    /***
     * 是否是整数
     * @return
     */
    public boolean orInteger(String str) {
        Double result = Double.parseDouble(str);
        Double i = result - Math.floor(result);
        return i == 0;
    }

    /**
     * 是否大于0
     */
    public boolean orOverZero(String str) {
        return Integer.parseInt(str) > 0;
    }
}
