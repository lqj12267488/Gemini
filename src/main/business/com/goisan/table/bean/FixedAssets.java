package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class FixedAssets extends BaseBean {

    /**主键id*/
    private String id;

    /**全校总值*/
    private String totalSchoolValue;

    /**资产总值*/
    private String totalAssets;

    /**当年新增资产值*/
    private String assetsAdd;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTotalSchoolValue() {
        return totalSchoolValue;
    }

    public void setTotalSchoolValue(String totalSchoolValue) {
        this.totalSchoolValue = totalSchoolValue;
    }

    public String getTotalAssets() {
        return totalAssets;
    }

    public void setTotalAssets(String totalAssets) {
        this.totalAssets = totalAssets;
    }

    public String getAssetsAdd() {
        return assetsAdd;
    }

    public void setAssetsAdd(String assetsAdd) {
        this.assetsAdd = assetsAdd;
    }

}
