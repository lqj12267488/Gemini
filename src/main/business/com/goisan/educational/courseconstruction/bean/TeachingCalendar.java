package com.goisan.educational.courseconstruction.bean;

import com.goisan.system.bean.BaseBean;

public class TeachingCalendar extends BaseBean {

    private String id;
    private String term;
    private String time;
    private String deptId;
    private String deptShow;
    private String fileNumber;

    public String getDeptShow() {
        return deptShow;
    }

    public void setDeptShow(String deptShow) {
        this.deptShow = deptShow;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getFileNumber() {
        return fileNumber;
    }

    public void setFileNumber(String fileNumber) {
        this.fileNumber = fileNumber;
    }
}
