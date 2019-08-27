package com.goisan.leaguebuilding.league.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/09/28.
 */
public class LeagueMemberLog extends BaseBean {
    private String id;
    private String studentId;
    private String classId;
    private String branchId;
    private String logType;
    private String logRemark;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getBranchId() {
        return branchId;
    }

    public void setBranchId(String branchId) {
        this.branchId = branchId;
    }

    public String getLogType() {
        return logType;
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public String getLogRemark() {
        return logRemark;
    }

    public void setLogRemark(String logRemark) {
        this.logRemark = logRemark;
    }
}
