package com.goisan.leaguebuilding.league.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by fn on 2017/9/21.
 */
public class League extends BaseBean {
    private String id;
    private String ids;
    private String leagueMembersNumber;
    private String membersNumber;
    private String studentId;
    private String classId;
    private String studentName;
    private String branchId;
    private String branchName;
    private String memberDuties; //使用团内职务字典1.书记2.组织委员3.宣传委员
    private String memberDutiesId; //使用团内职务字典1.书记2.组织委员3.宣传委员
    private String joinleagueTime;
    private String remark;
    private String relationshipChangeType;
    private String relationshipChangeTime;
    private String relationshipRemark;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getLeagueMembersNumber() {
        return leagueMembersNumber;
    }

    public void setLeagueMembersNumber(String leagueMembersNumber) {
        this.leagueMembersNumber = leagueMembersNumber;
    }

    public String getMembersNumber() {
        return membersNumber;
    }

    public void setMembersNumber(String membersNumber) {
        this.membersNumber = membersNumber;
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

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getBranchId() {
        return branchId;
    }

    public void setBranchId(String branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getMemberDuties() {
        return memberDuties;
    }

    public void setMemberDuties(String memberDuties) {
        this.memberDuties = memberDuties;
    }

    public String getMemberDutiesId() {
        return memberDutiesId;
    }

    public void setMemberDutiesId(String memberDutiesId) {
        this.memberDutiesId = memberDutiesId;
    }

    public String getJoinleagueTime() {
        return joinleagueTime;
    }

    public void setJoinleagueTime(String joinleagueTime) {
        this.joinleagueTime = joinleagueTime;
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
}
