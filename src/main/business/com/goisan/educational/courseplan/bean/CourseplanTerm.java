package com.goisan.educational.courseplan.bean;


import com.goisan.system.bean.BaseBean;

public class CourseplanTerm extends BaseBean {

    private String id;
    private String planId;
    private String detailsId;
    private String courseId;
    private String courseName;
    private String schoolYear;
    private String term;
    private String weekType;
    private String startWeek;
    private String endWeek;
    private String weeksNumber;
    private String weeksHours;
    private String totleHours;
    private String termShow;
    private String signId;
    private String personId;
    private String theoreticalHours;//理论学时
    private String practiceHours;//实践学时
    private String theorypracticeHours;//理实学时

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

    public String getTheorypracticeHours() {
        return theorypracticeHours;
    }

    public void setTheorypracticeHours(String theorypracticeHours) {
        this.theorypracticeHours = theorypracticeHours;
    }

    public String getWeekType() {
        return weekType;
    }

    public void setWeekType(String weekType) {
        this.weekType = weekType;
    }

    public String getStartWeek() {
        return startWeek;
    }

    public void setStartWeek(String startWeek) {
        this.startWeek = startWeek;
    }

    public String getEndWeek() {
        return endWeek;
    }

    public void setEndWeek(String endWeek) {
        this.endWeek = endWeek;
    }

    public String getWeeksNumber() {
        return weeksNumber;
    }

    public void setWeeksNumber(String weeksNumber) {
        this.weeksNumber = weeksNumber;
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

    public String getDetailsId() {
        return detailsId;
    }

    public void setDetailsId(String detailsId) {
        this.detailsId = detailsId;
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

    public String getSchoolYear() {
        return schoolYear;
    }

    public void setSchoolYear(String schoolYear) {
        this.schoolYear = schoolYear;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getWeeksHours() {
        return weeksHours;
    }

    public void setWeeksHours(String weeksHours) {
        this.weeksHours = weeksHours;
    }

    public String getTotleHours() {
        return totleHours;
    }

    public void setTotleHours(String totleHours) {
        this.totleHours = totleHours;
    }

    public String getTermShow() {
        return termShow;
    }

    public void setTermShow(String termShow) {
        this.termShow = termShow;
    }

    public String getSignId() {
        return signId;
    }

    public void setSignId(String signId) {
        this.signId = signId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }
}
