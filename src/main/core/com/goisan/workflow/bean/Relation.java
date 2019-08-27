package com.goisan.workflow.bean;


import com.goisan.system.bean.BaseBean;

public class Relation extends BaseBean {

    private String id;
    private String workflowId;
    private String tableName;
    private String url;
    private String appUrl;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public String getWorkflowId() {
        return workflowId;
    }

    public void setWorkflowId(String workflowId) {
        this.workflowId = workflowId;
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


    public String getAppUrl() {
        return appUrl;
    }

    public void setAppUrl(String appUrl) {
        this.appUrl = appUrl;
    }

}
