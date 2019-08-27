package com.goisan.educational.course.bean;

import com.goisan.system.bean.BaseBean;

public class Teacherhonor extends BaseBean {

    private String id;
    private String departmentsId;
    private String sex;
    private String honorName;
    private String ownTime;
    private String honorLevel;
    private String teacherId;
    private String teacherIdShow;
    private String sexShow;
    private String departmentsIdShow;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getHonorName() {
        return honorName;
    }

    public void setHonorName(String honorName) {
        this.honorName = honorName;
    }

    public String getOwnTime() {
        return ownTime;
    }

    public void setOwnTime(String ownTime) {
        this.ownTime = ownTime;
    }

    public String getHonorLevel() {
        return honorLevel;
    }

    public void setHonorLevel(String honorLevel) {
        this.honorLevel = honorLevel;
    }

    public String getTeacherIdShow() {
        return teacherIdShow;
    }

    public void setTeacherIdShow(String teacherIdShow) {
        this.teacherIdShow = teacherIdShow;
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }


    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }
}
