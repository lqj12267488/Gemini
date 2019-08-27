package com.goisan.partybuilding.party.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/8/14/014.
 */
public class PartyMemberLog extends BaseBean {
    private String id;
    private String personType;
    private String personId;
    private String deptId;
    private String branchId;
    private String logType;
    private String logRemark;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
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
