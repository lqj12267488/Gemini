package com.goisan.educational.course.bean;

import com.goisan.system.bean.BaseBean;

public class Coursehonor extends BaseBean{
    private String id; //id
    private String courseHonorId;//课程荣誉id
    private String courseName;//课程名称
    private String honorName;//荣誉名称
    private String honorMemberShow;
    private String honorLevel;//等级
    private String chargeMan;//负责人
    private String honorMember;//成员
    private String ownTime;//获得时间
    private String validTime;//有效期
    private String personIdShow;

    public String getHonorMemberShow() {
        return honorMemberShow;
    }

    public void setHonorMemberShow(String honorMemberShow) {
        this.honorMemberShow = honorMemberShow;
    }

    public String getCourseHonorId() {
        return courseHonorId;
    }

    public void setCourseHonorId(String courseHonorId) {
        this.courseHonorId = courseHonorId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getHonorName() {
        return honorName;
    }

    public void setHonorName(String honorName) {
        this.honorName = honorName;
    }

    public String getHonorLevel() {
        return honorLevel;
    }

    public void setHonorLevel(String honorLevel) {
        this.honorLevel = honorLevel;
    }

    public String getChargeMan() {
        return chargeMan;
    }

    public void setChargeMan(String chargeMan) {
        this.chargeMan = chargeMan;
    }

    public String getHonorMember() {
        return honorMember;
    }

    public void setHonorMember(String honorMember) {
        this.honorMember = honorMember;
    }

    public String getOwnTime() {
        return ownTime;
    }

    public void setOwnTime(String ownTime) {
        this.ownTime = ownTime;
    }

    public String getValidTime() {
        return validTime;
    }

    public void setValidTime(String validTime) {
        this.validTime = validTime;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
