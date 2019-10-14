package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class SchAward extends BaseBean {

    /**主键id，使用uuid*/
    private String id;

    /**序号*/
    private String saIndex;

    /**项目名称（全称）*/
    private String saProName;

    /**项目级别{jb}*/
    private String saProLev;

   private String saProLevShow;

    /**获奖日期*/
    private String saTime;

    /**备注*/
    private String remark;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSaIndex() {
        return saIndex;
    }

    public void setSaIndex(String saIndex) {
        this.saIndex = saIndex;
    }

    public String getSaProName() {
        return saProName;
    }

    public void setSaProName(String saProName) {
        this.saProName = saProName;
    }

    public String getSaProLev() {
        return saProLev;
    }

    public void setSaProLev(String saProLev) {
        this.saProLev = saProLev;
    }

    public String getSaProLevShow() {
        return saProLevShow;
    }

    public void setSaProLevShow(String saProLevShow) {
        this.saProLevShow = saProLevShow;
    }

    public String getSaTime() {
        return saTime;
    }

    public void setSaTime(String saTime) {
        this.saTime = saTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

}
