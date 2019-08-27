package com.goisan.system.bean;

import java.util.List;

/**
 * Created by Admin on 2017/4/21.
 */
public class Menu extends BaseBean {
    private String resourceid;
    private String resourcename;
    private String parentresourceid;
    private String resourceurl;
    private int resourcetype;
    private List<Menu> menuList;
    private int resourceorder;
    private String system;

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    private String remark;

    public String getSystem() {
        return system;
    }

    public void setSystem(String system) {
        this.system = system;
    }

    public int getResourceorder() {
        return resourceorder;
    }

    public void setResourceorder(int resourceorder) {
        this.resourceorder = resourceorder;
    }

    public List<Menu> getMenuList() {
        return menuList;
    }

    public void setMenuList(List<Menu> menuList) {
        this.menuList = menuList;
    }

    public void setResourceid(String resourceid) {
        this.resourceid = resourceid;
    }

    public void setResourcename(String resourcename) {
        this.resourcename = resourcename;
    }

    public void setParentresourceid(String parentresourceid) {
        this.parentresourceid = parentresourceid;
    }

    public void setResourceurl(String resourceurl) {
        this.resourceurl = resourceurl;
    }

    public String getResourceid() {
        return resourceid;
    }

    public String getResourcename() {
        return resourcename;
    }

    public String getParentresourceid() {
        return parentresourceid;
    }

    public String getResourceurl() {
        return resourceurl;
    }

    public int getResourcetype() {
        return resourcetype;
    }

    public void setResourcetype(int resourcetype) {
        this.resourcetype = resourcetype;
    }


}
