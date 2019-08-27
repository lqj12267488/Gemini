package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

public class Document extends BaseBean {
    private String id;
    private String requester;
    private String requestDept;
    private String requestDate;
    private String fileTitle;//文件标题
    private String deliveryEmpId;//主送人员id
    private String makeEmpId;//抄送人员id
    private String secretClass;//密级
    private String title;//标题
    private String printingNumber;//打印份数
    private String symbol;//文号
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String deliveryEmpIdShow;
    private String makeEmpIdShow;
    private String secretClassShow;
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

    public String getFileTitle() {
        return fileTitle;
    }

    public void setFileTitle(String fileTitle) {
        this.fileTitle = fileTitle;
    }

    public String getDeliveryEmpId() {
        return deliveryEmpId;
    }

    public void setDeliveryEmpId(String deliveryEmpId) {
        this.deliveryEmpId = deliveryEmpId;
    }

    public String getMakeEmpId() {
        return makeEmpId;
    }

    public void setMakeEmpId(String makeEmpId) {
        this.makeEmpId = makeEmpId;
    }

    public String getSecretClass() {
        return secretClass;
    }

    public void setSecretClass(String secretClass) {
        this.secretClass = secretClass;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPrintingNumber() {
        return printingNumber;
    }

    public void setPrintingNumber(String printingNumber) {
        this.printingNumber = printingNumber;
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
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

    public String getDeliveryEmpIdShow() {
        return deliveryEmpIdShow;
    }

    public void setDeliveryEmpIdShow(String deliveryEmpIdShow) {
        this.deliveryEmpIdShow = deliveryEmpIdShow;
    }

    public String getMakeEmpIdShow() {
        return makeEmpIdShow;
    }

    public void setMakeEmpIdShow(String makeEmpIdShow) {
        this.makeEmpIdShow = makeEmpIdShow;
    }

    public String getSecretClassShow() {
        return secretClassShow;
    }

    public void setSecretClassShow(String secretClassShow) {
        this.secretClassShow = secretClassShow;
    }
}
