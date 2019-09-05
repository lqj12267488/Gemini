package com.goisan.survey.bean;

import com.goisan.system.bean.BaseBean;

import java.sql.Date;

public class Survey extends BaseBean {
    private String surveyId;
    private String surveyTitle;
    private Date startTime;
    private Date endTime;
    private String checkFlag;
    private String checkFlagShow;
    private String surveyType;
    private String surveyTypeShow;
    private String startFlag;
    private String startFlagShow;
    private String remark;
    private String years;
    private String yearsShow;
    private String classes;
    private String majorCode;
    private String major;
    private String dept;
    private String departmentsId;
    private String numberNotSurvey;//未做调查人数
    private String numberSurvey;//已做调查人数
    private String personDept;
    private String studentName;
    private String studentNumber;
    private String studentIdcard;
    private String completion;
    public String getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(String surveyId) {
        this.surveyId = surveyId;
    }

    public String getSurveyTitle() {
        return surveyTitle;
    }

    public void setSurveyTitle(String surveyTitle) {
        this.surveyTitle = surveyTitle;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getCheckFlag() {
        return checkFlag;
    }

    public void setCheckFlag(String checkFlag) {
        this.checkFlag = checkFlag;
    }

    public String getCheckFlagShow() {
        return checkFlagShow;
    }

    public void setCheckFlagShow(String checkFlagShow) {
        this.checkFlagShow = checkFlagShow;
    }

    public String getSurveyType() {
        return surveyType;
    }

    public void setSurveyType(String surveyType) {
        this.surveyType = surveyType;
    }

    public String getSurveyTypeShow() {
        return surveyTypeShow;
    }

    public void setSurveyTypeShow(String surveyTypeShow) {
        this.surveyTypeShow = surveyTypeShow;
    }

    public String getStartFlag() {
        return startFlag;
    }

    public void setStartFlag(String startFlag) {
        this.startFlag = startFlag;
    }

    public String getStartFlagShow() {
        return startFlagShow;
    }

    public void setStartFlagShow(String startFlagShow) {
        this.startFlagShow = startFlagShow;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getYears() {
        return years;
    }

    public void setYears(String years) {
        this.years = years;
    }

    public String getYearsShow() {
        return yearsShow;
    }

    public void setYearsShow(String yearsShow) {
        this.yearsShow = yearsShow;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getNumberNotSurvey() {
        return numberNotSurvey;
    }

    public void setNumberNotSurvey(String numberNotSurvey) {
        this.numberNotSurvey = numberNotSurvey;
    }

    public String getNumberSurvey() {
        return numberSurvey;
    }

    public void setNumberSurvey(String numberSurvey) {
        this.numberSurvey = numberSurvey;
    }

    public String getPersonDept() {
        return personDept;
    }

    public void setPersonDept(String personDept) {
        this.personDept = personDept;
    }

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

    public String getStudentIdcard() {
        return studentIdcard;
    }

    public void setStudentIdcard(String studentIdcard) {
        this.studentIdcard = studentIdcard;
    }

    public String getCompletion() {
        return completion;
    }

    public void setCompletion(String completion) {
        this.completion = completion;
    }
}
