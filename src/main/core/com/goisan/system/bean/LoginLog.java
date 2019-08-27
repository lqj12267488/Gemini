package com.goisan.system.bean;

import java.sql.Date;

/**
 * Created by admin on 2017/5/9.
 */
public class LoginLog {

    private String id ;
    private String userId ;
    private String userAccount ;
    private Date loginTime ;
    private String ip  ;
    private String mac   ;
    private String validFlag;
    private String num;
    private String loginTimeShow;

    public String getLoginTimeShow() {
        return loginTimeShow;
    }

    public void setLoginTimeShow(String loginTimeShow) {
        this.loginTimeShow = loginTimeShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(String userAccount) {
        this.userAccount = userAccount;
    }

    public Date getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Date loginTime) {
        this.loginTime = loginTime;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getMac() {
        return mac;
    }

    public void setMac(String mac) {
        this.mac = mac;
    }

    public String getValidFlag() {
        return validFlag;
    }

    public void setValidFlag(String validFlag) {
        this.validFlag = validFlag;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }
}
