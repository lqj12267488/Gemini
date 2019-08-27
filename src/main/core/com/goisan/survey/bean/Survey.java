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
}
