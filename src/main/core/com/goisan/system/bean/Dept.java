package com.goisan.system.bean;

/**
 * Created by Admin on 2017/4/24.
 */
public class Dept extends BaseBean {
    private String deptId;
    private String deptName;
    private String parentDeptId;
    private String deptType;
    private String deptDescription;
    private String teachingFlag;
    private Integer deptOrder;
    private String leaderFlag;

    public Integer getDeptOrder() {
        return deptOrder;
    }

    public void setDeptOrder(Integer deptOrder) {
        this.deptOrder = deptOrder;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getParentDeptId() {
        return parentDeptId;
    }

    public void setParentDeptId(String parentDeptId) {
        this.parentDeptId = parentDeptId;
    }

    public String getDeptType() {
        return deptType;
    }

    public void setDeptType(String deptType) {
        this.deptType = deptType;
    }

    public String getDeptDescription() {
        return deptDescription;
    }

    public void setDeptDescription(String deptDescription) {
        this.deptDescription = deptDescription;
    }

    public String getTeachingFlag() {
        return teachingFlag;
    }

    public void setTeachingFlag(String teachingFlag) {
        this.teachingFlag = teachingFlag;
    }

    public String getLeaderFlag() {
        return leaderFlag;
    }

    public void setLeaderFlag(String leaderFlag) {
        this.leaderFlag = leaderFlag;
    }
}
