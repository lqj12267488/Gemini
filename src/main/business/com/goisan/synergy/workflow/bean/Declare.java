package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

public class Declare extends BaseBean {
    private String id;
    private String name;
    private String requester; //申请人
    private String requestDate;//申请日期
    private String requestDept;//申请部门
    private String sex; //性别
    private String nation; //民族，使用MZ字典
    private String birthday; //出生日期
    private String politicalStatus; //政治面貌，使用ZZMM字典
    private String idcard; //身份证号
    private String workTime; //工作时间
    private String workDept; //工作部门
    private String administrativePost; //行政职务
    private String technicalPosition;	//现任专业技术职务
    private String appointmentTime;//任职时间
    private String appliedLevel; //拟申报职称层次
    private String majorTime; //从事专业时间
    private String academicDegree;	//学位，使用XW字典
    private String educationalLevel; //学历，使用WHCD字典
    private String school; //毕业学校
    private String major;//专业
    private String entryTime;//入职时间
    private String graduateTime; //	毕业时间
    private String acquisitionTime; //职业资格证书类别及获取时间
    private String organizationsPositions; //参加学术团体及任职
    private String academicTechnology;	//学术技术荣誉称号
    private String continuingEducationTime; //继续教育证书获取时间
    private String postalAddress;//通讯地址
    private String postCode;//邮政编码
    private String officePhone;	//办公电话
    private String tel;	//手机
    private String email;	//电子信箱
    private String requestFlag;//请求状态，0未提交 1审核中 2已办理
    private String workingSeniority;//工作年限
    private String positionalTitles;//职称
    private String presentPost;//现任职务
    private String engageTime;	//聘任时间
    private String incumbentPost;	//现任岗位
    private String appointmentPost;	//聘任岗位
    private String representativeAchievements;//申报人代表性成果
    private String sexShow;
    private String nationShow;
    private String politicalStatusShow;
    private String academicDegreeShow;
    private String educationalLevelShow;
    private String feedBack;
    private String feedbackFlag;
    private String img;
    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(String entryTime) {
        this.entryTime = entryTime;
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


    public String getRepresentativeAchievements() {
        return representativeAchievements;
    }

    public void setRepresentativeAchievements(String representativeAchievements) {
        this.representativeAchievements = representativeAchievements;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }

    public String getNationShow() {
        return nationShow;
    }

    public void setNationShow(String nationShow) {
        this.nationShow = nationShow;
    }

    public String getPoliticalStatusShow() {
        return politicalStatusShow;
    }

    public void setPoliticalStatusShow(String politicalStatusShow) {
        this.politicalStatusShow = politicalStatusShow;
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

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getPoliticalStatus() {
        return politicalStatus;
    }

    public void setPoliticalStatus(String politicalStatus) {
        this.politicalStatus = politicalStatus;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getWorkTime() {
        return workTime;
    }

    public void setWorkTime(String workTime) {
        this.workTime = workTime;
    }

    public String getWorkDept() {
        return workDept;
    }

    public void setWorkDept(String workDept) {
        this.workDept = workDept;
    }

    public String getAdministrativePost() {
        return administrativePost;
    }

    public void setAdministrativePost(String administrativePost) {
        this.administrativePost = administrativePost;
    }

    public String getTechnicalPosition() {
        return technicalPosition;
    }

    public void setTechnicalPosition(String technicalPosition) {
        this.technicalPosition = technicalPosition;
    }

    public String getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(String appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getAppliedLevel() {
        return appliedLevel;
    }

    public void setAppliedLevel(String appliedLevel) {
        this.appliedLevel = appliedLevel;
    }

    public String getMajorTime() {
        return majorTime;
    }

    public void setMajorTime(String majorTime) {
        this.majorTime = majorTime;
    }

    public String getAcademicDegree() {
        return academicDegree;
    }

    public void setAcademicDegree(String academicDegree) {
        this.academicDegree = academicDegree;
    }

    public String getEducationalLevel() {
        return educationalLevel;
    }

    public void setEducationalLevel(String educationalLevel) {
        this.educationalLevel = educationalLevel;
    }

    public String getGraduateTime() {
        return graduateTime;
    }

    public void setGraduateTime(String graduateTime) {
        this.graduateTime = graduateTime;
    }

    public String getAcquisitionTime() {
        return acquisitionTime;
    }

    public void setAcquisitionTime(String acquisitionTime) {
        this.acquisitionTime = acquisitionTime;
    }

    public String getOrganizationsPositions() {
        return organizationsPositions;
    }

    public void setOrganizationsPositions(String organizationsPositions) {
        this.organizationsPositions = organizationsPositions;
    }

    public String getAcademicTechnology() {
        return academicTechnology;
    }

    public void setAcademicTechnology(String academicTechnology) {
        this.academicTechnology = academicTechnology;
    }

    public String getContinuingEducationTime() {
        return continuingEducationTime;
    }

    public void setContinuingEducationTime(String continuingEducationTime) {
        this.continuingEducationTime = continuingEducationTime;
    }

    public String getPostalAddress() {
        return postalAddress;
    }

    public void setPostalAddress(String postalAddress) {
        this.postalAddress = postalAddress;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getOfficePhone() {
        return officePhone;
    }

    public void setOfficePhone(String officePhone) {
        this.officePhone = officePhone;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getWorkingSeniority() {
        return workingSeniority;
    }

    public void setWorkingSeniority(String workingSeniority) {
        this.workingSeniority = workingSeniority;
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

    public String getAppointmentPost() {
        return appointmentPost;
    }

    public void setAppointmentPost(String appointmentPost) {
        this.appointmentPost = appointmentPost;
    }
}
