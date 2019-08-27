package com.goisan.educational.slowexamination.bean;

import com.goisan.system.bean.BaseBean;

public class SlowExamination extends BaseBean {
    private String id;
    private String requestDept;
    private String requestDate;
    private String manager;
    private String termId;
    private String classId;
    private String courseName;
    private String majorId;
    private String courseId;
    private String reason;
    private String remark;
    private String requestFlag;
    private String feedBack;
    private String feedBackFlag;

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

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getTermId() {
        return termId;
    }

    public void setTermId(String termId) {
        this.termId = termId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public String getFeedBackFlag() {
        return feedBackFlag;
    }

    public void setFeedBackFlag(String feedBackFlag) {
        this.feedBackFlag = feedBackFlag;
    }
}
