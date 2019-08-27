package com.goisan.educational.teachingresult.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/27.
 */
public class TeachingResultGuide extends BaseBean {
    private String id;
    private String personId;
    private String deptId;
    private String typicalFlag;
    private String role;
    private String prizeName;
    private String prizeRank;
    private String prizeDate;
    private String workDescribe;
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

    public String getPrizeName() {
        return prizeName;
    }

    public void setPrizeName(String prizeName) {
        this.prizeName = prizeName;
    }

    public String getPrizeRank() {
        return prizeRank;
    }

    public void setPrizeRank(String prizeRank) {
        this.prizeRank = prizeRank;
    }

    public String getPrizeDate() {
        return prizeDate;
    }

    public void setPrizeDate(String prizeDate) {
        this.prizeDate = prizeDate;
    }

    public String getWorkDescribe() {
        return workDescribe;
    }

    public void setWorkDescribe(String workDescribe) {
        this.workDescribe = workDescribe;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
