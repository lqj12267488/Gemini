package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

import java.util.prefs.BackingStoreException;

/**学校车辆外出使用管理
 * Created by wq on 2017/6/27 0027.
 */
public class SchoolCar extends BaseBean{
    private String id;
    private String requester;
    private String requestDept;
    private String requestDate;
    private String startTime;
    private String endTime;
    private String startDate;
    private String endDate;
    private String startPlace;
    private String endPlace;
    private String carType;
    private String reason;
    private String peopleNum;
    private String remark;
    private String useType;
    private String drivenMileage;
    private String carLoss;
    private String carManager;
    private String carManagerDept;
    private String checkTime;
    private String checkFlag;
    private String requesterConfirmFlag;
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String carTypeShow;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
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

    public String getStartPlace() {
        return startPlace;
    }

    public void setStartPlace(String startPlace) {
        this.startPlace = startPlace;
    }

    public String getEndPlace() {
        return endPlace;
    }

    public void setEndPlace(String endPlace) {
        this.endPlace = endPlace;
    }

    public String getCarType() {
        return carType;
    }

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getPeopleNum() {
        return peopleNum;
    }

    public void setPeopleNum(String peopleNum) {
        this.peopleNum = peopleNum;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUseType() {
        return useType;
    }

    public void setUseType(String useType) {
        this.useType = useType;
    }

    public String getDrivenMileage() {
        return drivenMileage;
    }

    public void setDrivenMileage(String drivenMileage) {
        this.drivenMileage = drivenMileage;
    }

    public String getCarLoss() {
        return carLoss;
    }

    public void setCarLoss(String carLoss) {
        this.carLoss = carLoss;
    }

    public String getCarManager() {
        return carManager;
    }

    public void setCarManager(String carManager) {
        this.carManager = carManager;
    }

    public String getCarManagerDept() {
        return carManagerDept;
    }

    public void setCarManagerDept(String carManagerDept) {
        this.carManagerDept = carManagerDept;
    }

    public String getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(String checkTime) {
        this.checkTime = checkTime;
    }

    public String getCheckFlag() {
        return checkFlag;
    }

    public void setCheckFlag(String checkFlag) {
        this.checkFlag = checkFlag;
    }

    public String getRequesterConfirmFlag() {
        return requesterConfirmFlag;
    }

    public void setRequesterConfirmFlag(String requesterConfirmFlag) {
        this.requesterConfirmFlag = requesterConfirmFlag;
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

    public String getCarTypeShow() {
        return carTypeShow;
    }

    public void setCarTypeShow(String carTypeShow) {
        this.carTypeShow = carTypeShow;
    }
}
