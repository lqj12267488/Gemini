package com.goisan.educational.teachingplan.bean;


import com.goisan.system.bean.BaseBean;

import java.sql.Date;

public class TeachingPlan extends BaseBean {

    private String id;
    private String planName;
    private String departmentsId;
    private String departmentsIdShow;
    private String majorCode;
    private String majorDirection;
    private String trainingLevel;
    private String courseId;
    private String courseIdShow;
    private String textbookId;
    private String textbookIdShow;
    private String year;
    private String classId;
    private String className;
    private String term;
    private java.sql.Date startTime;
    private java.sql.Date endTime;
    private String totalWeeks;
    private String totalHours;
    private String theoreticalWeeks;
    private String theoreticalHours;
    private String totalTheoreticalHours;
    private String practiceWeeks;
    private String practiceHours;
    private String totalPracticeHours;
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String courseType;
    private String week;
    private String content;
    private String practicePlace;
    private String focus;
    private String difficulty;
    private String homework;
    private String theoryPracticeHours;
    private String fileState;

    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getCourseIdShow() {
        return courseIdShow;
    }

    public void setCourseIdShow(String courseIdShow) {
        this.courseIdShow = courseIdShow;
    }

    public String getTextbookIdShow() {
        return textbookIdShow;
    }

    public void setTextbookIdShow(String textbookIdShow) {
        this.textbookIdShow = textbookIdShow;
    }

    public String getTheoryPracticeHours() {
        return theoryPracticeHours;
    }

    public void setTheoryPracticeHours(String theoryPracticeHours) {
        this.theoryPracticeHours = theoryPracticeHours;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
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

    public String getMajorDirection() {
        return majorDirection;
    }

    public void setMajorDirection(String majorDirection) {
        this.majorDirection = majorDirection;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getTextbookId() {
        return textbookId;
    }

    public void setTextbookId(String textbookId) {
        this.textbookId = textbookId;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
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

    public String getTotalWeeks() {
        return totalWeeks;
    }

    public void setTotalWeeks(String totalWeeks) {
        this.totalWeeks = totalWeeks;
    }

    public String getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(String totalHours) {
        this.totalHours = totalHours;
    }

    public String getTheoreticalWeeks() {
        return theoreticalWeeks;
    }
    public void setTheoreticalWeeks(String theoreticalWeeks) {
        this.theoreticalWeeks = theoreticalWeeks;
    }

    public String getTheoreticalHours() {
        return theoreticalHours;
    }

    public void setTheoreticalHours(String theoreticalHours) {
        this.theoreticalHours = theoreticalHours;
    }

    public String getTotalTheoreticalHours() {
        return totalTheoreticalHours;
    }

    public void setTotalTheoreticalHours(String totalTheoreticalHours) {
        this.totalTheoreticalHours = totalTheoreticalHours;
    }

    public String getPracticeWeeks() {
        return practiceWeeks;
    }

    public void setPracticeWeeks(String practiceWeeks) {
        this.practiceWeeks = practiceWeeks;
    }

    public String getPracticeHours() {
        return practiceHours;
    }

    public void setPracticeHours(String practiceHours) {
        this.practiceHours = practiceHours;
    }

    public String getTotalPracticeHours() {
        return totalPracticeHours;
    }

    public void setTotalPracticeHours(String totalPracticeHours) {
        this.totalPracticeHours = totalPracticeHours;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPracticePlace() {
        return practicePlace;
    }

    public void setPracticePlace(String practicePlace) {
        this.practicePlace = practicePlace;
    }

    public String getFocus() {
        return focus;
    }

    public void setFocus(String focus) {
        this.focus = focus;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public String getHomework() {
        return homework;
    }

    public void setHomework(String homework) {
        this.homework = homework;
    }

}
