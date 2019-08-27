package com.goisan.educational.arrayclass.bean;

import com.goisan.system.bean.BaseBean;

public class ArrayClassTime extends BaseBean {
    private String Id;
    private String arrayClassId;
    private String hoursType;
    private String hoursName;
    private String hoursCode;
    private String startTime;
    private String endTime;

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getArrayClassId() {
        return arrayClassId;
    }

    public void setArrayClassId(String arrayClassId) {
        this.arrayClassId = arrayClassId;
    }

    public String getHoursType() {
        return hoursType;
    }

    public void setHoursType(String hoursType) {
        this.hoursType = hoursType;
    }

    public String getHoursName() {
        return hoursName;
    }

    public void setHoursName(String hoursName) {
        this.hoursName = hoursName;
    }

    public String getHoursCode() {
        return hoursCode;
    }

    public void setHoursCode(String hoursCode) {
        this.hoursCode = hoursCode;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
}
