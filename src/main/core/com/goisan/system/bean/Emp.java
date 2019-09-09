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
    private String entryDateShow;
    private String graduateTimeShow;
    private String birthdayShow;
    private String classPositions;
    private String classPositionsShow;
    private String academicDegree;
    private String academicDegreeShow;
    private String img;
    private String nativePlaceProvinceShow;

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
}
