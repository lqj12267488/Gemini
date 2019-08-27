package com.goisan.attendance.attendance.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/7/7.
 */
public class AttendanceImplog extends BaseBean {
    private String id;
    private String coding;
    private String importNumber;
    private String importFileName;
    private String operator;
    private String operatorTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCoding() {
        return coding;
    }

    public void setCoding(String coding) {
        this.coding = coding;
    }

    public String getImportNumber() {
        return importNumber;
    }

    public void setImportNumber(String importNumber) {
        this.importNumber = importNumber;
    }

    public String getImportFileName() {
        return importFileName;
    }

    public void setImportFileName(String importFileName) {
        this.importFileName = importFileName;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getOperatorTime() {
        return operatorTime;
    }

    public void setOperatorTime(String operatorTime) {
        this.operatorTime = operatorTime;
    }
}
