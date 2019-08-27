package com.goisan.system.bean;

public class SysDic extends BaseBean {
    private String id;
    private String name;
    private String dicname;
    private String diccode;
    private String parentid;
    private String dictype;
    private String dicorder;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDicname() {
        return dicname;
    }

    public void setDicname(String dicname) {
        this.dicname = dicname;
    }

    public String getDiccode() {
        return diccode;
    }

    public void setDiccode(String diccode) {
        this.diccode = diccode;
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid;
    }

    public String getDictype() {
        return dictype;
    }

    public void setDictype(String dictype) {
        this.dictype = dictype;
    }

    public String getDicorder() {
        return dicorder;
    }

    public void setDicorder(String dicorder) {
        this.dicorder = dicorder;
    }
}
