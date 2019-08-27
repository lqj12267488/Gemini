package com.goisan.type.bean;

import com.goisan.system.bean.BaseBean;

public class ResourceTypeSubject extends BaseBean {
    private String resourceSubjectId;
    private String resourceSubjectName;
    private String resourceSubjectOrder;
    private String remark;

    public String getResourceSubjectId() {
        return resourceSubjectId;
    }

    public void setResourceSubjectId(String resourceSubjectId) {
        this.resourceSubjectId = resourceSubjectId;
    }
    public String getResourceSubjectName() {
        return resourceSubjectName;
    }

    public void setResourceSubjectName(String resourceSubjectName) {
        this.resourceSubjectName = resourceSubjectName;
    }
    public String getResourceSubjectOrder() {
        return resourceSubjectOrder;
    }

    public void setResourceSubjectOrder(String resourceSubjectOrder) {
        this.resourceSubjectOrder = resourceSubjectOrder;
    }
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
