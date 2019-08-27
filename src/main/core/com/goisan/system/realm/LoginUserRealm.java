package com.goisan.system.realm;

import com.goisan.system.bean.LoginUser;
import com.goisan.system.service.LoginUserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Admin on 2017/4/11.
 */
public class LoginUserRealm extends AuthorizingRealm {
    @Resource
    private LoginUserService loginUserService;

    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        // 从 PrincipalCollection 中来获取登录用户的信息
        LoginUser user = (LoginUser) principals.getPrimaryPrincipal();
        // 创建 SimpleAuthorizationInfo, 并设置其 reles 属性.
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.addRoles(user.getRoles());
        info.addStringPermissions(user.getPermissions());
        // 返回 SimpleAuthorizationInfo 对象.
        return info;
    }

    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws
            AuthenticationException {
        //把 AuthenticationToken 转换为 UsernamePasswordToken
        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        //从 UsernamePasswordToken 中来获取 username
        String username = upToken.getUsername();
        //调用数据库的方法, 从数据库中查询 username 对应的用户记录
        LoginUser user = loginUserService.getLoginUserByLoginId(username);
        if ("sa".equals(username)) {
            Set<String> roles = new HashSet<>();
            roles.add("SYS");
            user.setRoles(roles);
            user.setPermissions(roles);
        }
        //若用户不存在, 则可以抛出 UnknownAccountException 异常
        if (user == null || "0".equals(user.getValidFlag())) {
            throw new UnknownAccountException("用户不存在!");
        }
        LoginUser loginUser = null;
        if ("0".equals(user.getUserType())) {
            loginUser = loginUserService.getLoginUserRolesByLoginId(user.getUserAccount());
        }

        if ("1".equals(user.getUserType())) {
            loginUser = loginUserService.getStudentRolesByLoginId(user.getUserAccount());
        }
        if ("2".equals(user.getUserType())) {
            loginUser = loginUserService.getParentStudentUserRolesByLoginId(user.getUserAccount());
        }
        if (loginUser != null) {
            user = loginUser;
        }

        SimpleAuthenticationInfo info;
        if (upToken.getPassword() == null) {
            upToken.setPassword("123456".toCharArray());
            info = new SimpleAuthenticationInfo(user, "e10adc3949ba59abbe56e057f20f883e", getName());
        } else {
            info = new SimpleAuthenticationInfo(user, user.getPassword(), getName());
        }
        //根据用户信息的情况, 决定是否需要抛出其他的 AuthenticationException 异常.
        return info;
    }
}
