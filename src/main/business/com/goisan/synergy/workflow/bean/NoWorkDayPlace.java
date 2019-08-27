package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**非工作日学校场所使用管理
 * Created by wq on 2017/7/19.
 */
public class NoWorkDayPlace extends BaseBean {
    private String id;
    private String requestDept;
    private String requester;
    private String requestDate;
    private String requestTime;
    private String startDate;
    private String endDate;
    private String leaderDept;
    private String leader;
    private String startTime;
    private String endTime;
    private String peopleNumber;
    private String content;
    private String usePlace;
    private String place;
    private String useProperty;
    private String property;
    private String remark;
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getProperty() {
        return property;
    }

    public void setProperty(String property) {
        this.property = property;
    }

    public String getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(String requestTime) {
        this.requestTime = requestTime;
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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getLeaderDept() {
        return leaderDept;
    }

    public void setLeaderDept(String leaderDept) {
        this.leaderDept = leaderDept;
    }

    public String getLeader() {
        return leader;
    }

    public void setLeader(String leader) {
        this.leader = leader;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getPeopleNumber() {
        return peopleNumber;
    }

    public void setPeopleNumber(String peopleNumber) {
        this.peopleNumber = peopleNumber;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUsePlace() {
        return usePlace;
    }

    public void setUsePlace(String usePlace) {
        this.usePlace = usePlace;
    }

    public String getUseProperty() {
        return useProperty;
    }

    public void setUseProperty(String useProperty) {
        this.useProperty = useProperty;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }
}
