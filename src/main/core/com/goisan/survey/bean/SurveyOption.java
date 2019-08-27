package com.goisan.survey.bean;

import com.goisan.system.bean.BaseBean;

public class SurveyOption extends BaseBean {
    private String optionId;
    private String surveyId;
    private String questionId;
    private String optionCode;
    private String optionValue;
    private String optionOrder;

    public String getOptionId() {
        return optionId;
    }

    public void setOptionId(String optionId) {
        this.optionId = optionId;
    }
    public String getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(String surveyId) {
        this.surveyId = surveyId;
    }
    public String getOptionCode() {
        return optionCode;
    }

    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public void setOptionCode(String optionCode) {
        this.optionCode = optionCode;
    }
    public String getOptionValue() {
        return optionValue;
    }

    public void setOptionValue(String optionValue) {
        this.optionValue = optionValue;
    }
    public String getOptionOrder() {
        return optionOrder;
    }

    public void setOptionOrder(String optionOrder) {
        this.optionOrder = optionOrder;
    }
}
