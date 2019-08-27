package com.goisan.data.bean;

import com.goisan.system.bean.BaseBean;

public class Data extends BaseBean {
    private String dataId;
    private String dataName;
    private String dataFirstType;
    private String dataSecondType;
    private String bookshelfName;
    private String bookshelfLayer;
    private String dataLocation;
    private String arrayLocation;
    private String dataThirdType;
    private String submitTime;

    public String getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(String submitTime) {
        this.submitTime = submitTime;
    }

    public String getDataThirdType() {
        return dataThirdType;
    }

    public void setDataThirdType(String dataThirdType) {
        this.dataThirdType = dataThirdType;
    }

    public String getDataId() {
        return dataId;
    }

    public void setDataId(String dataId) {
        this.dataId = dataId;
    }

    public String getDataName() {
        return dataName;
    }

    public void setDataName(String dataName) {
        this.dataName = dataName;
    }

    public String getDataFirstType() {
        return dataFirstType;
    }

    public void setDataFirstType(String dataFirstType) {
        this.dataFirstType = dataFirstType;
    }

    public String getDataSecondType() {
        return dataSecondType;
    }

    public void setDataSecondType(String dataSecondType) {
        this.dataSecondType = dataSecondType;
    }

    public String getBookshelfName() {
        return bookshelfName;
    }

    public void setBookshelfName(String bookshelfName) {
        this.bookshelfName = bookshelfName;
    }

    public String getBookshelfLayer() {
        return bookshelfLayer;
    }

    public void setBookshelfLayer(String bookshelfLayer) {
        this.bookshelfLayer = bookshelfLayer;
    }

    public String getDataLocation() {
        return dataLocation;
    }

    public void setDataLocation(String dataLocation) {
        this.dataLocation = dataLocation;
    }

    public String getArrayLocation() {
        return arrayLocation;
    }

    public void setArrayLocation(String arrayLocation) {
        this.arrayLocation = arrayLocation;
    }
}
