package com.goisan.educational.timetable.bean;

import com.goisan.educational.timetable.util.TimeTableSpecialPlaceConstants;
import com.goisan.system.bean.BaseBean;

public class TimeTableSpecialPlace  extends BaseBean {
    private String id;
    private String specialFlag; //画线标识
    private String specialPlace; //特殊地点名称

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSpecialFlag() {
        return specialFlag;
    }

    public void setSpecialFlag(String specialFlag) {
        this.specialFlag = specialFlag;
    }

    public String getSpecialPlace() {
        return specialPlace;
    }

    public void setSpecialPlace(String specialPlace) {
        this.specialPlace = specialPlace;
    }
}
