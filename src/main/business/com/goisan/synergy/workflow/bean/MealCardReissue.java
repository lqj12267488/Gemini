package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/10/11.
 */
public class MealCardReissue extends BaseBean{
    private String id;//饭卡办理ID
    private String teacherId;//教师ID
    private String deptId;//部门ID
    private String reissueReason;//补卡原因
    private String treatment;//补卡待遇
    private String reissueTime;//补卡时间
    private String reissueDate;//申请补办时间
    private String remark;//备注
    private String requester;
    private String requestDate;
    private String requestDept;
    private String reissueReasonShow;
    private String personIdShow;
    private String requestFlag;
    private String feedbackFlag;
    private String feedBack;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getReissueReason() {
        return reissueReason;
    }

    public void setReissueReason(String reissueReason) {
        this.reissueReason = reissueReason;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }

    public String getReissueTime() {
        return reissueTime;
    }

    public void setReissueTime(String reissueTime) {
        this.reissueTime = reissueTime;
    }

    public String getReissueDate() {
        return reissueDate;
    }

    public void setReissueDate(String reissueDate) {
        this.reissueDate = reissueDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
    }

    public String getReissueReasonShow() {
        return reissueReasonShow;
    }

    public void setReissueReasonShow(String reissueReasonShow) {
        this.reissueReasonShow = reissueReasonShow;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }

    public String getFeedBack() {
        return feedBack;
    }

    public void setFeedBack(String feedBack) {
        this.feedBack = feedBack;
    }
}
