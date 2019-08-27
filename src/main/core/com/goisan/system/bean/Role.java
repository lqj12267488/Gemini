package com.goisan.system.bean;

import java.io.Serializable;

/**
 * Created by Admin on 2017/4/15.
 */
public class Role extends BaseBean {
    private String roleid;
    private String  rolename;
    private String  roledescription;
    private String  roletype;
    private String  roletypeshow;

    public String getRoletypeshow() {
        return roletypeshow;
    }

    public void setRoletypeshow(String roletypeshow) {
        this.roletypeshow = roletypeshow;
    }

    public String getRoleid() {
        return roleid;
    }

    public void setRoleid(String roleid) {
        this.roleid = roleid;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getRoledescription() {
        return roledescription;
    }

    public void setRoledescription(String roledescription) {
        this.roledescription = roledescription;
    }

    public String getRoletype() {
        return roletype;
    }

    public void setRoletype(String roletype) {
        this.roletype = roletype;
    }
}
