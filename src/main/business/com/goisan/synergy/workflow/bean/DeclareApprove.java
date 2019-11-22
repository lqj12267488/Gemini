package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

public class DeclareApprove extends BaseBean {
    private String id;
    private String declareId;//职称申报表id
    private String requester; //申请人
    private String requestDate;//申请日期
    private String requestDept;//申请部门
    private String name;//姓名
    private String sex; //性别
    private String birthday; //出生日期
    private String entryTime;//入职时间
    private String educationalLevel; //学历，使用WHCD字典
    private String workingSeniority;//工作年限
    private String school; //毕业学校
    private String academicDegree;	//学位，使用XW字典
    private String positionalTitles;//职称
    private String presentPost;//现任职务
    private String engageTime;	//聘任时间
    private String incumbentPost;	//现任岗位
    private String appointmentTime;//任职时间
    private String appointmentPost;	//聘任岗位
    private String sexShow;
    private String academicDegreeShow;
    private String educationalLevelShow;
    private String feedBack;
    private String feedbackFlag;
    private String requestFlag;//请求状态，0未提交 1审核中 2已办理
    private String appliedLevel;
    private String workDept;
    private String representativeAchievements;
    private String img;

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getRepresentativeAchievements() {
        return representativeAchievements;
    }

    public void setRepresentativeAchievements(String representativeAchievements) {
        this.representativeAchievements = representativeAchievements;
    }

    public String getWorkDept() {
        return workDept;
    }

    public void setWorkDept(String workDept) {
        this.workDept = workDept;
    }

    public String getAppliedLevel() {
        return appliedLevel;
    }

    public void setAppliedLevel(String appliedLevel) {
        this.appliedLevel = appliedLevel;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDeclareId() {
        return declareId;
    }

    public void setDeclareId(String declareId) {
        this.declareId = declareId;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(String entryTime) {
        this.entryTime = entryTime;
    }

    public String getEducationalLevel() {
        return educationalLevel;
    }

    public void setEducationalLevel(String educationalLevel) {
        this.educationalLevel = educationalLevel;
    }

    public String getWorkingSeniority() {
        return workingSeniority;
    }

    public void setWorkingSeniority(String workingSeniority) {
        this.workingSeniority = workingSeniority;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getAcademicDegree() {
        return academicDegree;
    }

    public void setAcademicDegree(String academicDegree) {
        this.academicDegree = academicDegree;
    }

    public String getPositionalTitles() {
        return positionalTitles;
    }

    public void setPositionalTitles(String positionalTitles) {
        this.positionalTitles = positionalTitles;
    }

    public String getPresentPost() {
        return presentPost;
    }

    public void setPresentPost(String presentPost) {
        this.presentPost = presentPost;
    }

    public String getEngageTime() {
        return engageTime;
    }

    public void setEngageTime(String engageTime) {
        this.engageTime = engageTime;
    }

    public String getIncumbentPost() {
        return incumbentPost;
    }

    public void setIncumbentPost(String incumbentPost) {
        this.incumbentPost = incumbentPost;
    }

    public String getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(String appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getAppointmentPost() {
        return appointmentPost;
    }

    public void setAppointmentPost(String appointmentPost) {
        this.appointmentPost = appointmentPost;
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }

    public String getAcademicDegreeShow() {
        return academicDegreeShow;
    }

    public void setAcademicDegreeShow(String academicDegreeShow) {
        this.academicDegreeShow = academicDegreeShow;
    }

    public String getEducationalLevelShow() {
        return educationalLevelShow;
    }

    public void setEducationalLevelShow(String educationalLevelShow) {
        this.educationalLevelShow = educationalLevelShow;
    }

    public String getFeedBack() {
        return feedBack;
    }

    public void setFeedBack(String feedBack) {
        this.feedBack = feedBack;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

}
