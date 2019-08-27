package com.goisan.educational.arrayclass.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by wq on 2017/8/10.
 */
public class ArrayClassRoom extends BaseBean {
    private String id;
    private String arrayClassId;
    private String roomType;
    private String roomId;
    private String roomName;
    private String peopleNumber;
    private String classId;
    private String departmentsId;
    private String majorCode;
    private String trainingLevel;
    private String roomIdShow;

    public String getRoomIdShow() {
        return roomIdShow;
    }

    public void setRoomIdShow(String roomIdShow) {
        this.roomIdShow = roomIdShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getArrayClassId() {
        return arrayClassId;
    }

    public void setArrayClassId(String arrayClassId) {
        this.arrayClassId = arrayClassId;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getPeopleNumber() {
        return peopleNumber;
    }

    public void setPeopleNumber(String peopleNumber) {
        this.peopleNumber = peopleNumber;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }
}
