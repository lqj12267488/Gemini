package com.goisan.log.bean;

import com.goisan.system.bean.BaseBean;

public class ResourceLog extends BaseBean {
    private String logId;
    private String resourceId;
    private String resourceName;
    private String personId;
    private String deptId;
    private String operateType;
    private String operateTime;
    private String operateTypeShow;
    private String personIdShow;
    private String publicPersonId;

    public String getLogId() {
        return logId;
    }

    public void setLogId(String logId) {
        this.logId = logId;
    }

    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getOperateType() {
        return operateType;
    }

    public void setOperateType(String operateType) {
        this.operateType = operateType;
    }

    public String getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(String operateTime) {
        this.operateTime = operateTime;
    }

    public String getOperateTypeShow() {
        return operateTypeShow;
    }

    public void setOperateTypeShow(String operateTypeShow) {
        this.operateTypeShow = operateTypeShow;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }

    public String getPublicPersonId() {
        return publicPersonId;
    }

    public void setPublicPersonId(String publicPersonId) {
        this.publicPersonId = publicPersonId;
    }
}
