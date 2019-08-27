package com.goisan.crawler.bean;

import com.goisan.system.bean.BaseBean;

public class SensiWord extends BaseBean {
    private String id;
    private String sensiName;
    private String sensiType;
    private String sensiLevel;
    private String pid;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSensiName() {
        return sensiName;
    }

    public void setSensiName(String sensiName) {
        this.sensiName = sensiName;
    }

    public String getSensiType() {
        return sensiType;
    }

    public void setSensiType(String sensiType) {
        this.sensiType = sensiType;
    }

    public String getSensiLevel() {
        return sensiLevel;
    }

    public void setSensiLevel(String sensiLevel) {
        this.sensiLevel = sensiLevel;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }
}
