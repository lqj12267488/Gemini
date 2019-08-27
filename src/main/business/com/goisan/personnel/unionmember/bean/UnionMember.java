package com.goisan.personnel.unionmember.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/9/19.
 */
public class UnionMember extends BaseBean{
    private String id;//主键id
    private String personId;//教职工id
    private String deptId;//组织机构id
    private String memberNumber;//会员编号
    private String unionDuties;//工会职务
    private String joinTime;//入会时间
    private String remark;//备注
    private String personIdShow;
    private String deptIdShow;

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

    public String getMemberNumber() {
        return memberNumber;
    }

    public void setMemberNumber(String memberNumber) {
        this.memberNumber = memberNumber;
    }

    public String getUnionDuties() {
        return unionDuties;
    }

    public void setUnionDuties(String unionDuties) {
        this.unionDuties = unionDuties;
    }

    public String getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(String joinTime) {
        this.joinTime = joinTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }

    public String getDeptIdShow() {
        return deptIdShow;
    }

    public void setDeptIdShow(String deptIdShow) {
        this.deptIdShow = deptIdShow;
    }
}
