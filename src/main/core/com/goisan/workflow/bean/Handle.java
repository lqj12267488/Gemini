package com.goisan.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Admin on 2017/5/7.
 */
public class Handle extends BaseBean {
    private String id;
    private String startId;
    private String cuurentWorkflowId;
    private String cuurentNodeId;
    private String handleUser;
    private String handleName;
    private String handleRole;
    private String handleTime;
    private String handleDept;
    private String state;
    private String remark;

    public String getHandleDept() {
        return handleDept;
    }

    public void setHandleDept(String handleDept) {
        this.handleDept = handleDept;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStartId() {
        return startId;
    }

    public void setStartId(String startId) {
        this.startId = startId;
    }

    public String getCuurentWorkflowId() {
        return cuurentWorkflowId;
    }

    public void setCuurentWorkflowId(String cuurentWorkflowId) {
        this.cuurentWorkflowId = cuurentWorkflowId;
    }

    public String getCuurentNodeId() {
        return cuurentNodeId;
    }

    public void setCuurentNodeId(String cuurentNodeId) {
        this.cuurentNodeId = cuurentNodeId;
    }

    public String getHandleUser() {
        return handleUser;
    }

    public void setHandleUser(String handleUser) {
        this.handleUser = handleUser;
    }

    public String getHandleName() {
        return handleName;
    }

    public void setHandleName(String handleName) {
        this.handleName = handleName;
    }

    public String getHandleRole() {
        return handleRole;
    }

    public void setHandleRole(String handleRole) {
        this.handleRole = handleRole;
    }

    public String getHandleTime() {
        return handleTime;
    }

    public void setHandleTime(String handleTime) {
        this.handleTime = handleTime;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
