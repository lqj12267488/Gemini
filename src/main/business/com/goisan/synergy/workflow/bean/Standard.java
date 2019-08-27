package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/9/28.
 */
public class Standard extends BaseBean{
    private String id;
    private String standardType;
    private String standardName;
    private String standardContent;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStandardType() {
        return standardType;
    }

    public void setStandardType(String standardType) {
        this.standardType = standardType;
    }

    public String getStandardName() {
        return standardName;
    }

    public void setStandardName(String standardName) {
        this.standardName = standardName;
    }

    public String getStandardContent() {
        return standardContent;
    }

    public void setStandardContent(String standardContent) {
        this.standardContent = standardContent;
    }
}
