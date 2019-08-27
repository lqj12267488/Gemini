package com.goisan.logistics.dormmanage.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/9/25.
 */
public class StudentPlanJob extends BaseBean {
    private String studentOrderId;
    private String officeStartTime;
    private String officeEndTime;
    private String buildingId;
    private String studentId;
    private String buildingName;
    private String studentName;
    private String tel;

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getStudentOrderId() {
        return studentOrderId;
    }

    public void setStudentOrderId(String studentOrderId) {
        this.studentOrderId = studentOrderId;
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

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
}
