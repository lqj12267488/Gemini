package com.goisan.educational.teachingresult.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/27.
 */
public class TeachingResultReport extends BaseBean {
    private String id;
    private String personId;
    private String deptId;
    private String typicalFlag;
    private String role;
    private String reportName;
    private String reportDate;
    private String consigner;
    private String remark;
    private String resultType;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getTypicalFlag() {
        return typicalFlag;
    }

    public void setTypicalFlag(String typicalFlag) {
        this.typicalFlag = typicalFlag;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName;
    }

    public String getReportDate() {
        return reportDate;
    }

    public void setReportDate(String reportDate) {
        this.reportDate = reportDate;
    }

    public String getConsigner() {
        return consigner;
    }

    public void setConsigner(String consigner) {
        this.consigner = consigner;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
