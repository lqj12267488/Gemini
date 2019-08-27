package com.goisan.system.bean;

import java.sql.Timestamp;

/**
 * Created by Admin on 2017/4/24.
 */
public class BaseBean {
    private String creator;
    private Timestamp createTime;
    private String createDept;
    private String changer;
    private Timestamp changeTime;
    private String changeDept;
    private String validFlag;
    private String requestTime;
    private String level;


    public String getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(String requestTime) {
        this.requestTime = requestTime;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public String getCreateDept() {
        return createDept;
    }

    public void setCreateDept(String createDept) {
        this.createDept = createDept;
    }

    public String getChanger() {
        return changer;
    }

    public void setChanger(String changer) {
        this.changer = changer;
    }

    public Timestamp getChangeTime() {
        return changeTime;
    }

    public void setChangeTime(Timestamp changeTime) {
        this.changeTime = changeTime;
    }

    public String getChangeDept() {
        return changeDept;
    }

    public void setChangeDept(String changeDept) {
        this.changeDept = changeDept;
    }

    public String getValidFlag() {
        return validFlag;
    }

    public void setValidFlag(String validFlag) {
        this.validFlag = validFlag;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }


}
