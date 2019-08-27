package com.goisan.synergy.notice.bean;

import com.goisan.system.bean.BaseBean;

import java.sql.Date;

/**
 * Created by admin on 2017/5/11.
 */
public class Notice extends BaseBean {
    private String id ;
    private String title  ;
    private String content   ;
    private String type   ;
    private String publicTime  ;
    private Date startTime  ;
    private Date endTime   ;
    private String typeShow   ;
    private String deptId;
    private String noticeID;
    private String loginID;
    private String persinId;
    private String flag;
    private String abc;
    private String deptIdShow;
    private String persinIdShow;
    private String requester;
    private String requestDept;
    private String publishFlag;
    private String requestFlag;
    private String workFlowFlag;
    private String photoUrl;
    private String messagesClass;
    private String isDean;

    public String getMessagesClass() {
        return messagesClass;
    }

    public void setMessagesClass(String messagesClass) {
        this.messagesClass = messagesClass;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

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

    public String getPublicTime() {
        return publicTime;
    }

    public void setPublicTime(String publicTime) {
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

    public String getNoticeID() {
        return noticeID;
    }

    public void setNoticeID(String noticeID) {
        this.noticeID = noticeID;
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

    public String getDeptIdShow() {
        return deptIdShow;
    }

    public void setDeptIdShow(String deptIdShow) {
        this.deptIdShow = deptIdShow;
    }

    public String getPersinIdShow() {
        return persinIdShow;
    }

    public void setPersinIdShow(String persinIdShow) {
        this.persinIdShow = persinIdShow;
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
