package com.goisan.logistics.repair.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/5/24.
 */
public class RepairSupplies extends BaseBean {
    private String id;
    private String suppliesname;//耗材名称
    private String suppliestype;//耗材类型，使用WXHCLX字典
    private String suppliesnum;//耗材数量
    private String suppliesInnum;
    private String unit;//计量单位
    private String price;//单价
    private String specifications;//规格
    private String brand;//品牌
    private String remark;//备注
    private String intime;//入库时间
    private String suppliestypeShow;
    private String suppliesnameShow;
    private String status;//状态
    private String repairID;
    private String suppliesid;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getSuppliestypeShow() {
        return suppliestypeShow;
    }

    public void setSuppliestypeShow(String suppliestypeShow) {
        this.suppliestypeShow = suppliestypeShow;
    }

    public String getSuppliesname() {
        return suppliesname;
    }

    public void setSuppliesname(String suppliesname) {
        this.suppliesname = suppliesname;
    }

    public String getSuppliestype() {
        return suppliestype;
    }

    public void setSuppliestype(String suppliestype) {
        this.suppliestype = suppliestype;
    }

    public String getSuppliesnum() {
        return suppliesnum;
    }

    public void setSuppliesnum(String suppliesnum) {
        this.suppliesnum = suppliesnum;
    }

    public String getIntime() {
        return intime;
    }

    public void setIntime(String intime) {
        this.intime = intime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSuppliesInnum() {
        return suppliesInnum;
    }

    public void setSuppliesInnum(String suppliesInnum) {
        this.suppliesInnum = suppliesInnum;
    }

    public String getRepairID() {
        return repairID;
    }

    public void setRepairID(String repairID) {
        this.repairID = repairID;
    }

    public String getSuppliesid() {
        return suppliesid;
    }

    public void setSuppliesid(String suppliesid) {
        this.suppliesid = suppliesid;
    }

    public String getSuppliesnameShow() {
        return suppliesnameShow;
    }

    public void setSuppliesnameShow(String suppliesnameShow) {
        this.suppliesnameShow = suppliesnameShow;
    }
}
