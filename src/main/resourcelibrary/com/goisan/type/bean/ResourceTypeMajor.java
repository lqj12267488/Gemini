package com.goisan.type.bean;

import com.goisan.system.bean.BaseBean;

public class ResourceTypeMajor extends BaseBean {
    private String resourceMajorId;
    private String resourceMajorName;
    private String resourceMajorOrder;
    private String resourceSubjectId;
    private String remark;
    private String resourceSubjectIdShow;

    public String getResourceMajorId() {
        return resourceMajorId;
    }

    public void setResourceMajorId(String resourceMajorId) {
        this.resourceMajorId = resourceMajorId;
    }
    public String getResourceMajorName() {
        return resourceMajorName;
    }

    public void setResourceMajorName(String resourceMajorName) {
        this.resourceMajorName = resourceMajorName;
    }
    public String getResourceMajorOrder() {
        return resourceMajorOrder;
    }

    public void setResourceMajorOrder(String resourceMajorOrder) {
        this.resourceMajorOrder = resourceMajorOrder;
    }
    public String getResourceSubjectId() {
        return resourceSubjectId;
    }

    public void setResourceSubjectId(String resourceSubjectId) {
        this.resourceSubjectId = resourceSubjectId;
    }
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getResourceSubjectIdShow() {
        return resourceSubjectIdShow;
    }

    public void setResourceSubjectIdShow(String resourceSubjectIdShow) {
        this.resourceSubjectIdShow = resourceSubjectIdShow;
    }
}
