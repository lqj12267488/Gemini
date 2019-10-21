package com.goisan.logistics.assets.bean;


import com.goisan.system.bean.BaseBean;

import java.sql.Timestamp;
import java.util.Date;

public class AssetsDetails extends BaseBean {

    private String assetsId;
    private String assetsName;
    private String parentAssetsId;
    private String assetsType;
    private String assetsNum;
    private String inTime;
    private String unit;
    private String price;
    private String specifications;
    private String brand;
    private String remark;
    private String status;
    private String useType;
    private String userDept;
    private String userId;
    private Date useTime;
    private String useTimeStr;
    private String usePosition;
    private String direction;
    private String useTimeShow;
    private String scrapReson;
    private Date buyTime;
    private String buyTimeStr;


    public Date getUseTime() {
        return useTime;
    }

    public void setUseTime(Date useTime) {
        this.useTime = useTime;
    }

    public String getUseTimeStr() {
        return useTimeStr;
    }

    public void setUseTimeStr(String useTimeStr) {
        this.useTimeStr = useTimeStr;
    }

    public Date getBuyTime() {
        return buyTime;
    }

    public void setBuyTime(Date buyTime) {
        this.buyTime = buyTime;
    }

    public String getBuyTimeStr() {
        return buyTimeStr;
    }

    public void setBuyTimeStr(String buyTimeStr) {
        this.buyTimeStr = buyTimeStr;
    }

    public String getAssetsId() {
        return assetsId;
    }

    public void setAssetsId(String assetsId) {
        this.assetsId = assetsId;
    }

    public String getParentAssetsId() {
        return parentAssetsId;
    }

    public void setParentAssetsId(String parentAssetsId) {
        this.parentAssetsId = parentAssetsId;
    }

    public String getAssetsType() {
        return assetsType;
    }

    public void setAssetsType(String assetsType) {
        this.assetsType = assetsType;
    }

    public String getAssetsNum() {
        return assetsNum;
    }

    public void setAssetsNum(String assetsNum) {
        this.assetsNum = assetsNum;
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

    public String getUseType() {
        return useType;
    }

    public void setUseType(String useType) {
        this.useType = useType;
    }

    public String getUserDept() {
        return userDept;
    }

    public void setUserDept(String userDept) {
        this.userDept = userDept;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUsePosition() {
        return usePosition;
    }

    public void setUsePosition(String usePosition) {
        this.usePosition = usePosition;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getInTime() {
        return inTime;
    }

    public void setInTime(String inTime) {
        this.inTime = inTime;
    }

    public String getAssetsName() {
        return assetsName;
    }

    public void setAssetsName(String assetsName) {
        this.assetsName = assetsName;
    }




    public String getUseTimeShow() {
        return useTimeShow;
    }

    public void setUseTimeShow(String useTimeShow) {
        this.useTimeShow = useTimeShow;
    }

    public String getScrapReson() {
        return scrapReson;
    }

    public void setScrapReson(String scrapReson) {
        this.scrapReson = scrapReson;
    }
}
