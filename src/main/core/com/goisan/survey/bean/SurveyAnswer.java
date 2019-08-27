package com.goisan.survey.bean;

import com.goisan.system.bean.BaseBean;

public class SurveyAnswer extends BaseBean {
    private String answerId;
    private String questionId;
    private String surveyId;
    private String personId;
    private String personDept;
    private String answerType;
    private String answerResult;
    private String checkNum;
    private String sumNum;
    private String percentage;

    public String getAnswerId() {
        return answerId;
    }

    public void setAnswerId(String answerId) {
        this.answerId = answerId;
    }
    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
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
    public String getAnswerType() {
        return answerType;
    }

    public void setAnswerType(String answerType) {
        this.answerType = answerType;
    }
    public String getAnswerResult() {
        return answerResult;
    }

    public void setAnswerResult(String answerResult) {
        this.answerResult = answerResult;
    }

    public String getCheckNum() {
        return checkNum;
    }

    public void setCheckNum(String checkNum) {
        this.checkNum = checkNum;
    }

    public String getSumNum() {
        return sumNum;
    }

    public void setSumNum(String sumNum) {
        this.sumNum = sumNum;
    }

    public String getPercentage() {
        return percentage;
    }

    public void setPercentage(String percentage) {
        this.percentage = percentage;
    }
}
