package com.goisan.educational.place.dorm.bean;

import com.goisan.system.bean.BaseBean;

/**寝室场地维护
 * Created by wq on 2017/7/15.
 */
public class Dorm extends BaseBean {
    private String id;
    private String dormName;
    private String buildingId;
    private String peopleNumber;
    private String floor;
    private String useStatus;
    private String remark;
    private String dormType;
    private String dormTypeShow;
    private String nowNumber;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDormName() {
        return dormName;
    }

    public void setDormName(String dormName) {
        this.dormName = dormName;
    }

    public String getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(String buildingId) {
        this.buildingId = buildingId;
    }

    public String getPeopleNumber() {
        return peopleNumber;
    }

    public void setPeopleNumber(String peopleNumber) {
        this.peopleNumber = peopleNumber;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public String getUseStatus() {
        return useStatus;
    }

    public void setUseStatus(String useStatus) {
        this.useStatus = useStatus;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDormType() {
        return dormType;
    }

    public void setDormType(String dormType) {
        this.dormType = dormType;
    }

    public String getDormTypeShow() {
        return dormTypeShow;
    }

    public void setDormTypeShow(String dormTypeShow) {
        this.dormTypeShow = dormTypeShow;
    }

    public String getNowNumber() {
        return nowNumber;
    }

    public void setNowNumber(String nowNumber) {
        this.nowNumber = nowNumber;
    }
}
