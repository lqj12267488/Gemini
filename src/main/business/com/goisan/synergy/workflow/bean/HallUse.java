package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**礼堂使用管理
 * Created by  on 2017/7/18.
 */
public class HallUse extends BaseBean {
    private String id;
    private String requestDept;
    private String requester;
    private String requestDate;
    private String leaderDept;
    private String leader;
    private String startTime;
    private String endTime;
    private String usedevice;
    private String usedeviceShow;
    private String peopleNumber;
    private String content;
    private String remark;
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String tableName;

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

    public String getUsedevice() {
        return usedevice;
    }

    public void setUsedevice(String usedevice) {
        this.usedevice = usedevice;
    }

    public String getUsedeviceShow() {
        return usedeviceShow;
    }

    public void setUsedeviceShow(String usedeviceShow) {
        this.usedeviceShow = usedeviceShow;
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

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
}
