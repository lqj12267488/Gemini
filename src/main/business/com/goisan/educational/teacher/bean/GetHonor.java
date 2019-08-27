package com.goisan.educational.teacher.bean;

import com.goisan.system.bean.BaseBean;

public class GetHonor extends BaseBean {
    private String teacherId;
    private String teacherName;
    private String honorName;
    private String getTime;
    private String honorLevel;
    private String honorLevelShow;
    private String teacherNameShow;
    private String personId;

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getHonorLevelShow() {
        return honorLevelShow;
    }

    public void setHonorLevelShow(String honorLevelShow) {
        this.honorLevelShow = honorLevelShow;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getHonorName() {
        return honorName;
    }

    public void setHonorName(String honorName) {
        this.honorName = honorName;
    }

    public String getGetTime() {
        return getTime;
    }

    public void setGetTime(String getTime) {
        this.getTime = getTime;
    }

    public String getHonorLevel() {
        return honorLevel;
    }

    public void setHonorLevel(String honorLevel) {
        this.honorLevel = honorLevel;
    }

    public String getTeacherNameShow() {
        return teacherNameShow;
    }

    public void setTeacherNameShow(String teacherNameShow) {
        this.teacherNameShow = teacherNameShow;
    }
}
