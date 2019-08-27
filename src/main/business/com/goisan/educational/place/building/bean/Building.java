package com.goisan.educational.place.building.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/7/13.
 */

public class Building extends BaseBean {
    private String  id;
    private String  buildingName;//楼宇名称
    private String  buildingType;//楼宇类型，使用LYLX字典
    private String  area;//楼宇面积（㎡）
    private String  floorNumber;//楼层数
    private String  roomNumber;//房间数
    private String  address;//地址
    private String  remark;//备注
    private String  buildingTypeShow;
    private String  dicName;//字典名称
    private String  dicCode;//字典英文缩写

    public String getDicName() {
        return dicName;
    }

    public void setDicName(String dicName) {
        this.dicName = dicName;
    }

    public String getDicCode() {
        return dicCode;
    }

    public void setDicCode(String dicCode) {
        this.dicCode = dicCode;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public String getBuildingType() {
        return buildingType;
    }

    public void setBuildingType(String buildingType) {
        this.buildingType = buildingType;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getFloorNumber() {
        return floorNumber;
    }

    public void setFloorNumber(String floorNumber) {
        this.floorNumber = floorNumber;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getBuildingTypeShow() {
        return buildingTypeShow;
    }

    public void setBuildingTypeShow(String buildingTypeShow) {
        this.buildingTypeShow = buildingTypeShow;
    }
}
