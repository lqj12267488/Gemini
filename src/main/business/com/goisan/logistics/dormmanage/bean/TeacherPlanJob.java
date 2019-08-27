package com.goisan.logistics.dormmanage.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/9/25.
 */
public class TeacherPlanJob extends BaseBean {

   private String teacherOrderId;
   private String officeStartTime;
   private String officeEndTime;
    private String buildingId;
    private String buildingName;
    private String teacherName;
    private String tel;
    private String idcard;
    private String sex;
    private String teacherDept;
    private String teacherId;
    private String remark;

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherDept() {
        return teacherDept;
    }

    public void setTeacherDept(String teacherDept) {
        this.teacherDept = teacherDept;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTeacherOrderId() {
        return teacherOrderId;
    }

    public void setTeacherOrderId(String teacherOrderId) {
        this.teacherOrderId = teacherOrderId;
    }

    public String getOfficeStartTime() {
        return officeStartTime;
    }

    public void setOfficeStartTime(String officeStartTime) {
        this.officeStartTime = officeStartTime;
    }

    public String getOfficeEndTime() {
        return officeEndTime;
    }

    public void setOfficeEndTime(String officeEndTime) {
        this.officeEndTime = officeEndTime;
    }

    public String getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(String buildingId) {
        this.buildingId = buildingId;
    }

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }
}
