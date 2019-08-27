package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**协同办公-校内车辆管理
 * Created by wq on 2017/10/10.
 */
public class SchoolVehicle extends BaseBean {
    private String id;
    private String vehicleModel;
    private String vehicleNum;
    private String vehicleIf;
    private String requestDept;
    private String requester;
    private String requestTime;
    private String requestDate;
    private String remark;
    private String feedback;
    private String feedbackFlag;
    private String requestFlag;
    private String isVehicle;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVehicleModel() {
        return vehicleModel;
    }

    public void setVehicleModel(String vehicleModel) {
        this.vehicleModel = vehicleModel;
    }

    public String getVehicleNum() {
        return vehicleNum;
    }

    public void setVehicleNum(String vehicleNum) {
        this.vehicleNum = vehicleNum;
    }

    public String getVehicleIf() {
        return vehicleIf;
    }

    public void setVehicleIf(String vehicleIf) {
        this.vehicleIf = vehicleIf;
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

    public String getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(String requestTime) {
        this.requestTime = requestTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getIsVehicle() {
        return isVehicle;
    }

    public void setIsVehicle(String isVehicle) {
        this.isVehicle = isVehicle;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }
}
