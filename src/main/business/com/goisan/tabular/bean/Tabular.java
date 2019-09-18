package com.goisan.tabular.bean;

import com.goisan.system.bean.BaseBean;

public class Tabular extends BaseBean {
    private String id;
    private String tabularName;
    private String tabularType;
    private String fileName;
    private String uploadTime;
    private String serialNumber;
    private String tableAttribute;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTabularName() {
        return tabularName;
    }

    public void setTabularName(String tabularName) {
        this.tabularName = tabularName;
    }

    public String getTabularType() {
        return tabularType;
    }

    public void setTabularType(String tabularType) {
        this.tabularType = tabularType;
    }

    public String getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getTableAttribute() {
        return tableAttribute;
    }

    public void setTableAttribute(String tableAttribute) {
        this.tableAttribute = tableAttribute;
    }
}
