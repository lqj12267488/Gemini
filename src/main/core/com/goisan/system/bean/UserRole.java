package com.goisan.system.bean;

import java.io.Serializable;

/**
 * Created by Admin on 2017/4/17.
 */
public class UserRole implements Serializable {
    private Integer id;
    private String loginId;
    private String roleId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
}
