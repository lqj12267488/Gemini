package com.goisan.system.tools;

import com.goisan.system.bean.LoginLog;
import com.goisan.system.bean.LoginParameter;
import com.goisan.system.dao.LoginLogDao;
import com.goisan.system.service.ParameterService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2018/3/27.
 */
public class CasLoginTools {
    Subject currentUser;
    public CasLoginTools(){
        currentUser = SecurityUtils.getSubject();
    }
    public void login(String loginId, String password) {
        if (!currentUser.isAuthenticated()) {
            UsernamePasswordToken token = new UsernamePasswordToken(loginId, password);
            token.setRememberMe(false);
            try {
                currentUser.login(token);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
