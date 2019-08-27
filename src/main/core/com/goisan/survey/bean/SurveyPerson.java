package com.goisan.survey.bean;

import com.goisan.system.bean.BaseBean;

public class SurveyPerson extends BaseBean {
    private String id;
    private String surveyId;
    private String personId;
    private String personDept;
    private String personType;
    private String answerFlag;
    private String remark;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(String surveyId) {
        this.surveyId = surveyId;
    }
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }
    public String getPersonDept() {
        return personDept;
    }

    public void setPersonDept(String personDept) {
        this.personDept = personDept;
    }
    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
    }
    public String getAnswerFlag() {
        return answerFlag;
    }

    public void setAnswerFlag(String answerFlag) {
        this.answerFlag = answerFlag;
    }
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
