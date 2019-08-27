package com.goisan.studentwork.internships.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/8/3.
 */
public class InternshipChangeLog extends BaseBean{
    private String logId;//变动日志id
    private String internshipId;//实习id
    private String studentId;//学生id
    private String classId;//班级id
    private String oldInternshipUnitId;//原实习单位id
    private String newInternshipUnitId;//新实习单位id
    private String reason;//变动原因
    private String alertTime;//变动时间
    private String internshipIdShow;
    private String studentIdShow;
    private String classIdShow;
    private String oldInternshipUnitIdShow;
    private String newInternshipUnitIdShow;
    private Integer internshipChangeFlagFlag;

    public Integer getInternshipChangeFlagFlag() {
        return internshipChangeFlagFlag;
    }

    public void setInternshipChangeFlagFlag(Integer internshipChangeFlagFlag) {
        this.internshipChangeFlagFlag = internshipChangeFlagFlag;
    }

    public String getAlertTime() {
        return alertTime;
    }

    public void setAlertTime(String alertTime) {
        this.alertTime = alertTime;
    }
    public String getInternshipIdShow() {
        return internshipIdShow;
    }

    public void setInternshipIdShow(String internshipIdShow) {
        this.internshipIdShow = internshipIdShow;
    }

    public String getInternshipId() {
        return internshipId;
    }

    public void setInternshipId(String internshipId) {
        this.internshipId = internshipId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getStudentIdShow() {
        return studentIdShow;
    }

    public void setStudentIdShow(String studentIdShow) {
        this.studentIdShow = studentIdShow;
    }

    public String getClassIdShow() {
        return classIdShow;
    }

    public void setClassIdShow(String classIdShow) {
        this.classIdShow = classIdShow;
    }

    public String getOldInternshipUnitIdShow() {
        return oldInternshipUnitIdShow;
    }

    public void setOldInternshipUnitIdShow(String oldInternshipUnitIdShow) {
        this.oldInternshipUnitIdShow = oldInternshipUnitIdShow;
    }

    public String getNewInternshipUnitIdShow() {
        return newInternshipUnitIdShow;
    }

    public void setNewInternshipUnitIdShow(String newInternshipUnitIdShow) {
        this.newInternshipUnitIdShow = newInternshipUnitIdShow;
    }

    public String getLogId() {
        return logId;
    }

    public void setLogId(String logId) {
        this.logId = logId;
    }



    public String getOldInternshipUnitId() {
        return oldInternshipUnitId;
    }

    public void setOldInternshipUnitId(String oldInternshipUnitId) {
        this.oldInternshipUnitId = oldInternshipUnitId;
    }

    public String getNewInternshipUnitId() {
        return newInternshipUnitId;
    }

    public void setNewInternshipUnitId(String newInternshipUnitId) {
        this.newInternshipUnitId = newInternshipUnitId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
