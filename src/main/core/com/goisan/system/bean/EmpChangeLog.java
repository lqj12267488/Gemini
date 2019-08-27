package com.goisan.system.bean;

import java.sql.Date;

/**
 * Created by Admin on 2017/4/20.
 */
public class EmpChangeLog extends BaseBean {
    private String personId ;
    private String changeType;
    private String oldCode ;
    private String oldContent ;
    private String newCode;
    private String newContent;
    private String personShow;
    private String changeTypeShow;
    private String logTime;
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getChangeType() {
        return changeType;
    }

    public void setChangeType(String changeType) {
        this.changeType = changeType;
    }

    public String getOldCode() {
        return oldCode;
    }

    public void setOldCode(String oldCode) {
        this.oldCode = oldCode;
    }

    public String getOldContent() {
        return oldContent;
    }

    public void setOldContent(String oldContent) {
        this.oldContent = oldContent;
    }

    public String getNewCode() {
        return newCode;
    }

    public void setNewCode(String newCode) {
        this.newCode = newCode;
    }

    public String getNewContent() {
        return newContent;
    }

    public void setNewContent(String newContent) {
        this.newContent = newContent;
    }

    public String getPersonShow() {
        return personShow;
    }

    public void setPersonShow(String personShow) {
        this.personShow = personShow;
    }

    public String getChangeTypeShow() {
        return changeTypeShow;
    }

    public void setChangeTypeShow(String changeTypeShow) {
        this.changeTypeShow = changeTypeShow;
    }

    public String getLogTime() {
        return logTime;
    }

    public void setLogTime(String logTime) {
        this.logTime = logTime;
    }
}
