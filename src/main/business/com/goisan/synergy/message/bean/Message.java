package com.goisan.synergy.message.bean;

import com.goisan.system.bean.BaseBean;

import java.sql.Date;

/**
 * Created by admin on 2017/5/11.
 */
public class Message extends BaseBean {
    private String id;
    private String title;
    private String content;
    private String type;
    private Date publicTime;
    private Date startTime;
    private Date endTime;
    private String typeShow;
    private String deptId;
    private String messageID;
    private String loginID;
    private String persinId;
    private String flag;
    private String abc;
    private String empId;
    private String empIdShow;
    private String deptIdShow;
    private String range;
    private String requester;
    private String requestDept;
    private String stuId;
    private String parId;
    private String stuIdShow;
    private String parIdShow;
    private String publishFlag;
    private String requestFlag;
    private String workFlowFlag;
    private String isDean;


    public String getTypeShow() {
        return typeShow;
    }

    public void setTypeShow(String typeShow) {
        this.typeShow = typeShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getPublicTime() {
        return publicTime;
    }

    public void setPublicTime(Date publicTime) {
        this.publicTime = publicTime;
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

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getMessageID() {
        return messageID;
    }

    public void setMessageID(String messageID) {
        this.messageID = messageID;
    }

    public String getLoginID() {
        return loginID;
    }

    public void setLoginID(String loginID) {
        this.loginID = loginID;
    }

    public String getPersinId() {
        return persinId;
    }

    public void setPersinId(String persinId) {
        this.persinId = persinId;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getAbc() {
        return abc;
    }

    public void setAbc(String abc) {
        this.abc = abc;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getEmpIdShow() {
        return empIdShow;
    }

    public void setEmpIdShow(String empIdShow) {
        this.empIdShow = empIdShow;
    }

    public String getRange() {
        return range;
    }

    public void setRange(String range) {
        this.range = range;
    }

    public String getDeptIdShow() {
        return deptIdShow;
    }

    public void setDeptIdShow(String deptIdShow) {
        this.deptIdShow = deptIdShow;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
    }

    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }

    public String getParId() {
        return parId;
    }

    public void setParId(String parId) {
        this.parId = parId;
    }

    public String getStuIdShow() {
        return stuIdShow;
    }

    public void setStuIdShow(String stuIdShow) {
        this.stuIdShow = stuIdShow;
    }

    public String getParIdShow() {
        return parIdShow;
    }

    public void setParIdShow(String parIdShow) {
        this.parIdShow = parIdShow;
    }

    public String getPublishFlag() {
        return publishFlag;
    }

    public void setPublishFlag(String publishFlag) {
        this.publishFlag = publishFlag;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getWorkFlowFlag() {
        return workFlowFlag;
    }

    public void setWorkFlowFlag(String workFlowFlag) {
        this.workFlowFlag = workFlowFlag;
    }

    public String getIsDean() { return isDean; }

    public void setIsDean(String isDean) { this.isDean = isDean; }

}
