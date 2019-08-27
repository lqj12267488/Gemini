package com.goisan.workflow.bean;

import com.goisan.system.bean.BaseBean;

public class Opinion extends BaseBean {
    private String opinionId;
    private String opinionType;
    private String opinionContent;

    public String getOpinionId() {
        return opinionId;
    }

    public void setOpinionId(String opinionId) {
        this.opinionId = opinionId;
    }
    public String getOpinionType() {
        return opinionType;
    }

    public void setOpinionType(String opinionType) {
        this.opinionType = opinionType;
    }
    public String getOpinionContent() {
        return opinionContent;
    }

    public void setOpinionContent(String opinionContent) {
        this.opinionContent = opinionContent;
    }
}
