package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class QualificationTrain extends BaseBean {

    /***/
    private String id;

    /**学生id*/
    private String studentId;

    /**资格证书id*/
    private String qualificationId;

    /**社会培训天数*/
    private String trainDay;

    private String studentIdShow;
    private String qualificationName;
    private String qualificationLevel;
    private String qualificationLevelShow;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getQualificationId() {
        return qualificationId;
    }

    public void setQualificationId(String qualificationId) {
        this.qualificationId = qualificationId;
    }

    public String getTrainDay() {
        return trainDay;
    }

    public void setTrainDay(String trainDay) {
        this.trainDay = trainDay;
    }

    public String getStudentIdShow() {
        return studentIdShow;
    }

    public void setStudentIdShow(String studentIdShow) {
        this.studentIdShow = studentIdShow;
    }

    public String getQualificationName() {
        return qualificationName;
    }

    public void setQualificationName(String qualificationName) {
        this.qualificationName = qualificationName;
    }

    public String getQualificationLevel() {
        return qualificationLevel;
    }

    public void setQualificationLevel(String qualificationLevel) {
        this.qualificationLevel = qualificationLevel;
    }

    public String getQualificationLevelShow() {
        return qualificationLevelShow;
    }

    public void setQualificationLevelShow(String qualificationLevelShow) {
        this.qualificationLevelShow = qualificationLevelShow;
    }
}
