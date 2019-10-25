package com.goisan.system.bean;

import java.sql.Date;

/**
 * Created by Admin on 2017/4/20.
 */
public class Emp extends BaseBean {
    private String personId;
    private String name;
    private String idCard;
    private String sex;
    private Date birthday;
    private String nationality;
    private String address;
    private String nation;
    private String deptId;
    private String deptName;
    private Integer personOrder;
    private String tel;
    private String photoUrl;
    private String sexShow;
    private String nationShow;
    private String userAccount;
    private String nationalityShow;
    private String staffId;
    private String usedName;
    private String idType;
    private String idTypeShow;
    private String nativePlaceProvince;
    private String nativePlaceCity;
    private String nativePlaceCounty;
    private String birthPlace;
    private String politicalStatus;
    private String politicalStatusShow;
    private String maritalStatus;
    private String maritalStatusShow;
    private String healthStatus;
    private String healthStatusShow;
    private Date workTime;
    private Date toSchoolTime;
    private String staffSource;
    private String staffSourceShow;
    private String staffType;
    private String staffTypeShow;
    private String staffFlag;
    private String staffFlagShow;
    private String employeForm;
    private String employeFormShow;
    private String contractType;
    private String contractTypeShow;
    private String technicalSkills;
    private String technicalSkillsShow;
    private String doubleTypeFlag;
    private String doubleTypeFlagShow;
    private String credentialsFlag;
    private String credentialsFlagShow;
    private String stuntTeacherFlag;
    private String stuntTeacherFlagShow;
    private String workYear;
    private String workYearShow;
    private String staffStatus;
    private String staffStatusShow;
    private String staffBelongs;
    private String staffBelongsShow;
    private String education;
    private String educationShow;//小学、初中、高中（职高、中专）大专（高职）、本科、研究生
    private String jobShow;
    private String job;
    private String nativePlace;
    private Date entryDate;
    private String permanentResidence;
    private String permanentResidenceLocal;
    private String permanentResidenceLocalShow;
    private String levels;
    private String educationalLevel;
    private String educationalLevelShow;
    private String graduateSchool;
    private Date graduateTime;
    private String major;
    private String positionalTitles;
    private String positionalLevel;
    private String positionalLevelShow;
    private String post;
    private String examinePolitical;
    private String examinePoliticalShow;
    private String educationTechnique;
    private String remark;
    private String age;
    private String educationTechniqueShow;
    private String classPositions;
    private String classPositionsShow;
    private String academicDegree;
    private String academicDegreeShow;
    private String img;
    private String nativePlaceProvinceShow;
    private String birthdayShow;
    private String workTimeShow;
    private String toSchoolTimeShow;
    private String entryDateShow;
    private String graduateTimeShow;
    private String educationalResearch;//教科研成果
    private String GRADE;
    private String GIVENNAME;
    private String ISSUER;
    private String getDateShow;
    private String TEACHINGMANAGEMENT;
    private String STUDENTMANAGEMENT;
    private String POLITICALCOUNSELOR;
    private String PSYCHOLOGICALCONSULTANT;
    private String EMPLOYMENTOFFICE;
    private String WORKINGHOURS;
    private String EXPERTISE;
    /**岗位职能*/
    private String postfunction;

    /**本岗位工作年限*/
    private String workingyears;


    private String TOPICNATURE;
    private String SUBJECTCLASSIFICATION;
    private String SUBJECTNAME;
    private String HORIZONTALTOPIC;
    private String SUBJECTGRADE;
    private String PROJECTDATESHOW;
    private String SOURCEOFFUNDING;
    private String COMPLETORORDER;
    private String MONEY;
    private String NUM;
    private String HIGHESTGRADE;
    private String COOPERATION;

    public String getPostfunction() {
        return postfunction;
    }

    public void setPostfunction(String postfunction) {
        this.postfunction = postfunction;
    }

    public String getWorkingyears() {
        return workingyears;
    }

    public void setWorkingyears(String workingyears) {
        this.workingyears = workingyears;
    }

    public String getTOPICNATURE() {
        return TOPICNATURE;

    }

    public void setTOPICNATURE(String TOPICNATURE) {
        this.TOPICNATURE = TOPICNATURE;
    }

    public String getSUBJECTCLASSIFICATION() {
        return SUBJECTCLASSIFICATION;
    }

    public void setSUBJECTCLASSIFICATION(String SUBJECTCLASSIFICATION) {
        this.SUBJECTCLASSIFICATION = SUBJECTCLASSIFICATION;
    }

    public String getSUBJECTNAME() {
        return SUBJECTNAME;
    }

    public void setSUBJECTNAME(String SUBJECTNAME) {
        this.SUBJECTNAME = SUBJECTNAME;
    }

    public String getHORIZONTALTOPIC() {
        return HORIZONTALTOPIC;
    }

    public void setHORIZONTALTOPIC(String HORIZONTALTOPIC) {
        this.HORIZONTALTOPIC = HORIZONTALTOPIC;
    }

    public String getSUBJECTGRADE() {
        return SUBJECTGRADE;
    }

    public void setSUBJECTGRADE(String SUBJECTGRADE) {
        this.SUBJECTGRADE = SUBJECTGRADE;
    }

    public String getPROJECTDATESHOW() {
        return PROJECTDATESHOW;
    }

    public void setPROJECTDATESHOW(String PROJECTDATESHOW) {
        this.PROJECTDATESHOW = PROJECTDATESHOW;
    }

    public String getSOURCEOFFUNDING() {
        return SOURCEOFFUNDING;
    }

    public void setSOURCEOFFUNDING(String SOURCEOFFUNDING) {
        this.SOURCEOFFUNDING = SOURCEOFFUNDING;
    }

    public String getCOMPLETORORDER() {
        return COMPLETORORDER;
    }

    public void setCOMPLETORORDER(String COMPLETORORDER) {
        this.COMPLETORORDER = COMPLETORORDER;
    }

    public String getMONEY() {
        return MONEY;
    }

    public void setMONEY(String MONEY) {
        this.MONEY = MONEY;
    }

    public String getNUM() {
        return NUM;
    }

    public void setNUM(String NUM) {
        this.NUM = NUM;
    }

    public String getHIGHESTGRADE() {
        return HIGHESTGRADE;
    }

    public void setHIGHESTGRADE(String HIGHESTGRADE) {
        this.HIGHESTGRADE = HIGHESTGRADE;
    }

    public String getCOOPERATION() {
        return COOPERATION;
    }

    public void setCOOPERATION(String COOPERATION) {
        this.COOPERATION = COOPERATION;
    }

    public String getWORKINGHOURS() {
        return WORKINGHOURS;
    }

    public void setWORKINGHOURS(String WORKINGHOURS) {
        this.WORKINGHOURS = WORKINGHOURS;
    }

    public String getEXPERTISE() {
        return EXPERTISE;
    }

    public void setEXPERTISE(String EXPERTISE) {
        this.EXPERTISE = EXPERTISE;
    }

    public String getEMPLOYMENTOFFICE() {
        return EMPLOYMENTOFFICE;
    }

    public void setEMPLOYMENTOFFICE(String EMPLOYMENTOFFICE) {
        this.EMPLOYMENTOFFICE = EMPLOYMENTOFFICE;
    }

    public String getSTUDENTMANAGEMENT() {
        return STUDENTMANAGEMENT;
    }

    public void setSTUDENTMANAGEMENT(String STUDENTMANAGEMENT) {
        this.STUDENTMANAGEMENT = STUDENTMANAGEMENT;
    }

    public String getPOLITICALCOUNSELOR() {
        return POLITICALCOUNSELOR;
    }

    public void setPOLITICALCOUNSELOR(String POLITICALCOUNSELOR) {
        this.POLITICALCOUNSELOR = POLITICALCOUNSELOR;
    }

    public String getPSYCHOLOGICALCONSULTANT() {
        return PSYCHOLOGICALCONSULTANT;
    }

    public void setPSYCHOLOGICALCONSULTANT(String PSYCHOLOGICALCONSULTANT) {
        this.PSYCHOLOGICALCONSULTANT = PSYCHOLOGICALCONSULTANT;
    }

    public String getTEACHINGMANAGEMENT() {
        return TEACHINGMANAGEMENT;
    }

    public void setTEACHINGMANAGEMENT(String TEACHINGMANAGEMENT) {
        this.TEACHINGMANAGEMENT = TEACHINGMANAGEMENT;
    }

    public String getGRADE() {
        return GRADE;
    }

    public void setGRADE(String GRADE) {
        this.GRADE = GRADE;
    }

    public String getGIVENNAME() {
        return GIVENNAME;
    }

    public void setGIVENNAME(String GIVENNAME) {
        this.GIVENNAME = GIVENNAME;
    }

    public String getISSUER() {
        return ISSUER;
    }

    public void setISSUER(String ISSUER) {
        this.ISSUER = ISSUER;
    }

    public String getGetDateShow() {
        return getDateShow;
    }

    public void setGetDateShow(String getDateShow) {
        this.getDateShow = getDateShow;
    }

    private String filenumber;
    private String deadline;



    /**开始时间*/
    private String syStartTime;

    /**截止时间*/
    private String syEndTime;

    /**合同期限*/
    private String syContractPeriod;

    private String firstStartTime;

    private String firstEndTime;

    private String firstContractPeriod;

    private String secStartTime;

    private String secEndTime;

    private String secContractPeriod;

    private String thirdStartTime;

    private String thirdEndTime;

    private String thirdContractPeriod;

    private String jzStartTime;

    private String jzEndTime;

    private String jzContractPeriod;

    /**转正日期*/
    private String positiveTime;

    /**人员性质{ryxz}*/
    private String personNature;

    private String personNatureShow;

    /**退休证明*/
    private String retireCert;

    /**份数*/
    private String nums;

    /**校龄*/
    private String schoolAge;

    /**保密协议*/
    private String confidentAgreement;

    /**试用期工资*/
    private String trpidSalary;

    /**转正工资*/
    private String positiveSalary;

    /**转正系数*/
    private String positiveCoff;

    /**离职日期*/
    private String retireTime;

    /**是否退休*/
    private String retireNy;

    /**社保号*/
    private String ssnumber;

    /**数量*/
    private String counts;

    /**预到期*/
    private String fature;



    /**银行卡号id*/
    private String bankId;

    /**一寸照有无{	yw}*/
    private String phoneShow;

    /**身份证复印件有无{	yw}*/

    private String idcardCopyShow;

    /**身份证期限*/
    private String idcardEndtime;

    /**户口有无{	yw}*/
    private String account;

    private String accountShow;

    /**毕业证有无{	yw}*/

    private String diplomaShow;

    /**学位证有无{	yw}*/
    private String degreeCert;

    private String degreeCertShow;

    /**解除劳动合同有无{yw}*/

    private String disContractShow;

    /**计算机{yw}*/
    private String computer;

    private String computerShow;

    /**英语{yw}*/
    private String english;

    private String englishShow;

    /**普通话{yw}*/
    private String putonghuaShow;

    /**国语水平{yw}*/
    private String pthLevelShow;

    /**教师资格证{yw}*/
    private String teachCertShow;

    /**其他资格证{yw}*/

    private String otherCertShow;

    /**驾驶证{yw}*/
    private String driverCertShow;

    /**电工证{yw}*/

    private String eleCertShow;


    private String retireCertShow;


    private String retireProveShow;

    private String extSsCertShow;

    private String personFileShow;

    private String otherInfoShow;

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
    }

    public String getPhoneShow() {
        return phoneShow;
    }

    public void setPhoneShow(String phoneShow) {
        this.phoneShow = phoneShow;
    }

    public String getIdcardCopyShow() {
        return idcardCopyShow;
    }

    public void setIdcardCopyShow(String idcardCopyShow) {
        this.idcardCopyShow = idcardCopyShow;
    }

    public String getIdcardEndtime() {
        return idcardEndtime;
    }

    public void setIdcardEndtime(String idcardEndtime) {
        this.idcardEndtime = idcardEndtime;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getAccountShow() {
        return accountShow;
    }

    public void setAccountShow(String accountShow) {
        this.accountShow = accountShow;
    }

    public String getDiplomaShow() {
        return diplomaShow;
    }

    public void setDiplomaShow(String diplomaShow) {
        this.diplomaShow = diplomaShow;
    }

    public String getDegreeCert() {
        return degreeCert;
    }

    public void setDegreeCert(String degreeCert) {
        this.degreeCert = degreeCert;
    }

    public String getDegreeCertShow() {
        return degreeCertShow;
    }

    public void setDegreeCertShow(String degreeCertShow) {
        this.degreeCertShow = degreeCertShow;
    }

    public String getDisContractShow() {
        return disContractShow;
    }

    public void setDisContractShow(String disContractShow) {
        this.disContractShow = disContractShow;
    }

    public String getComputer() {
        return computer;
    }

    public void setComputer(String computer) {
        this.computer = computer;
    }

    public String getComputerShow() {
        return computerShow;
    }

    public void setComputerShow(String computerShow) {
        this.computerShow = computerShow;
    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getEnglishShow() {
        return englishShow;
    }

    public void setEnglishShow(String englishShow) {
        this.englishShow = englishShow;
    }

    public String getPutonghuaShow() {
        return putonghuaShow;
    }

    public void setPutonghuaShow(String putonghuaShow) {
        this.putonghuaShow = putonghuaShow;
    }

    public String getPthLevelShow() {
        return pthLevelShow;
    }

    public void setPthLevelShow(String pthLevelShow) {
        this.pthLevelShow = pthLevelShow;
    }

    public String getTeachCertShow() {
        return teachCertShow;
    }

    public void setTeachCertShow(String teachCertShow) {
        this.teachCertShow = teachCertShow;
    }

    public String getOtherCertShow() {
        return otherCertShow;
    }

    public void setOtherCertShow(String otherCertShow) {
        this.otherCertShow = otherCertShow;
    }

    public String getDriverCertShow() {
        return driverCertShow;
    }

    public void setDriverCertShow(String driverCertShow) {
        this.driverCertShow = driverCertShow;
    }

    public String getEleCertShow() {
        return eleCertShow;
    }

    public void setEleCertShow(String eleCertShow) {
        this.eleCertShow = eleCertShow;
    }

    public String getRetireCertShow() {
        return retireCertShow;
    }

    public void setRetireCertShow(String retireCertShow) {
        this.retireCertShow = retireCertShow;
    }

    public String getRetireProveShow() {
        return retireProveShow;
    }

    public void setRetireProveShow(String retireProveShow) {
        this.retireProveShow = retireProveShow;
    }

    public String getExtSsCertShow() {
        return extSsCertShow;
    }

    public void setExtSsCertShow(String extSsCertShow) {
        this.extSsCertShow = extSsCertShow;
    }

    public String getPersonFileShow() {
        return personFileShow;
    }

    public void setPersonFileShow(String personFileShow) {
        this.personFileShow = personFileShow;
    }

    public String getOtherInfoShow() {
        return otherInfoShow;
    }

    public void setOtherInfoShow(String otherInfoShow) {
        this.otherInfoShow = otherInfoShow;
    }

    public String getSyStartTime() {
        return syStartTime;
    }

    public void setSyStartTime(String syStartTime) {
        this.syStartTime = syStartTime;
    }

    public String getSyEndTime() {
        return syEndTime;
    }

    public void setSyEndTime(String syEndTime) {
        this.syEndTime = syEndTime;
    }

    public String getSyContractPeriod() {
        return syContractPeriod;
    }

    public void setSyContractPeriod(String syContractPeriod) {
        this.syContractPeriod = syContractPeriod;
    }

    public String getFirstStartTime() {
        return firstStartTime;
    }

    public void setFirstStartTime(String firstStartTime) {
        this.firstStartTime = firstStartTime;
    }

    public String getFirstEndTime() {
        return firstEndTime;
    }

    public void setFirstEndTime(String firstEndTime) {
        this.firstEndTime = firstEndTime;
    }

    public String getFirstContractPeriod() {
        return firstContractPeriod;
    }

    public void setFirstContractPeriod(String firstContractPeriod) {
        this.firstContractPeriod = firstContractPeriod;
    }

    public String getSecStartTime() {
        return secStartTime;
    }

    public void setSecStartTime(String secStartTime) {
        this.secStartTime = secStartTime;
    }

    public String getSecEndTime() {
        return secEndTime;
    }

    public void setSecEndTime(String secEndTime) {
        this.secEndTime = secEndTime;
    }

    public String getSecContractPeriod() {
        return secContractPeriod;
    }

    public void setSecContractPeriod(String secContractPeriod) {
        this.secContractPeriod = secContractPeriod;
    }

    public String getThirdStartTime() {
        return thirdStartTime;
    }

    public void setThirdStartTime(String thirdStartTime) {
        this.thirdStartTime = thirdStartTime;
    }

    public String getThirdEndTime() {
        return thirdEndTime;
    }

    public void setThirdEndTime(String thirdEndTime) {
        this.thirdEndTime = thirdEndTime;
    }

    public String getThirdContractPeriod() {
        return thirdContractPeriod;
    }

    public void setThirdContractPeriod(String thirdContractPeriod) {
        this.thirdContractPeriod = thirdContractPeriod;
    }

    public String getJzStartTime() {
        return jzStartTime;
    }

    public void setJzStartTime(String jzStartTime) {
        this.jzStartTime = jzStartTime;
    }

    public String getJzEndTime() {
        return jzEndTime;
    }

    public void setJzEndTime(String jzEndTime) {
        this.jzEndTime = jzEndTime;
    }

    public String getJzContractPeriod() {
        return jzContractPeriod;
    }

    public void setJzContractPeriod(String jzContractPeriod) {
        this.jzContractPeriod = jzContractPeriod;
    }

    public String getPositiveTime() {
        return positiveTime;
    }

    public void setPositiveTime(String positiveTime) {
        this.positiveTime = positiveTime;
    }

    public String getPersonNature() {
        return personNature;
    }

    public void setPersonNature(String personNature) {
        this.personNature = personNature;
    }

    public String getPersonNatureShow() {
        return personNatureShow;
    }

    public void setPersonNatureShow(String personNatureShow) {
        this.personNatureShow = personNatureShow;
    }

    public String getRetireCert() {
        return retireCert;
    }

    public void setRetireCert(String retireCert) {
        this.retireCert = retireCert;
    }

    public String getNums() {
        return nums;
    }

    public void setNums(String nums) {
        this.nums = nums;
    }

    public String getSchoolAge() {
        return schoolAge;
    }

    public void setSchoolAge(String schoolAge) {
        this.schoolAge = schoolAge;
    }

    public String getConfidentAgreement() {
        return confidentAgreement;
    }

    public void setConfidentAgreement(String confidentAgreement) {
        this.confidentAgreement = confidentAgreement;
    }

    public String getTrpidSalary() {
        return trpidSalary;
    }

    public void setTrpidSalary(String trpidSalary) {
        this.trpidSalary = trpidSalary;
    }

    public String getPositiveSalary() {
        return positiveSalary;
    }

    public void setPositiveSalary(String positiveSalary) {
        this.positiveSalary = positiveSalary;
    }

    public String getPositiveCoff() {
        return positiveCoff;
    }

    public void setPositiveCoff(String positiveCoff) {
        this.positiveCoff = positiveCoff;
    }

    public String getRetireTime() {
        return retireTime;
    }

    public void setRetireTime(String retireTime) {
        this.retireTime = retireTime;
    }

    public String getRetireNy() {
        return retireNy;
    }

    public void setRetireNy(String retireNy) {
        this.retireNy = retireNy;
    }

    public String getSsnumber() {
        return ssnumber;
    }

    public void setSsnumber(String ssnumber) {
        this.ssnumber = ssnumber;
    }

    public String getCounts() {
        return counts;
    }

    public void setCounts(String counts) {
        this.counts = counts;
    }

    public String getFature() {
        return fature;
    }

    public void setFature(String fature) {
        this.fature = fature;
    }

    public String getFilenumber() {
        return filenumber;
    }

    public void setFilenumber(String filenumber) {
        this.filenumber = filenumber;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    public String getWorkTimeShow() {
        return workTimeShow;
    }

    public void setWorkTimeShow(String workTimeShow) {
        this.workTimeShow = workTimeShow;
    }

    public String getToSchoolTimeShow() {
        return toSchoolTimeShow;
    }

    public void setToSchoolTimeShow(String toSchoolTimeShow) {
        this.toSchoolTimeShow = toSchoolTimeShow;
    }

    public String getNativePlaceProvinceShow() {
        return nativePlaceProvinceShow;
    }

    public void setNativePlaceProvinceShow(String nativePlaceProvinceShow) {
        this.nativePlaceProvinceShow = nativePlaceProvinceShow;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }


    public String getPermanentResidenceLocalShow() {
        return permanentResidenceLocalShow;
    }

    public void setPermanentResidenceLocalShow(String permanentResidenceLocalShow) {
        this.permanentResidenceLocalShow = permanentResidenceLocalShow;
    }

    public String getAcademicDegree() {
        return academicDegree;
    }

    public void setAcademicDegree(String academicDegree) {
        this.academicDegree = academicDegree;
    }

    public String getAcademicDegreeShow() {
        return academicDegreeShow;
    }

    public void setAcademicDegreeShow(String academicDegreeShow) {
        this.academicDegreeShow = academicDegreeShow;
    }


    public String getPositionalLevelShow() {
        return positionalLevelShow;
    }

    public void setPositionalLevelShow(String positionalLevelShow) {
        this.positionalLevelShow = positionalLevelShow;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getClassPositions() {
        return classPositions;
    }

    public void setClassPositions(String classPositions) {
        this.classPositions = classPositions;
    }

    public String getClassPositionsShow() {
        return classPositionsShow;
    }

    public void setClassPositionsShow(String classPositionsShow) {
        this.classPositionsShow = classPositionsShow;
    }


    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getEducationTechniqueShow() {
        return educationTechniqueShow;
    }

    public void setEducationTechniqueShow(String educationTechniqueShow) {
        this.educationTechniqueShow = educationTechniqueShow;
    }
    public String getEducationalLevelShow() {
        return educationalLevelShow;
    }

    public void setEducationalLevelShow(String educationalLevelShow) {
        this.educationalLevelShow = educationalLevelShow;
    }

    public String getExaminePoliticalShow() {
        return examinePoliticalShow;
    }

    public void setExaminePoliticalShow(String examinePoliticalShow) {
        this.examinePoliticalShow = examinePoliticalShow;
    }

    public Date getEntryDate() {
        return entryDate;
    }

    public void setEntryDate(Date entryDate) {
        this.entryDate = entryDate;
    }

    public Date getGraduateTime() {
        return graduateTime;
    }

    public void setGraduateTime(Date graduateTime) {
        this.graduateTime = graduateTime;
    }

    public String getEducationTechnique() {
        return educationTechnique;
    }

    public void setEducationTechnique(String educationTechnique) {
        this.educationTechnique = educationTechnique;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getExaminePolitical() {
        return examinePolitical;
    }

    public void setExaminePolitical(String examinePolitical) {
        this.examinePolitical = examinePolitical;
    }

    public String getPositionalTitles() {
        return positionalTitles;
    }

    public void setPositionalTitles(String positionalTitles) {
        this.positionalTitles = positionalTitles;
    }

    public String getPositionalLevel() {
        return positionalLevel;
    }

    public void setPositionalLevel(String positionalLevel) {
        this.positionalLevel = positionalLevel;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getEducationalLevel() {
        return educationalLevel;
    }

    public void setEducationalLevel(String educationalLevel) {
        this.educationalLevel = educationalLevel;
    }

    public String getGraduateSchool() {
        return graduateSchool;
    }

    public void setGraduateSchool(String graduateSchool) {
        this.graduateSchool = graduateSchool;
    }

    public String getLevels() {
        return levels;
    }

    public void setLevels(String levels) {
        this.levels = levels;
    }
    public String getPermanentResidenceLocal() {
        return permanentResidenceLocal;
    }

    public void setPermanentResidenceLocal(String permanentResidenceLocal) {
        this.permanentResidenceLocal = permanentResidenceLocal;
    }
    public String getPermanentResidence() {
        return permanentResidence;
    }

    public void setPermanentResidence(String permanentResidence) {
        this.permanentResidence = permanentResidence;
    }

    public String getNativePlace() {
        return nativePlace;
    }

    public void setNativePlace(String nativePlace) {
        this.nativePlace = nativePlace;
    }
    public String getJobShow() {
        return jobShow;
    }

    public void setJobShow(String jobShow) {
        this.jobShow = jobShow;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(String userAccount) {
        this.userAccount = userAccount;
    }

    public String getNationalityShow() {
        return nationalityShow;
    }

    public void setNationalityShow(String nationalityShow) {
        this.nationalityShow = nationalityShow;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getUsedName() {
        return usedName;
    }

    public void setUsedName(String usedName) {
        this.usedName = usedName;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getIdTypeShow() {
        return idTypeShow;
    }

    public void setIdTypeShow(String idTypeShow) {
        this.idTypeShow = idTypeShow;
    }

    public String getNativePlaceProvince() {
        return nativePlaceProvince;
    }

    public void setNativePlaceProvince(String nativePlaceProvince) {
        this.nativePlaceProvince = nativePlaceProvince;
    }

    public String getNativePlaceCity() {
        return nativePlaceCity;
    }

    public void setNativePlaceCity(String nativePlaceCity) {
        this.nativePlaceCity = nativePlaceCity;
    }

    public String getNativePlaceCounty() {
        return nativePlaceCounty;
    }

    public void setNativePlaceCounty(String nativePlaceCounty) {
        this.nativePlaceCounty = nativePlaceCounty;
    }

    public String getBirthPlace() {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
    }

    public String getPoliticalStatus() {
        return politicalStatus;
    }

    public void setPoliticalStatus(String politicalStatus) {
        this.politicalStatus = politicalStatus;
    }

    public String getPoliticalStatusShow() {
        return politicalStatusShow;
    }

    public void setPoliticalStatusShow(String politicalStatusShow) {
        this.politicalStatusShow = politicalStatusShow;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public String getMaritalStatusShow() {
        return maritalStatusShow;
    }

    public void setMaritalStatusShow(String maritalStatusShow) {
        this.maritalStatusShow = maritalStatusShow;
    }

    public String getHealthStatus() {
        return healthStatus;
    }

    public void setHealthStatus(String healthStatus) {
        this.healthStatus = healthStatus;
    }

    public String getHealthStatusShow() {
        return healthStatusShow;
    }

    public void setHealthStatusShow(String healthStatusShow) {
        this.healthStatusShow = healthStatusShow;
    }

    public Date getWorkTime() {
        return workTime;
    }

    public void setWorkTime(Date workTime) {
        this.workTime = workTime;
    }

    public Date getToSchoolTime() {
        return toSchoolTime;
    }

    public void setToSchoolTime(Date toSchoolTime) {
        this.toSchoolTime = toSchoolTime;
    }

    public String getStaffSource() {
        return staffSource;
    }

    public void setStaffSource(String staffSource) {
        this.staffSource = staffSource;
    }

    public String getStaffSourceShow() {
        return staffSourceShow;
    }

    public void setStaffSourceShow(String staffSourceShow) {
        this.staffSourceShow = staffSourceShow;
    }

    public String getStaffType() {
        return staffType;
    }

    public void setStaffType(String staffType) {
        this.staffType = staffType;
    }

    public String getStaffTypeShow() {
        return staffTypeShow;
    }

    public void setStaffTypeShow(String staffTypeShow) {
        this.staffTypeShow = staffTypeShow;
    }

    public String getStaffFlag() {
        return staffFlag;
    }

    public void setStaffFlag(String staffFlag) {
        this.staffFlag = staffFlag;
    }

    public String getStaffFlagShow() {
        return staffFlagShow;
    }

    public void setStaffFlagShow(String staffFlagShow) {
        this.staffFlagShow = staffFlagShow;
    }

    public String getEmployeForm() {
        return employeForm;
    }

    public void setEmployeForm(String employeForm) {
        this.employeForm = employeForm;
    }

    public String getEmployeFormShow() {
        return employeFormShow;
    }

    public void setEmployeFormShow(String employeFormShow) {
        this.employeFormShow = employeFormShow;
    }

    public String getContractType() {
        return contractType;
    }

    public void setContractType(String contractType) {
        this.contractType = contractType;
    }

    public String getContractTypeShow() {
        return contractTypeShow;
    }

    public void setContractTypeShow(String contractTypeShow) {
        this.contractTypeShow = contractTypeShow;
    }

    public String getTechnicalSkills() {
        return technicalSkills;
    }

    public void setTechnicalSkills(String technicalSkills) {
        this.technicalSkills = technicalSkills;
    }

    public String getTechnicalSkillsShow() {
        return technicalSkillsShow;
    }

    public void setTechnicalSkillsShow(String technicalSkillsShow) {
        this.technicalSkillsShow = technicalSkillsShow;
    }

    public String getDoubleTypeFlag() {
        return doubleTypeFlag;
    }

    public void setDoubleTypeFlag(String doubleTypeFlag) {
        this.doubleTypeFlag = doubleTypeFlag;
    }

    public String getDoubleTypeFlagShow() {
        return doubleTypeFlagShow;
    }

    public void setDoubleTypeFlagShow(String doubleTypeFlagShow) {
        this.doubleTypeFlagShow = doubleTypeFlagShow;
    }

    public String getCredentialsFlag() {
        return credentialsFlag;
    }

    public void setCredentialsFlag(String credentialsFlag) {
        this.credentialsFlag = credentialsFlag;
    }

    public String getCredentialsFlagShow() {
        return credentialsFlagShow;
    }

    public void setCredentialsFlagShow(String credentialsFlagShow) {
        this.credentialsFlagShow = credentialsFlagShow;
    }

    public String getStuntTeacherFlag() {
        return stuntTeacherFlag;
    }

    public void setStuntTeacherFlag(String stuntTeacherFlag) {
        this.stuntTeacherFlag = stuntTeacherFlag;
    }

    public String getStuntTeacherFlagShow() {
        return stuntTeacherFlagShow;
    }

    public void setStuntTeacherFlagShow(String stuntTeacherFlagShow) {
        this.stuntTeacherFlagShow = stuntTeacherFlagShow;
    }

    public String getWorkYear() {
        return workYear;
    }

    public void setWorkYear(String workYear) {
        this.workYear = workYear;
    }

    public String getWorkYearShow() {
        return workYearShow;
    }

    public void setWorkYearShow(String workYearShow) {
        this.workYearShow = workYearShow;
    }

    public String getStaffStatus() {
        return staffStatus;
    }

    public void setStaffStatus(String staffStatus) {
        this.staffStatus = staffStatus;
    }

    public String getStaffStatusShow() {
        return staffStatusShow;
    }

    public void setStaffStatusShow(String staffStatusShow) {
        this.staffStatusShow = staffStatusShow;
    }

    public String getStaffBelongs() {
        return staffBelongs;
    }

    public void setStaffBelongs(String staffBelongs) {
        this.staffBelongs = staffBelongs;
    }

    public String getStaffBelongsShow() {
        return staffBelongsShow;
    }

    public void setStaffBelongsShow(String staffBelongsShow) {
        this.staffBelongsShow = staffBelongsShow;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
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

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

/*    public byte[] getPhoto() {
        return photo;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }*/

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

    public Integer getPersonOrder() {
        return personOrder;
    }

    public void setPersonOrder(Integer personOrder) {
        this.personOrder = personOrder;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
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

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getEducationShow() {
        return educationShow;
    }

    public void setEducationShow(String educationShow) {
        this.educationShow = educationShow;
    }

    public String getEntryDateShow() {
        return entryDateShow;
    }

    public void setEntryDateShow(String entryDateShow) {
        this.entryDateShow = entryDateShow;
    }

    public String getGraduateTimeShow() {
        return graduateTimeShow;
    }

    public void setGraduateTimeShow(String graduateTimeShow) {
        this.graduateTimeShow = graduateTimeShow;
    }

    public String getBirthdayShow() {
        return birthdayShow;
    }

    public void setBirthdayShow(String birthdayShow) {
        this.birthdayShow = birthdayShow;
    }

    public String getEducationalResearch() {
        return educationalResearch;
    }

    public void setEducationalResearch(String educationalResearch) {
        this.educationalResearch = educationalResearch;
    }
}
