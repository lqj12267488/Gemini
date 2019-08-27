package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/10/10.
 */
public class MealCardHandle extends BaseBean {
    private String id;//饭卡办理ID
    private String teacherId;//教师ID
    private String deptId;//部门ID
    private String mealCardType;//饭卡类型
    private String mealCardTime;//申请办卡时间
    private String mealCardDate;//申请办卡时间
    private String remark;//备注
    private String requester;
    private String requestDate;
    private String requestDept;
    private String mealCardTypeShow;
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

    public String getMealCardType() {
        return mealCardType;
    }

    public void setMealCardType(String mealCardType) {
        this.mealCardType = mealCardType;
    }

    public String getMealCardTime() {
        return mealCardTime;
    }

    public void setMealCardTime(String mealCardTime) {
        this.mealCardTime = mealCardTime;
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

    public String getMealCardTypeShow() {
        return mealCardTypeShow;
    }

    public void setMealCardTypeShow(String mealCardTypeShow) {
        this.mealCardTypeShow = mealCardTypeShow;
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

    public String getMealCardDate() {
        return mealCardDate;
    }

    public void setMealCardDate(String mealCardDate) {
        this.mealCardDate = mealCardDate;
    }
}
