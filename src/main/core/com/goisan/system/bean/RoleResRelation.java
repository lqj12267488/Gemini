package com.goisan.system.bean;

import java.util.List;

/**
 * Created by admin on 2017/4/28.
 */
public class RoleResRelation extends BaseBean{
    private String id ;
    private String roleid ;
    private String resourceid ;
    private String resourcetype;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRoleid() {
        return roleid;
    }

    public void setRoleid(String roleid) {
        this.roleid = roleid;
    }

    public String getResourceid() {
        return resourceid;
    }

    public void setResourceid(String resourceid) {
        this.resourceid = resourceid;
    }

    public String getResourcetype() {
        return resourcetype;
    }

    public void setResourcetype(String resourcetype) {
        this.resourcetype = resourcetype;
    }
}
