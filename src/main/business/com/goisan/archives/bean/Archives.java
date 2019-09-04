package com.goisan.archives.bean;

import com.goisan.system.bean.BaseBean;

public class Archives extends BaseBean {
    private String archivesId;
    private String personType;
    private String archivesName;
    private String archivesCode;
    private String deptCode;
    private String yearCode;
    private String schoolCode;
    private String oneLevel;
    private String twoLevel;
    private String fileType;
    private String requestDate;
    private String requestFlag;//申请状态，0无 1待审核 2已通过 3被驳回
    private String requestType;//申请类型,0无，1修改 2删除
    private String state;
    private String remark;
    private String editedId;
    private String operateType;//操作类型
    private String personId;//操作人
    private String deptId;//操作部门
    private String operateTime;//操作时间
    private String role;
    private String deptName;
    private String personName;
    private String reason;
    private String delState;
    private String condition;
    private String logId;
    private String roleFlag;
    private String schoolType;//学校类别
    private String fileNum;//附件数量
    private String roleState;//附件数量
    private String requestFlagShow;
    private String rolePersonId;
    private String rolePersonDept;
    private String businessId;
    private String formatTime;
    private String formatTimeStart;
    private String formatTimeEnd;
    private String createDeptOne;
    private String createPerson;

    public String getCreatePerson() {
        return createPerson;
    }

    public void setCreatePerson(String createPerson) {
        this.createPerson = createPerson;
    }

    public String getCreateDeptOne() {
        return createDeptOne;
    }

    public void setCreateDeptOne(String createDeptOne) {
        this.createDeptOne = createDeptOne;
    }

    public String getFormatTimeEnd() {
        return formatTimeEnd;
    }

    public void setFormatTimeEnd(String formatTimeEnd) {
        this.formatTimeEnd = formatTimeEnd;
    }

    public String getFormatTimeStart() {
        return formatTimeStart;
    }

    public void setFormatTimeStart(String formatTimeStart) {
        this.formatTimeStart = formatTimeStart;
    }

    public String getFormatTime() {
        return formatTime;
    }

    public void setFormatTime(String formatTime) {
        this.formatTime = formatTime;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }

    public String getRequestFlagShow() {
        return requestFlagShow;
    }

    public void setRequestFlagShow(String requestFlagShow) {
        this.requestFlagShow = requestFlagShow;
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
    }

    public String getArchivesName() {
        return archivesName;
    }

    public void setArchivesName(String archivesName) {
        this.archivesName = archivesName;
    }

    public String getSchoolType() {
        return schoolType;
    }

    public void setSchoolType(String schoolType) {
        this.schoolType = schoolType;
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

    public String getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(String operateTime) {
        this.operateTime = operateTime;
    }

    public String getArchivesId() {
        return archivesId;
    }

    public void setArchivesId(String archivesId) {
        this.archivesId = archivesId;
    }

    public String getArchivesCode() {
        return archivesCode;
    }

    public void setArchivesCode(String archivesCode) {
        this.archivesCode = archivesCode;
    }

    public String getDeptCode() {
        return deptCode;
    }

    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }

    public String getYearCode() {
        return yearCode;
    }

    public void setYearCode(String yearCode) {
        this.yearCode = yearCode;
    }

    public String getSchoolCode() {
        return schoolCode;
    }

    public void setSchoolCode(String schoolCode) {
        this.schoolCode = schoolCode;
    }

    public String getOneLevel() {
        return oneLevel;
    }

    public void setOneLevel(String oneLevel) {
        this.oneLevel = oneLevel;
    }

    public String getTwoLevel() {
        return twoLevel;
    }

    public void setTwoLevel(String twoLevel) {
        this.twoLevel = twoLevel;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getEditedId() {
        return editedId;
    }

    public void setEditedId(String editedId) {
        this.editedId = editedId;
    }

    public String getOperateType() {
        return operateType;
    }

    public void setOperateType(String operateType) {
        this.operateType = operateType;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getDelState() {
        return delState;
    }

    public void setDelState(String delState) {
        this.delState = delState;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getLogId() {
        return logId;
    }

    public void setLogId(String logId) {
        this.logId = logId;
    }

    public String getRoleFlag() {
        return roleFlag;
    }

    public void setRoleFlag(String roleFlag) {
        this.roleFlag = roleFlag;
    }

    public String getFileNum() {
        return fileNum;
    }

    public void setFileNum(String fileNum) {
        this.fileNum = fileNum;
    }

    public String getRoleState() {
        return roleState;
    }

    public void setRoleState(String roleState) {
        this.roleState = roleState;
    }

    public String getRolePersonId() {
        return rolePersonId;
    }

    public void setRolePersonId(String rolePersonId) {
        this.rolePersonId = rolePersonId;
    }

    public String getRolePersonDept() {
        return rolePersonDept;
    }

    public void setRolePersonDept(String rolePersonDept) {
        this.rolePersonDept = rolePersonDept;
    }
}
