package com.goisan.approval.bean;

import com.goisan.system.bean.BaseBean;

public class ResourceApproval extends BaseBean {
    private String approvalId;
    private String resourceId;
    private String resourceName;
    private String requestDept;
    private String requester;
    private String requestDate;
    private String requestReason;
    private String requestType;
    private String requestFlag;
    private String approvalDept;
    private String approver;
    private String approvalTime;
    private String approvalFlag;
    private String approvalOpinion;
    private String approverShow;

    public String getRequesterShow() {
        return requesterShow;
    }

    public void setRequesterShow(String requesterShow) {
        this.requesterShow = requesterShow;
    }

    private String requesterShow;

    public String getRequestTypeShow() {
        return requestTypeShow;
    }

    public void setRequestTypeShow(String requestTypeShow) {
        this.requestTypeShow = requestTypeShow;
    }

    private String requestTypeShow;

    public String getRequestFlagShow() {
        return requestFlagShow;
    }

    public void setRequestFlagShow(String requestFlagShow) {
        this.requestFlagShow = requestFlagShow;
    }

    private String requestFlagShow;

    public String getApproverShow() {
        return approverShow;
    }

    public void setApproverShow(String approverShow) {
        this.approverShow = approverShow;
    }

    public String getApprovalId() {
        return approvalId;
    }

    public void setApprovalId(String approvalId) {
        this.approvalId = approvalId;
    }
    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }
    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
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
    public String getRequestReason() {
        return requestReason;
    }

    public void setRequestReason(String requestReason) {
        this.requestReason = requestReason;
    }
    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }
    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }
    public String getApprovalDept() {
        return approvalDept;
    }

    public void setApprovalDept(String approvalDept) {
        this.approvalDept = approvalDept;
    }
    public String getApprover() {
        return approver;
    }

    public void setApprover(String approver) {
        this.approver = approver;
    }
    public String getApprovalTime() {
        return approvalTime;
    }

    public void setApprovalTime(String approvalTime) {
        this.approvalTime = approvalTime;
    }
    public String getApprovalFlag() {
        return approvalFlag;
    }

    public void setApprovalFlag(String approvalFlag) {
        this.approvalFlag = approvalFlag;
    }
    public String getApprovalOpinion() {
        return approvalOpinion;
    }

    public void setApprovalOpinion(String approvalOpinion) {
        this.approvalOpinion = approvalOpinion;
    }
}
