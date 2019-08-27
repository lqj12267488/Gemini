package com.goisan.educational.teachingresult.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/21.
 */
public class TeachingResultProject extends BaseBean {
    private String id;
    private String personId;
    private String deptId;
    private String typicalFlag;
    private String projectType;
    private String projectName;
    private String projectRole;
    private String ranking;
    private String subject;
    private String approveNum;
    private String fundsAmount;
    private String startDate;
    private String endDate;
    private String projectSource;
    private String projectClient;
    private String remark;
    private String resultType;
    private String resultTypeValue;
    private String createDate;

    public String getResultTypeValue() {
        return resultTypeValue;
    }

    public void setResultTypeValue(String resultTypeValue) {
        this.resultTypeValue = resultTypeValue;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getTypicalFlag() {
        return typicalFlag;
    }

    public void setTypicalFlag(String typicalFlag) {
        this.typicalFlag = typicalFlag;
    }

    public String getProjectType() {
        return projectType;
    }

    public void setProjectType(String projectType) {
        this.projectType = projectType;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getProjectRole() {
        return projectRole;
    }

    public void setProjectRole(String projectRole) {
        this.projectRole = projectRole;
    }

    public String getRanking() {
        return ranking;
    }

    public void setRanking(String ranking) {
        this.ranking = ranking;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getApproveNum() {
        return approveNum;
    }

    public void setApproveNum(String approveNum) {
        this.approveNum = approveNum;
    }

    public String getFundsAmount() {
        return fundsAmount;
    }

    public void setFundsAmount(String fundsAmount) {
        this.fundsAmount = fundsAmount;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getProjectSource() {
        return projectSource;
    }

    public void setProjectSource(String projectSource) {
        this.projectSource = projectSource;
    }

    public String getProjectClient() {
        return projectClient;
    }

    public void setProjectClient(String projectClient) {
        this.projectClient = projectClient;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getResultType() {
        return resultType;
    }

    public void setResultType(String resultType) {
        this.resultType = resultType;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
}