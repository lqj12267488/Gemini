package com.goisan.evaluation.bean;

import com.goisan.system.bean.BaseBean;

import java.sql.Date;

public class EvaluationTask extends BaseBean {
    private String taskId;
    private String taskName;
    private String planId;
    private String planName;
    private String term;
    private String groupId;

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    private String groupName;
    private String taskType;
    private Date startTime;
    private Date endTime;
    private String end;
    private String remark;
    private String schedule;
    private String startFlag;
    private String startFlagShow;
    private String evaluationType;
    private String empGroupId;
    private int limitMin;
    private int limitHig;
    private String name;
    private String staffId;
    private String pushFlag;
    private String personId;
    private String totalNumber;
    private String number;
    private String numberEmp;
    private String totalNumberEmp;

    public String getNumberEmp() {
        return numberEmp;
    }

    public void setNumberEmp(String numberEmp) {
        this.numberEmp = numberEmp;
    }

    public String getTotalNumberEmp() {
        return totalNumberEmp;
    }

    public void setTotalNumberEmp(String totalNumberEmp) {
        this.totalNumberEmp = totalNumberEmp;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getTaskType() {
        return taskType;
    }

    public void setTaskType(String taskType) {
        this.taskType = taskType;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(String schedule) {
        this.schedule = schedule;
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

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }

    public String getEmpGroupId() {
        return empGroupId;
    }

    public void setEmpGroupId(String empGroupId) {
        this.empGroupId = empGroupId;
    }

    public int getLimitMin() {
        return limitMin;
    }

    public void setLimitMin(int limitMin) {
        this.limitMin = limitMin;
    }

    public int getLimitHig() {
        return limitHig;
    }

    public void setLimitHig(int limitHig) {
        this.limitHig = limitHig;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getPushFlag() {
        return pushFlag;
    }

    public void setPushFlag(String pushFlag) {
        this.pushFlag = pushFlag;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(String totalNumber) {
        this.totalNumber = totalNumber;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }
}
