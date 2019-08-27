package com.goisan.studentwork.studentleave.bean;

import com.goisan.system.bean.BaseBean;

public class StudentLeave extends BaseBean {

    private String id;
    private String requestDept;//申请部门
    private String requester;//申请人
    private String requestDate;//申请日期
    private String startTime;//请假开始时间
    private String endTime;//请假结束时间
    private String requestDays;//申请天数
    private String leaveType;//JT类型，使用JTLX字典
    private String leaveTypeShow;
    private String reason;//请假原因
    private String requestFlag;//请求状态
    private String feedBack;//反馈意见
    private String feedbackFlag;//反馈状态
    private String deptId;
    private String level;
    private String studentNumber; //学籍号
    private String departmentsId;   //系部id
    private String majorCode;       //专业代码
    private String classId;         //班级Id
    private String studentId;       //学生Id
    private String  sex;            //性别
    private String studentName; //学生姓名

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    @Override
    public String getLevel() {
        return level;
    }

    @Override
    public void setLevel(String level) {
        this.level = level;
    }

    public String getLeaveTypeShow() {
        return leaveTypeShow;
    }

    public void setLeaveTypeShow(String leaveTypeShow) {
        this.leaveTypeShow = leaveTypeShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
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

    public String getRequestDays() {
        return requestDays;
    }

    public void setRequestDays(String requestDays) {
        this.requestDays = requestDays;
    }

    public String getLeaveType() {return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getFeedBack() {
        return feedBack;
    }

    public void setFeedBack(String feedBack) {
        this.feedBack = feedBack;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }

}
