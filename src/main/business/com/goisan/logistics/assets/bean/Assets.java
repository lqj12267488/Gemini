package com.goisan.logistics.assets.bean;


import com.goisan.system.bean.BaseBean;

import java.util.Date;

public class Assets extends BaseBean {

    private String id;
    private String assetsName;
    private String assetsType;
    private String assetsNumAll;
    private String assetsNumIn;
    private String unit;
    private String price;
    private String specifications;
    private String brand;
    private String remark;
    private String status;
    private String inTime;
    private String assetsId;
    private String buyTime;
    private String buyTimeStr;

    public String getBuyTimeStr() {
        return buyTimeStr;
    }

    public void setBuyTimeStr(String buyTimeStr) {
        this.buyTimeStr = buyTimeStr;
    }

    public String getBuyTime() {
        return buyTime;
    }

    public void setBuyTime(String buyTime) {
        this.buyTime = buyTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAssetsName() {
        return assetsName;
    }

    public void setAssetsName(String assetsName) {
        this.assetsName = assetsName;
    }

    public String getAssetsType() {
        return assetsType;
    }

    public void setAssetsType(String assetsType) {
        this.assetsType = assetsType;
    }

    public String getAssetsNumAll() {
        return assetsNumAll;
    }

    public void setAssetsNumAll(String assetsNumAll) {
        this.assetsNumAll = assetsNumAll;
    }

    public String getAssetsNumIn() {
        return assetsNumIn;
    }

    public void setAssetsNumIn(String assetsNumIn) {
        this.assetsNumIn = assetsNumIn;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getInTime() {
        return inTime;
    }

    public void setInTime(String inTime) {
        this.inTime = inTime;
    }

    public String getAssetsId() {
        return assetsId;
    }

    public void setAssetsId(String assetsId) {
        this.assetsId = assetsId;
    }
}
