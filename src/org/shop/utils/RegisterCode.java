package org.shop.utils;

import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.SmsSingleSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;
import org.json.JSONException;

import java.io.IOException;

/**
 * 短信校验码
 */
public class RegisterCode {
    public static int appid = 1400207575; // 1400开头
    public static String appkey = "8572b7af54cbab44a50d346aedae6648";
    public static int templateId = 323829; //
    public static String smsSign = "月映青空"; //

    /***
     *
     * @param phoneNumbers
     * @return success will return the random code；default will return -1（String）
     */
    public static String sendMessage(String phoneNumbers) {
        try {
            String[] params = {(int) ((Math.random() + 1) * 1000) + "", "5"};//
            System.out.println(params[0]);
            SmsSingleSender ssender = new SmsSingleSender(appid, appkey);
            SmsSingleSenderResult result = ssender.sendWithParam("86", phoneNumbers,
                    templateId, params, smsSign, "", "");  //
            System.out.println(result);
            if ("OK".equals(result.errMsg)) {
                return params[0];
            }
            return "-1";
        } catch (HTTPException e) {
            // HTTP 响应码错误
            e.printStackTrace();
        } catch (JSONException e) {
            // JSON 解析错误
            e.printStackTrace();
        } catch (IOException e) {
            // 网络 IO 错误
            e.printStackTrace();
        }
        return "-1";
    }
}
