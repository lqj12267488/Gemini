package com.goisan.educational.teachingplan.bean;

import com.goisan.system.bean.BaseBean;

public class TeachingPlanDetail extends BaseBean {
    private String id;
    private String planId;
    private String planName;
    private String week;
    private String content;
    private String theoreticalHours;
    private String practiceHours;
    private String totalHours;
    private String practicePlace;
    private String focus;
    private String difficulty;
    private String homework;
    private String theoryPracticeHours;

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

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
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

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }
}
