package com.goisan.practice.bean;

import com.goisan.system.bean.BaseBean;

public class SampleTable extends BaseBean {

    private String sampleName;
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSampleName() {
        return sampleName;
    }

    public void setSampleName(String sampleName) {
        this.sampleName = sampleName;
    }
}
