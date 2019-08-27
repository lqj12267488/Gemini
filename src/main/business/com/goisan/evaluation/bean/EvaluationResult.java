package com.goisan.evaluation.bean;

import com.goisan.system.bean.BaseBean;

import java.sql.Date;
import java.util.List;

/**
 * Created by admin on 2017/6/16.
 */
public class EvaluationResult extends BaseBean {
    private String planName;
    private String resultId;
    private String indexId;
    private String taskId;
    private String empPersonId;
    private String empDeptId;
    private String empName;
    private String memberPersonId;
    private String memberDeptId;
    private String memberName;
    private Double score;
    private String remark;
    private String taskName;
    private String empDeptShow;
    private Date endTime;
    private String indexName;
    private String weights;
    private String planId;
    private String leafFlag;
    private String colspan;
    private String parentIndexId;
    private String rowspan;
    private List<EvaluationResult> evalList;
    private String fullScore;


    public String getParentIndexId() {
        return parentIndexId;
    }

    public void setParentIndexId(String parentIndexId) {
        this.parentIndexId = parentIndexId;
    }

    public String getLeafFlag() {
        return leafFlag;
    }

    public void setLeafFlag(String leafFlag) {
        this.leafFlag = leafFlag;
    }

    public String getColspan() {
        return colspan;
    }

    public void setColspan(String colspan) {
        this.colspan = colspan;
    }

    public String getRowspan() {
        return rowspan;
    }

    public void setRowspan(String rowspan) {
        this.rowspan = rowspan;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getWeights() {
        return weights;
    }

    public void setWeights(String weights) {
        this.weights = weights;
    }

    public String getIndexName() {
        return indexName;
    }

    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getEmpDeptShow() {
        return empDeptShow;
    }

    public void setEmpDeptShow(String empDeptShow) {
        this.empDeptShow = empDeptShow;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getResultId() {
        return resultId;
    }

    public void setResultId(String resultId) {
        this.resultId = resultId;
    }

    public String getIndexId() {
        return indexId;
    }

    public void setIndexId(String indexId) {
        this.indexId = indexId;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getEmpPersonId() {
        return empPersonId;
    }

    public void setEmpPersonId(String empPersonId) {
        this.empPersonId = empPersonId;
    }

    public String getEmpDeptId() {
        return empDeptId;
    }

    public void setEmpDeptId(String empDeptId) {
        this.empDeptId = empDeptId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getMemberPersonId() {
        return memberPersonId;
    }

    public void setMemberPersonId(String memberPersonId) {
        this.memberPersonId = memberPersonId;
    }

    public String getMemberDeptId() {
        return memberDeptId;
    }

    public void setMemberDeptId(String memberDeptId) {
        this.memberDeptId = memberDeptId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Double getScore() {
        return score;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<EvaluationResult> getEvalList() {
        return evalList;
    }

    public void setEvalList(List<EvaluationResult> evalList) {
        this.evalList = evalList;
    }

    public String getFullScore() {
        return fullScore;
    }

    public void setFullScore(String fullScore) {
        this.fullScore = fullScore;
    }

}
