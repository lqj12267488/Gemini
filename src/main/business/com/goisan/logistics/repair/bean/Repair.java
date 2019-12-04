package com.goisan.logistics.repair.bean;

import com.goisan.system.bean.BaseBean;

import java.util.Date;
import java.util.List;

public class Repair  extends BaseBean {
    private String id;
    private String name;//报修人
    private String repairID;
    private String repairType;//报修种类
    private String assetsID;  //资产编号
    private String position;  //所在位置
    private String dept;      //所在部门
    private String itemName;  //报修物品名称
    private String repairAddress;//维修地址
    private String faultDescription;//故障描述
    private String contactNumber;//联系人电话
    private String repairmanID;  //维修员ID
    private String repairmanPersonID;//维修员人员ID
    private String repairmanDeptID;//维修员部门ID
    private String repairResult;//维修结果说明
    private String requestFlag;//请求状态，使用WXLCZT字典，0未提交、1维修分配中、2维修中、3维修完成
    private String requestFlagShow;
    private String feedback;   //反馈意见
    private String feedbackFlag;//反馈状态，使用GZLFKZT字典
    private String checker;    //回检员ID
    private String checkerDept;//回检员部门ID
    private String checkFlag;  //回检状态，使用WXHJZT字典，0未回检，1回检中，2回检完成
    private String checkResult;//回检结果
    private String repairTypeShow;
    private String itemNameShow;
    private String personName;
    private String deptName;
    private String repairNum;
    private String personId;
    private String deptId;
    private String suppliesFlag;
    private String suppliesName;
    private String content;
    private String peopleFlag;
    private String submitTime;//提交时间
    private String assignTime;//分配时间
    private String confirmTime;//维修完成时间
    private String feedbackTime;//反馈时间
    private String checkTime;//回捡完成时间
    private String startDate;//查询开始时间
    private String endDate;//查询结束时间
    private String changeStartTime;
    private String changeEndTime;
    private String sysName; //派单人
    private String PersonIdShow; //维修人
    private String creatorName;
    private String url;//附件url
    private List<String> urlList;
    private Date confirmTime1 ;

    public List<String> getUrlList() {
        return urlList;
    }

    public void setUrlList(List<String> urlList) {
        this.urlList = urlList;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    private String repairmanShow;

    public String getRepairmanShow() {
        return repairmanShow;
    }

    public void setRepairmanShow(String repairmanShow) {
        this.repairmanShow = repairmanShow;
    }

    public Date getConfirmTime1() {
        return confirmTime1;
    }

    public void setConfirmTime1(Date confirmTime1) {
        this.confirmTime1 = confirmTime1;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    public String getPersonIdShow() {
        return PersonIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        PersonIdShow = personIdShow;
    }
    public String getSysName() {
        return sysName;
    }

    public void setSysName(String sysName) {
        this.sysName = sysName;
    }
    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    public String getAssignTime() {
        return assignTime;
    }

    public void setAssignTime(String assignTime) {
        this.assignTime = assignTime;
    }

    public String getConfirmTime() {
        return confirmTime;
    }

    public void setConfirmTime(String confirmTime) {
        this.confirmTime = confirmTime;
    }
    public String getRepairID() {
        return repairID;
    }

    public void setRepairID(String repairID) {
        this.repairID = repairID;
    }

    public String getRepairType() {
        return repairType;
    }

    public void setRepairType(String repairType) {
        this.repairType = repairType;
    }

    public String getAssetsID() {
        return assetsID;
    }

    public void setAssetsID(String assetsID) {
        this.assetsID = assetsID;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getRepairAddress() {
        return repairAddress;
    }

    public void setRepairAddress(String repairAddress) {
        this.repairAddress = repairAddress;
    }

    public String getFaultDescription() {
        return faultDescription;
    }

    public void setFaultDescription(String faultDescription) {
        this.faultDescription = faultDescription;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getRepairmanID() {
        return repairmanID;
    }

    public void setRepairmanID(String repairmanID) {
        this.repairmanID = repairmanID;
    }

    public String getRepairmanPersonID() {
        return repairmanPersonID;
    }

    public void setRepairmanPersonID(String repairmanPersonID) {
        this.repairmanPersonID = repairmanPersonID;
    }

    public String getRepairmanDeptID() {
        return repairmanDeptID;
    }

    public void setRepairmanDeptID(String repairmanDeptID) {
        this.repairmanDeptID = repairmanDeptID;
    }

    public String getRepairResult() {
        return repairResult;
    }

    public void setRepairResult(String repairResult) {
        this.repairResult = repairResult;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }

    public String getChecker() {
        return checker;
    }

    public void setChecker(String checker) {
        this.checker = checker;
    }

    public String getCheckerDept() {
        return checkerDept;
    }

    public void setCheckerDept(String checkerDept) {
        this.checkerDept = checkerDept;
    }

    public String getCheckFlag() {
        return checkFlag;
    }

    public void setCheckFlag(String checkFlag) {
        this.checkFlag = checkFlag;
    }

    public String getRepairTypeShow() {
        return repairTypeShow;
    }

    public void setRepairTypeShow(String repairTypeShow) {
        this.repairTypeShow = repairTypeShow;
    }

    public String getItemNameShow() {
        return itemNameShow;
    }

    public void setItemNameShow(String itemNameShow) {
        this.itemNameShow = itemNameShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personID) {
        this.personName = personID;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptID) {
        this.deptName = deptID;
    }

    public String getRepairNum() {
        return repairNum;
    }

    public void setRepairNum(String repairNum) {
        this.repairNum = repairNum;
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

    public String getSuppliesFlag() {
        return suppliesFlag;
    }

    public void setSuppliesFlag(String suppliesFlag) {
        this.suppliesFlag = suppliesFlag;
    }

    public String getSuppliesName() {
        return suppliesName;
    }

    public void setSuppliesName(String suppliesName) {
        this.suppliesName = suppliesName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPeopleFlag() {
        return peopleFlag;
    }

    public void setPeopleFlag(String peopleFlag) {
        this.peopleFlag = peopleFlag;
    }

    public String getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(String submitTime) {
        this.submitTime = submitTime;
    }

    public String getFeedbackTime() {
        return feedbackTime;
    }

    public void setFeedbackTime(String feedbackTime) {
        this.feedbackTime = feedbackTime;
    }

    public String getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(String checkTime) {
        this.checkTime = checkTime;
    }

    public String getChangeStartTime() {
        return changeStartTime;
    }

    public void setChangeStartTime(String changeStartTime) {
        this.changeStartTime = changeStartTime;
    }

    public String getChangeEndTime() {
        return changeEndTime;
    }

    public void setChangeEndTime(String changeEndTime) {
        this.changeEndTime = changeEndTime;
    }

    public String getRequestFlagShow() {
        return requestFlagShow;
    }

    public void setRequestFlagShow(String requestFlagShow) {
        this.requestFlagShow = requestFlagShow;
    }
}
