package com.goisan.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Admin on 2017/5/6.
 */
public class Workflow extends BaseBean {
    private String workflowId;
    private String workflowName;
    private String workflowCode;
    private String workflowRemark;
    private String openFlag;
    private String tableName;
    private String url;
    private String businessId;

    public String getWorkflowId() {
        return workflowId;
    }

    public void setWorkflowId(String workflowId) {
        this.workflowId = workflowId;
    }

    public String getWorkflowName() {
        return workflowName;
    }

    public void setWorkflowName(String workflowName) {
        this.workflowName = workflowName;
    }

    public String getOpenFlag() {
        return openFlag;
    }

    public void setOpenFlag(String openFlag) {
        this.openFlag = openFlag;
    }

    public String getWorkflowCode() {
        return workflowCode;
    }

    public void setWorkflowCode(String workflowCode) {
        this.workflowCode = workflowCode;
    }

    public String getWorkflowRemark() {
        return workflowRemark;
    }

    public void setWorkflowRemark(String workflowRemark) {
        this.workflowRemark = workflowRemark;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }
}
