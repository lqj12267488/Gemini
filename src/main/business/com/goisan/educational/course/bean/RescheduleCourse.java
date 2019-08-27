package com.goisan.educational.course.bean;

import com.goisan.system.bean.BaseBean;

import java.util.Date;

public class RescheduleCourse extends BaseBean {
    private String id;
    private String majorSchool;
    private String majorSchoolShow;
    private String deptId;
    private String majorCode;
    private String classId;
    private String courseId;
    private String oringalDate;
    private String oringalWeekday;//原定上课星期
    private String oringalClassTime; //原定上课节次
    private String oringalWeek; //原定上课周次
    private String oringalTeacher; //原定上课老师
    private String  rescheduleDate;
    private String rescheduleWeekday; //调课星期
    private String rescheduleClassTime; //调课节次
    private String rescheduleTeacher; //调课老师
    private String rescheduleWeek; //调课周次
    private String applicantPersonId; //申请人id;
    private String applicantDate;
    private String approveDptPersonId;
    private String approveDptDate;
    private String approveOfficePersonId;
    private String approveOfficeDate;
    private String status;
    private String applicantReason;
    private String approveReason;
    private String requester;
    private String requesterDept;
    private String majorShow;
    private String overruleStatus;

    private String createDept;
    private String tTKSPId;//调停课审批id;

    private Boolean isDeptBoss;

    public Boolean getDeptBoss() {
        return isDeptBoss;
    }

    public void setDeptBoss(Boolean deptBoss) {
        isDeptBoss = deptBoss;
    }

    @Override
    public String getCreateDept() {
        return createDept;
    }

    @Override
    public void setCreateDept(String createDept) {
        this.createDept = createDept;
    }

    public String gettTKSPId() {
        return tTKSPId;
    }

    public void settTKSPId(String tTKSPId) {
        this.tTKSPId = tTKSPId;
    }

    public String getOverruleStatus() {
        return overruleStatus;
    }

    public void setOverruleStatus(String overruleStatus) {
        this.overruleStatus = overruleStatus;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
    }

    public String getRequesterDept() {
        return requesterDept;
    }

    public void setRequesterDept(String requesterDept) {
        this.requesterDept = requesterDept;
    }

    public String getMajorSchoolShow() {
        return majorSchoolShow;
    }

    public void setMajorSchoolShow(String majorSchoolShow) {
        this.majorSchoolShow = majorSchoolShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMajorSchool() {
        return majorSchool;
    }

    public void setMajorSchool(String majorSchool) {
        this.majorSchool = majorSchool;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getOringalDate() {
        return oringalDate;
    }

    public void setOringalDate(String oringalDate) {
        this.oringalDate = oringalDate;
    }

    public String getOringalWeekday() {
        return oringalWeekday;
    }

    public void setOringalWeekday(String oringalWeekday) {
        this.oringalWeekday = oringalWeekday;
    }

    public String getOringalClassTime() {
        return oringalClassTime;
    }

    public void setOringalClassTime(String oringalClassTime) {
        this.oringalClassTime = oringalClassTime;
    }

    public String getOringalWeek() {
        return oringalWeek;
    }

    public void setOringalWeek(String oringalWeek) {
        this.oringalWeek = oringalWeek;
    }

    public String getOringalTeacher() {
        return oringalTeacher;
    }

    public void setOringalTeacher(String oringalTeacher) {
        this.oringalTeacher = oringalTeacher;
    }

    public String getRescheduleDate() {
        return rescheduleDate;
    }

    public void setRescheduleDate(String rescheduleDate) {
        this.rescheduleDate = rescheduleDate;
    }

    public String getRescheduleWeekday() {
        return rescheduleWeekday;
    }

    public void setRescheduleWeekday(String rescheduleWeekday) {
        this.rescheduleWeekday = rescheduleWeekday;
    }

    public String getRescheduleClassTime() {
        return rescheduleClassTime;
    }

    public void setRescheduleClassTime(String rescheduleClassTime) {
        this.rescheduleClassTime = rescheduleClassTime;
    }

    public String getRescheduleTeacher() {
        return rescheduleTeacher;
    }

    public void setRescheduleTeacher(String rescheduleTeacher) {
        this.rescheduleTeacher = rescheduleTeacher;
    }

    public String getRescheduleWeek() {
        return rescheduleWeek;
    }

    public void setRescheduleWeek(String rescheduleWeek) {
        this.rescheduleWeek = rescheduleWeek;
    }

    public String getApplicantPersonId() {
        return applicantPersonId;
    }

    public void setApplicantPersonId(String applicantPersonId) {
        this.applicantPersonId = applicantPersonId;
    }

    public String getApplicantDate() {
        return applicantDate;
    }

    public void setApplicantDate(String applicantDate) {
        this.applicantDate = applicantDate;
    }

    public String getApproveDptPersonId() {
        return approveDptPersonId;
    }

    public void setApproveDptPersonId(String approveDptPersonId) {
        this.approveDptPersonId = approveDptPersonId;
    }

    public String getApproveDptDate() {
        return approveDptDate;
    }

    public void setApproveDptDate(String approveDptDate) {
        this.approveDptDate = approveDptDate;
    }

    public String getApproveOfficePersonId() {
        return approveOfficePersonId;
    }

    public void setApproveOfficePersonId(String approveOfficePersonId) {
        this.approveOfficePersonId = approveOfficePersonId;
    }

    public String getApproveOfficeDate() {
        return approveOfficeDate;
    }

    public void setApproveOfficeDate(String approveOfficeDate) {
        this.approveOfficeDate = approveOfficeDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getApplicantReason() {
        return applicantReason;
    }

    public void setApplicantReason(String applicantReason) {
        this.applicantReason = applicantReason;
    }

    public String getApproveReason() {
        return approveReason;
    }

    public void setApproveReason(String approveReason) {
        this.approveReason = approveReason;
    }
}
