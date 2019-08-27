package com.goisan.educational.courseplan.bean;


import com.goisan.system.bean.BaseBean;

public class CoursePlanDetail extends BaseBean {

    private String id;
    private String planId;
    private String courseId;
    private String courseType;
    private String courseName;
    private String textbookId;
    private String textbookName;//TEXTBOOK_NAME
    private String theoreticalHours;
    private String practiceHours;
    private String totalHours;
    private String examType;
    private String theoryPracticeHours;
    private String practicePlace;

    public String getPracticePlace() {
        return practicePlace;
    }

    public void setPracticePlace(String practicePlace) {
        this.practicePlace = practicePlace;
    }


    public String getTheoryPracticeHours() {
        return theoryPracticeHours;
    }

    public void setTheoryPracticeHours(String theoryPracticeHours) {
        this.theoryPracticeHours = theoryPracticeHours;
    }

    private String credit;


    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }


    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }


    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }


    public String getTextbookId() {
        return textbookId;
    }

    public void setTextbookId(String textbookId) {
        this.textbookId = textbookId;
    }


    public String getTextbookName() {
        return textbookName;
    }

    public void setTextbookName(String textbookName) {
        this.textbookName = textbookName;
    }


    public String getTheoreticalHours() {
        return theoreticalHours;
    }

    public void setTheoreticalHours(String theoreticalHours) {
        this.theoreticalHours = theoreticalHours;
    }


    public String getPracticeHours() {
        return practiceHours;
    }

    public void setPracticeHours(String practiceHours) {
        this.practiceHours = practiceHours;
    }


    public String getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(String totalHours) {
        this.totalHours = totalHours;
    }


    public String getExamType() {
        return examType;
    }

    public void setExamType(String examType) {
        this.examType = examType;
    }


    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }


}
