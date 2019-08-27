package com.goisan.system.bean;

/**
 * Created by Administrator on 2017/5/6.
 */
public class UserDic extends BaseBean {
    private String id;
    private String name;
    private String dicname;
    private String diccode;
    private String dictype;
    private String dicorder;
    private String dicmark;
    private String dicurl;
    private String parentDicId;

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

    public String getDicmark() {
        return dicmark;
    }

    public void setDicmark(String dicmark) {
        this.dicmark = dicmark;
    }

    public String getDicurl() {
        return dicurl;
    }

    public void setDicurl(String dicurl) {
        this.dicurl = dicurl;
    }

    public String getParentDicId() {
        return parentDicId;
    }

    public void setParentDicId(String parentDicId) {
        this.parentDicId = parentDicId;
    }
}
