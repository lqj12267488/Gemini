package com.goisan.survey.bean;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public class SurveyQuestion extends BaseBean {
    private String questionId;
    private String surveyId;
    private String parentQuestionId;
    private String questionName;
    private String questionType;
    private String questionTypeShow;
    private String questionOrder;
    private String remark;
    private List<SurveyOption> optionList;
    private List result;

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
    public String getParentQuestionId() {
        return parentQuestionId;
    }

    public void setParentQuestionId(String parentQuestionId) {
        this.parentQuestionId = parentQuestionId;
    }
    public String getQuestionName() {
        return questionName;
    }

    public void setQuestionName(String questionName) {
        this.questionName = questionName;
    }
    public String getQuestionType() {
        return questionType;
    }

    public String getQuestionTypeShow() {
        return questionTypeShow;
    }

    public void setQuestionTypeShow(String questionTypeShow) {
        this.questionTypeShow = questionTypeShow;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

    public String getQuestionOrder() {
        return questionOrder;
    }

    public void setQuestionOrder(String questionOrder) {
        this.questionOrder = questionOrder;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<SurveyOption> getOptionList() {
        return optionList;
    }

    public void setOptionList(List<SurveyOption> optionList) {
        this.optionList = optionList;
    }

    public List getResult() {
        return result;
    }

    public void setResult(List result) {
        this.result = result;
    }
}
