package com.goisan.evaluation.bean;

import com.goisan.system.bean.BaseBean;

import java.sql.Date;

public class EvaluationEmpsMenmbers extends BaseBean {
    private String id;
    private String memberId;
    private String empsId;
    private String taskId;
    private String empPersonId;
    private String empDeptId;
    private String empName;
    private String memberPersonId;
    private String memberDeptId;
    private String memberName;
    private String taskName;
    private Date endTime;
    private Date startTime;
    private String empDeptShow;
    private String planId;
    private String invalidFlag;
    private String evaluationFlag;
    private String score;
    private String invalidOperator;
    private String invalidOperatorDept;
    private String invalidReason;
    private String evaluationType;
    private String interviewDecision;
    private String interviewEvaluate;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getEmpsId() {
        return empsId;
    }

    public void setEmpsId(String empsId) {
        this.empsId = empsId;
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

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String getEmpDeptShow() {
        return empDeptShow;
    }

    public void setEmpDeptShow(String empDeptShow) {
        this.empDeptShow = empDeptShow;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getInvalidFlag() {
        return invalidFlag;
    }

    public void setInvalidFlag(String invalidFlag) {
        this.invalidFlag = invalidFlag;
    }

    public String getEvaluationFlag() {
        return evaluationFlag;
    }

    public void setEvaluationFlag(String evaluationFlag) {
        this.evaluationFlag = evaluationFlag;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getInvalidOperator() {
        return invalidOperator;
    }

    public void setInvalidOperator(String invalidOperator) {
        this.invalidOperator = invalidOperator;
    }

    public String getInvalidOperatorDept() {
        return invalidOperatorDept;
    }

    public void setInvalidOperatorDept(String invalidOperatorDept) {
        this.invalidOperatorDept = invalidOperatorDept;
    }

    public String getInvalidReason() {
        return invalidReason;
    }

    public void setInvalidReason(String invalidReason) {
        this.invalidReason = invalidReason;
    }

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }

    public String getInterviewDecision() {
        return interviewDecision;
    }

    public void setInterviewDecision(String interviewDecision) {
        this.interviewDecision = interviewDecision;
    }

    public String getInterviewEvaluate() {
        return interviewEvaluate;
    }

    public void setInterviewEvaluate(String interviewEvaluate) {
        this.interviewEvaluate = interviewEvaluate;
    }
}
