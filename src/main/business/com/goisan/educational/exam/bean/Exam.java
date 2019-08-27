package com.goisan.educational.exam.bean;

import com.goisan.system.bean.BaseBean;

public class Exam extends BaseBean {
    private String examId;
    private String examName;
    private String term;
    private String startTime;
    private String endTime;
    private String termShow;
    private String examFlag;
    private String studentId;
    private String deptId;
    private String examTypes;
    private String openFlag;
    private String normalScoreStartTime;
    private String normalScoreEndTime;
    private String status;
    private String classId;
    private String courseId;
    private String scoreSelect;

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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    private String scoreStartTime;
    private String scoreEndTime;

    public String getNormalScoreStartTime() {
        return normalScoreStartTime;
    }

    public void setNormalScoreStartTime(String normalScoreStartTime) {
        this.normalScoreStartTime = normalScoreStartTime;
    }

    public String getNormalScoreEndTime() {
        return normalScoreEndTime;
    }

    public void setNormalScoreEndTime(String normalScoreEndTime) {
        this.normalScoreEndTime = normalScoreEndTime;
    }

    public String getScoreStartTime() {
        return scoreStartTime;
    }

    public void setScoreStartTime(String scoreStartTime) {
        this.scoreStartTime = scoreStartTime;
    }

    public String getScoreEndTime() {
        return scoreEndTime;
    }

    public void setScoreEndTime(String scoreEndTime) {
        this.scoreEndTime = scoreEndTime;
    }

    public String getOpenFlag() {
        return openFlag;
    }

    public void setOpenFlag(String openFlag) {
        this.openFlag = openFlag;
    }

    public String getExamId() {
        return examId;
    }

    public void setExamId(String examId) {
        this.examId = examId;
    }

    public String getExamName() {
        return examName;
    }

    public void setExamName(String examName) {
        this.examName = examName;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
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

    public String getTermShow() {
        return termShow;
    }

    public void setTermShow(String termShow) {
        this.termShow = termShow;
    }

    public String getExamFlag() {
        return examFlag;
    }

    public void setExamFlag(String examFlag) {
        this.examFlag = examFlag;
    }


    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getExamTypes() {
        return examTypes;
    }

    public void setExamTypes(String examTypes) {
        this.examTypes = examTypes;
    }

    public String getScoreSelect() {
        return scoreSelect;
    }

    public void setScoreSelect(String scoreSelect) {
        this.scoreSelect = scoreSelect;
    }
}
