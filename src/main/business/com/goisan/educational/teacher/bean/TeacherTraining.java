package com.goisan.educational.teacher.bean;

import com.goisan.system.bean.BaseBean;

public class TeacherTraining extends BaseBean {
    private String teacherId;
    private String teacherName;
    private String trainingLevel;
    private String trainingContent;
    private String trainingDate;
    private String trainingDay;
    private String trainingPlace;
    private String trainingConclusion;
    private String trainingLevelShow;
    private String teacherNameShow;
    private String personId;

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getTrainingLevelShow() {
        return trainingLevelShow;
    }

    public void setTrainingLevelShow(String trainingLevelShow) {
        this.trainingLevelShow = trainingLevelShow;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getTrainingContent() {
        return trainingContent;
    }

    public void setTrainingContent(String trainingContent) {
        this.trainingContent = trainingContent;
    }

    public String getTrainingDate() {
        return trainingDate;
    }

    public void setTrainingDate(String trainingDate) {
        this.trainingDate = trainingDate;
    }

    public String getTrainingDay() {
        return trainingDay;
    }

    public void setTrainingDay(String trainingDay) {
        this.trainingDay = trainingDay;
    }

    public String getTrainingPlace() {
        return trainingPlace;
    }

    public void setTrainingPlace(String trainingPlace) {
        this.trainingPlace = trainingPlace;
    }

    public String getTrainingConclusion() {
        return trainingConclusion;
    }

    public void setTrainingConclusion(String trainingConclusion) {
        this.trainingConclusion = trainingConclusion;
    }

    public String getTeacherNameShow() {
        return teacherNameShow;
    }

    public void setTeacherNameShow(String teacherNameShow) {
        this.teacherNameShow = teacherNameShow;
    }
}
