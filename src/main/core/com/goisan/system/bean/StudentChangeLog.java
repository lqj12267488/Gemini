package com.goisan.system.bean;

/**
 * Created by Admin on 2017/4/20.
 */
public class StudentChangeLog extends BaseBean {
    private String studentId ;
    private String changeType;
    private String oldCode ;
    private String oldContent ;
    private String newCode;
    private String newContent;
    private String studentShow;
    private String changeTypeShow;
    private String logTime;
    private String studentCount;
    private String changeStatus;
    private String changeStartTime;
    private String changeEndTime;

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
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

    public String getStudentShow() {
        return studentShow;
    }

    public void setStudentShow(String studentShow) {
        this.studentShow = studentShow;
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

    public String getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(String studentCount) {
        this.studentCount = studentCount;
    }

    public String getChangeStatus() {
        return changeStatus;
    }

    public void setChangeStatus(String changeStatus) {
        this.changeStatus = changeStatus;
    }

    public String getChangeStartTime() {
        return changeStartTime;
    }

    public void setChangeStartTime(String changeStartTime) {
        this.changeStartTime = changeStartTime;
    }

    public String getChangeEndTime() {
        return changeEndTime;
    }

    public void setChangeEndTime(String changeEndTime) {
        this.changeEndTime = changeEndTime;
    }
}
