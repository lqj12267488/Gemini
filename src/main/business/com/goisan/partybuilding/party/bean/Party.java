package com.goisan.partybuilding.party.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/26/026.
 */
public class Party extends BaseBean {
    private String id;
    private String ids;
    private String personType;
    private String personSource;
    private String personId;
    private String personIdDept;
    private String deptId;
    private String branchId;
    private String memberRoles;
    private String firstCultivatePeopleId;
    private String firstCultivatePeopleDeptId;
    private String firstCultivatePeopleIdDept;
    private String secondCultivatePeopleIdDept;
    private String secondCultivatePeopleDeptId;
    private String applyTime;
    private String activeMolecularTime;
    private String developmentTime;
    private String prepareTime;
    private String joinPartyTime;
    private String remark;
    private String relationshipChangeType;
    private String relationshipChangeTime;
    private String relationshipRemark;
    private String peopleRoles;
    private String personRoles;

    public String getPersonRoles() {
        return personRoles;
    }

    public void setPersonRoles(String personRoles) {
        this.personRoles = personRoles;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getPeopleRoles() {
        return peopleRoles;
    }

    public void setPeopleRoles(String peopleRoles) {
        this.peopleRoles = peopleRoles;
    }

    public String getFirstCultivatePeopleIdDept() {
        return firstCultivatePeopleIdDept;
    }

    public void setFirstCultivatePeopleIdDept(String firstCultivatePeopleIdDept) {
        this.firstCultivatePeopleIdDept = firstCultivatePeopleIdDept;
    }

    public String getSecondCultivatePeopleIdDept() {
        return secondCultivatePeopleIdDept;
    }

    public void setSecondCultivatePeopleIdDept(String secondCultivatePeopleIdDept) {
        this.secondCultivatePeopleIdDept = secondCultivatePeopleIdDept;
    }

    private String secondCultivatePeopleId;

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

    public String getPersonSource() {
        return personSource;
    }

    public void setPersonSource(String personSource) {
        this.personSource = personSource;
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

    public String getMemberRoles() {
        return memberRoles;
    }

    public void setMemberRoles(String memberRoles) {
        this.memberRoles = memberRoles;
    }

    public String getFirstCultivatePeopleId() {
        return firstCultivatePeopleId;
    }

    public void setFirstCultivatePeopleId(String firstCultivatePeopleId) {
        this.firstCultivatePeopleId = firstCultivatePeopleId;
    }

    public String getFirstCultivatePeopleDeptId() {
        return firstCultivatePeopleDeptId;
    }

    public void setFirstCultivatePeopleDeptId(String firstCultivatePeopleDeptId) {
        this.firstCultivatePeopleDeptId = firstCultivatePeopleDeptId;
    }

    public String getSecondCultivatePeopleId() {
        return secondCultivatePeopleId;
    }

    public void setSecondCultivatePeopleId(String secondCultivatePeopleId) {
        this.secondCultivatePeopleId = secondCultivatePeopleId;
    }

    public String getSecondCultivatePeopleDeptId() {
        return secondCultivatePeopleDeptId;
    }

    public void setSecondCultivatePeopleDeptId(String secondCultivatePeopleDeptId) {
        this.secondCultivatePeopleDeptId = secondCultivatePeopleDeptId;
    }

    public String getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(String applyTime) {
        this.applyTime = applyTime;
    }

    public String getActiveMolecularTime() {
        return activeMolecularTime;
    }

    public void setActiveMolecularTime(String activeMolecularTime) {
        this.activeMolecularTime = activeMolecularTime;
    }

    public String getDevelopmentTime() {
        return developmentTime;
    }

    public void setDevelopmentTime(String developmentTime) {
        this.developmentTime = developmentTime;
    }

    public String getPrepareTime() {
        return prepareTime;
    }

    public void setPrepareTime(String prepareTime) {
        this.prepareTime = prepareTime;
    }

    public String getJoinPartyTime() {
        return joinPartyTime;
    }

    public void setJoinPartyTime(String joinPartyTime) {
        this.joinPartyTime = joinPartyTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getRelationshipChangeType() {
        return relationshipChangeType;
    }

    public void setRelationshipChangeType(String relationshipChangeType) {
        this.relationshipChangeType = relationshipChangeType;
    }

    public String getRelationshipChangeTime() {
        return relationshipChangeTime;
    }

    public void setRelationshipChangeTime(String relationshipChangeTime) {
        this.relationshipChangeTime = relationshipChangeTime;
    }

    public String getRelationshipRemark() {
        return relationshipRemark;
    }

    public void setRelationshipRemark(String relationshipRemark) {
        this.relationshipRemark = relationshipRemark;
    }

    public String getPersonIdDept() {
        return personIdDept;
    }

    public void setPersonIdDept(String personIdDept) {
        this.personIdDept = personIdDept;
    }
}
