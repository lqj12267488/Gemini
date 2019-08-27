package com.goisan.system.tools;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

public class WeiXinUtils {

    private static final String APP_ID;
    private static final String APP_SECRET;
    private static final Map<String, String> DATA = new HashMap<>();
    private static final char[] CHARS = new char[]{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};

        //加载配置文件
    static {
        Properties prop = new Properties();
        String appId = "";
        String appSecret = "";
        try {
            prop.load(new FileInputStream(WeiXinUtils.class.getResource("/").getFile() + "/config.properties"));
            appId = prop.getProperty("appId");
            appSecret = prop.getProperty("appSecret");
        } catch (IOException e) {
            e.printStackTrace();
        }
        APP_ID = appId;
        APP_SECRET = appSecret;
    }

    /**
     * 通过appid和secret获取access_token
     *
     * @return access_token
     */
    public static String getToken() {
        String token = DATA.get("access_token");
        //如果token为空，去微信获取access_token
        if (token == null) {
            Map<String, String> param = new HashMap<>();
            param.put("grant_type", "client_credential");
            param.put("appid", APP_ID);
            param.put("secret", APP_SECRET);
            String result = doGet("https://api.weixin.qq.com/cgi-bin/token", param);
            Map map = JsonUtils.toBean2(result, Map.class);
            assert map != null;
            token = (String) map.get("access_token");
            if (token == null) {
                System.out.println(result);
            } else {
                DATA.put("access_token", token);
                //定时删除access_token，expires_in：过期时间
                timedDeletion("access_token", (Integer) map.get("expires_in"));
            }
        }
        return token;
    }

    /**
     * 获取JsapiTicket
     *
     * @return JsapiTicket
     */

    public static String getJsapiTicket() {
        String jsapiTicket = DATA.get("jsapiTicket");
        if (jsapiTicket == null) {
            Map<String, String> param = new HashMap<>();
            param.put("type", "jsapi");
            param.put("access_token", getToken());
            String result = doGet("https://api.weixin.qq.com/cgi-bin/ticket/getticket", param);
            System.out.println(result);
            Map map = JsonUtils.toBean2(result, Map.class);
            assert map != null;
            jsapiTicket = (String) map.get("ticket");
            DATA.put("jsapiTicket", jsapiTicket);
            timedDeletion("jsapiTicket", (Integer) map.get("expires_in"));
        }
        return jsapiTicket;
    }

    /**
     * 定时删除DATA中的值
     *
     * @param name 要删的值
     * @param time 多久后删除，单位秒
     */
    private static void timedDeletion(final String name, final long time) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Thread.sleep(time * 1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                DATA.remove(name);
            }
        }).start();
    }

    public static String doGet(String url, Map<String, String> param) {
        // 创建Httpclient对象
        CloseableHttpClient httpclient = HttpClients.createDefault();
        String result = null;
        CloseableHttpResponse response = null;
        try {
            // 创建uri
            URIBuilder builder = new URIBuilder(url);
            if (param != null) {
                for (String key : param.keySet()) {
                    builder.addParameter(key, param.get(key));
                }
            }
            URI uri = builder.build();
            // 创建http GET请求
            HttpGet httpGet = new HttpGet(uri);
            // 执行请求
            response = httpclient.execute(httpGet);
            // 判断返回状态是否为200
            if (response.getStatusLine().getStatusCode() == 200) {
                result = EntityUtils.toString(response.getEntity(), "UTF-8");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (response != null) {
                    response.close();
                }
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static Map<String, Object> generateConfig(String[] jsApiList, String url) {
        Map<String, Object> map = new HashMap<>();
        long timestamp = System.currentTimeMillis();
        String nonceStr = generateNonceStr();
        System.out.println(url);
        String signature = SHA1("jsapi_ticket=" + getJsapiTicket() + "&noncestr=" + nonceStr + "&timestamp=" + timestamp + "&url=" + url);
        map.put("appId", APP_ID);
        map.put("timestamp", timestamp);
        map.put("nonceStr", nonceStr);
        map.put("signature", signature);
        map.put("jsApiList", jsApiList);
        return map;
    }

    private static String generateNonceStr() {
        StringBuilder sb = new StringBuilder();
        Random r = new Random();
        for (int i = 0; i < 16; i++) {
            sb.append(CHARS[r.nextInt(CHARS.length)]);
        }
        return sb.toString();
    }


    private static String SHA1(String source) {
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("SHA");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        byte[] byteArray = source.getBytes(StandardCharsets.UTF_8);
        byte[] bytes = md.digest(byteArray);
        StringBuilder hexValue = new StringBuilder();
        for (byte b : bytes) {
            int val = ((int) b) & 0xff;
            if (val < 16) {
                hexValue.append("0");
            }
            hexValue.append(Integer.toHexString(val));
        }
        return hexValue.toString();
    }

    public static void main(String[] args) {
        System.out.println(WeiXinUtils.getToken());
        System.out.println(SHA1("jsapi_ticket=sM4AOVdWfPE4DxkXGEs8VMCPGGVi4C3VM0P37wVUCFvkVAy_90u5h9nbSlYy3-Sl-HhTdfl2fzFy1AOcHKP7qg&noncestr=Wm3WZYTPz0wzccnW&timestamp=1414587457&url=http://mp.weixin.qq.com?params=value"));
    }

}