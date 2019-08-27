package com.goisan.filter;

import com.goisan.system.tools.DesUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

/**
 * @function:
 * @author: ZhangHao
 * @date: 2018/6/28
 */
public class FilterInfo implements HandlerInterceptor{
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        boolean bRet = false;

        try {

            Date dateInfo = getNetworkTime();

            if(dateInfo != null && !"".equals(dateInfo)){

                FileInputStream in = new FileInputStream(this.getClass().getResource("/").getPath() + "/config.properties");
                BufferedReader bf = new BufferedReader(new InputStreamReader(in));
                Properties pro = new Properties();
                pro.load(bf);

                String checkCode = pro.getProperty("checkCode");

                if(checkCode != null && !"".equals(checkCode)){

                    checkCode = checkCode.substring(4,checkCode.length())+checkCode.substring(0,4);//漂移

                    String code = DesUtil.decrypt(checkCode);

                    if("goisan_0531_13514404942".equals(code)){

                        return true;
                    }

                    if(code != null && !"".equals(code) && code.indexOf("goisan_0531_")!=-1){

                        String[] codeArr = code.split("_");

                        if(codeArr != null && codeArr.length >= 3){

                            String checkDate = codeArr[2];

                            if(checkDate != null && !"".equals(checkDate)){

                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                Date cDate = sdf.parse(checkDate);

                                if(dateInfo.before(cDate)){

                                    return true;
                                }
                            }
                        }
                    }
                }
            }

            if(!bRet){

                httpServletResponse.sendRedirect("http://122.138.192.204:8080/");
                return false;
            }

        } catch (Exception e) {

            e.printStackTrace();
            try {
                httpServletResponse.sendRedirect("http://122.138.192.204:8080/");
                return false;
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView){

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

    private static Date getNetworkTime() {
        try {

            String webUrl = "http://www.baidu.com";
            URL url = new URL(webUrl);
            URLConnection conn = url.openConnection();
            conn.connect();
            long dateL = conn.getDate();
            return new Date(dateL);

        } catch (MalformedURLException e) {

            e.printStackTrace();
            return new Date();

        } catch (IOException e) {
            e.printStackTrace();
            return new Date();
        }
    }
}
