package com.goisan.educational.policy.bean;

import com.goisan.system.bean.BaseBean;

public class PolicyDocument extends BaseBean{
    private String id;
    private String serialNumber;
    private String documentName;
    private String time;
    private String documentSign;
    private String fileNumber;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getDocumentName() {
        return documentName;
    }

    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDocumentSign() {
        return documentSign;
    }

    public void setDocumentSign(String documentSign) {
        this.documentSign = documentSign;
    }

    public String getFileNumber() {
        return fileNumber;
    }

    public void setFileNumber(String fileNumber) {
        this.fileNumber = fileNumber;
    }
}
