package com.goisan.evaluation.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/7/18.
 */
public class EvaluationComplexTask extends BaseBean {
    private String complexTaskId;
    private String complexTaskName;
    private String term;
    private String score;
    private String remark;
    private String startTime;
    private String termShow;
    private String testFlag;
    private String testFlagShow;
    private String evaluationType;
    private String lengths;

    public String getComplexTaskId() {
        return complexTaskId;
    }

    public void setComplexTaskId(String complexTaskId) {
        this.complexTaskId = complexTaskId;
    }

    public String getComplexTaskName() {
        return complexTaskName;
    }

    public void setComplexTaskName(String complexTaskName) {
        this.complexTaskName = complexTaskName;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getTermShow() {
        return termShow;
    }

    public void setTermShow(String termShow) {
        this.termShow = termShow;
    }

    public String getTestFlag() {
        return testFlag;
    }

    public void setTestFlag(String testFlag) {
        this.testFlag = testFlag;
    }

    public String getTestFlagShow() {
        return testFlagShow;
    }

    public void setTestFlagShow(String testFlagShow) {
        this.testFlagShow = testFlagShow;
    }

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }

    public String getLengths() {
        return lengths;
    }

    public void setLengths(String lengths) {
        this.lengths = lengths;
    }

}
