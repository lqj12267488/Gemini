package com.goisan.educational.place.meetingRoom.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/7/14.
 */
public class MeetingRoom extends BaseBean {
    private String id;
    private String meetingRoomName;//会议室名称
    private String buildingId;//楼宇ID
    private String buildingIdShow;
    private String peopleNumber;//容纳人数
    private String roomNumber;//房间号
    private String floor;//所在楼层，使用LC字典
    private String useStatus;//使用状态，使用SYZT字典
    private String remark;//备注

    public String getBuildingIdShow() {
        return buildingIdShow;
    }

    public void setBuildingIdShow(String buildingIdShow) {
        this.buildingIdShow = buildingIdShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMeetingRoomName() {
        return meetingRoomName;
    }

    public void setMeetingRoomName(String meetingRoomName) {
        this.meetingRoomName = meetingRoomName;
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

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
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
}
