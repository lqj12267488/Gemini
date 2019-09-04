package com.goisan.studentwork.maintenance.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created  By hanjie ON 2019/9/2
 */
public class MtRelation  extends BaseBean {

    private String id;
    private String mtId;
    private String mtName;
    private String relId;
    private String relName;
    private String goodName;
    private String goodUnit;
    private String goodNum;
    private String goodPrice;
    private String goodCase;
    private String goodRemark;
    private String relType;
    private String mtStatus;
    private String unitPrice;
    private String mtFalgShow;
    private String mtFlag;


    public String getMtFalgShow() {
        return mtFalgShow;
    }

    public void setMtFalgShow(String mtFalgShow) {
        this.mtFalgShow = mtFalgShow;
    }

    public String getMtFlag() {
        return mtFlag;
    }

    public void setMtFlag(String mtFlag) {
        this.mtFlag = mtFlag;
    }

    public String getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getMtStatus() {
        return mtStatus;
    }

    public void setMtStatus(String mtStatus) {
        this.mtStatus = mtStatus;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMtId() {
        return mtId;
    }

    public void setMtId(String mtId) {
        this.mtId = mtId;
    }

    public String getMtName() {
        return mtName;
    }

    public void setMtName(String mtName) {
        this.mtName = mtName;
    }

    public String getRelId() {
        return relId;
    }

    public void setRelId(String relId) {
        this.relId = relId;
    }

    public String getRelName() {
        return relName;
    }

    public void setRelName(String relName) {
        this.relName = relName;
    }

    public String getGoodName() {
        return goodName;
    }

    public void setGoodName(String goodName) {
        this.goodName = goodName;
    }

    public String getGoodUnit() {
        return goodUnit;
    }

    public void setGoodUnit(String goodUnit) {
        this.goodUnit = goodUnit;
    }

    public String getGoodNum() {
        return goodNum;
    }

    public void setGoodNum(String goodNum) {
        this.goodNum = goodNum;
    }

    public String getGoodPrice() {
        return goodPrice;
    }

    public void setGoodPrice(String goodPrice) {
        this.goodPrice = goodPrice;
    }

    public String getGoodCase() {
        return goodCase;
    }

    public void setGoodCase(String goodCase) {
        this.goodCase = goodCase;
    }

    public String getGoodRemark() {
        return goodRemark;
    }

    public void setGoodRemark(String goodRemark) {
        this.goodRemark = goodRemark;
    }

    public String getRelType() {
        return relType;
    }

    public void setRelType(String relType) {
        this.relType = relType;
    }
}
