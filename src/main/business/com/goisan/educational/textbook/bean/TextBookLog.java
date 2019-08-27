package com.goisan.educational.textbook.bean;


import com.goisan.system.bean.BaseBean;

public class TextBookLog extends BaseBean {

    private String id;
    //教材类型
    private String textbookType;
    //教材名称（id）
    private String textbookId	;
    //操作类型
    private String operationType;
    //操作数量
    private String operationNum;
    //操作时间
    private String operationTime;
    //备注
    private String remark;
    private String personType;
    private String receiver;
    private String textbookName;
    private String textbookNumAll;
    private String textbookNumIn;
    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTextbookType() {
        return textbookType;
    }

    public void setTextbookType(String textbookType) {
        this.textbookType = textbookType;
    }

    public String getTextbookId() {
        return textbookId;
    }

    public void setTextbookId(String textbookId) {
        this.textbookId = textbookId;
    }

    public String getOperationType() {
        return operationType;
    }

    public void setOperationType(String operationType) {
        this.operationType = operationType;
    }

    public String getOperationNum() {
        return operationNum;
    }

    public void setOperationNum(String operationNum) {
        this.operationNum = operationNum;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getOperationTime() {
        return operationTime;
    }

    public void setOperationTime(String operationTime) {
        this.operationTime = operationTime;
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
    }

    public String getTextbookName() {
        return textbookName;
    }

    public void setTextbookName(String textbookName) {
        this.textbookName = textbookName;
    }

    public String getTextbookNumAll() {
        return textbookNumAll;
    }

    public void setTextbookNumAll(String textbookNumAll) {
        this.textbookNumAll = textbookNumAll;
    }

    public String getTextbookNumIn() {
        return textbookNumIn;
    }

    public void setTextbookNumIn(String textbookNumIn) {
        this.textbookNumIn = textbookNumIn;
    }
}
