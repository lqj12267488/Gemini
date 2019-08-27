package com.goisan.educational.score.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by wq on 2017/10/12.
 */
public class ScoreCourse extends BaseBean {
    private String subjectId;
    private String scoreExamId;
    private String scoreExamName;
    private String planId;
    private String departmentsId;
    private String majorCode;
    private String majorShow;
    private String majorDirection;
    private String trainingLevel;
    private String courseType;
    private String courseId;
    private String courseShow;
    private String totalScore;
    private String passScore;
    private String courseFlag;

    public String getCourseFlag() {
        return courseFlag;
    }

    public void setCourseFlag(String courseFlag) {
        this.courseFlag = courseFlag;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public String getScoreExamId() {
        return scoreExamId;
    }

    public void setScoreExamId(String scoreExamId) {
        this.scoreExamId = scoreExamId;
    }

    public String getScoreExamName() {
        return scoreExamName;
    }

    public void setScoreExamName(String scoreExamName) {
        this.scoreExamName = scoreExamName;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
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

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
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

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseShow() {
        return courseShow;
    }

    public void setCourseShow(String courseShow) {
        this.courseShow = courseShow;
    }

    public String getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(String totalScore) {
        this.totalScore = totalScore;
    }

    public String getPassScore() {
        return passScore;
    }

    public void setPassScore(String passScore) {
        this.passScore = passScore;
    }
}
