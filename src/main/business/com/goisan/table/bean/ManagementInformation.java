package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class ManagementInformation extends BaseBean {

    /**主键id*/
    private String id;

    /**{glxxxtlx}类型*/
    private String type;

   private String typeShow;

    /**系统名称(全称)*/
    private String systemName;

    /**{glxxxtly}来源*/
    private String sources;

   private String sourcesShow;

    /**开发单位名称(全称)*/
    private String unitName;

    /**年份*/
    private String year;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypeShow() {
        return typeShow;
    }

    public void setTypeShow(String typeShow) {
        this.typeShow = typeShow;
    }

    public String getSystemName() {
        return systemName;
    }

    public void setSystemName(String systemName) {
        this.systemName = systemName;
    }

    public String getSources() {
        return sources;
    }

    public void setSources(String sources) {
        this.sources = sources;
    }

    public String getSourcesShow() {
        return sourcesShow;
    }

    public void setSourcesShow(String sourcesShow) {
        this.sourcesShow = sourcesShow;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

}
