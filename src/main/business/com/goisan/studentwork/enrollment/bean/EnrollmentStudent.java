package com.goisan.studentwork.enrollment.bean;

import com.goisan.system.bean.BaseBean;

import java.sql.Date;

/**
 * Created by mcq on 2017/9/11.
 */
public class EnrollmentStudent extends BaseBean {
    private String studentId;
    private String name;
    private String sex;
    private String idcard;
    private String userAccount;
    private String studentNumber;
    private Date birthday;
    private String nationality;
    private String nation;
    private String address;
    private String housePlace;
    private String houseProvince;
    private String houseCity;
    private String houseCounty;
    private String provinceShow;
    private String cityShow;
    private String countyShow;
    private String politicalStatus;
    private String homePhone;
    private String tel;
    private String photo;
    private String sexShow;
    private String nationalityShow;
    private String nationShow;
    private String classId;
    private String classShow;
    private String studentStatus;
    private String majorShow;
    private String departmentShow;
    private String departmentsId;
    private String majorCode;
    private String trainingLevel;
    private String dormFlag;
    private String joinYear;
    private String joinMonth;
    private String cutFlag;
    private String majorDirection;
    private String politicalStatusShow;
    private String householdRegisterType;//户籍性质
    private String studentCategory;//考生类别
    private String finishSchool;//毕业学校
    private String middleClass;//初中班级
    private String middleScore;//中考成绩
    private String studentKind;//学生类别
    private String ticketCard;//准考证号
    private String fillStatus;//是否填报志愿
    private String height;//身高
    private String weight;//体重
    private String clothesNumber;//衣服型号
    private String specialStatus;//是否特型
    private String finishCardStatus;//是否有毕业证
    private String stayingStatus;//是否住宿
    private String itemId;
    private String planItemShow;
    private String paymentStandard;
    private String planId;
    private String idCardPhotoUrl;
    private String programDuration; //学制
    private String gradation; //层次
    private String programDurationShow; //学制回显
    private String gradationShow; //层次回显
    private String reportStatus;//报到状态
    private String educationalSystem;
    private String majorDirectionShow;
    private String trainingLevelShow;
    private String studentStatusShow;
    private String reportStatusShow;

    private String studentSource;//生源类别
    private String admissionsWay;  //招生方式
    private String fromArmy;//来自军队
    private String ruralHouseholdRegistratio; //是否常住户口在农村
    private String orderTraining; //是否订单（定向）培养
    private String documentaryLikaPoorFamilie;//是否建档立卡贫困家庭

    public String getReportStatusShow() {
        return reportStatusShow;
    }

    public void setReportStatusShow(String reportStatusShow) {
        this.reportStatusShow = reportStatusShow;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
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

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(String userAccount) {
        this.userAccount = userAccount;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
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

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getHousePlace() {
        return housePlace;
    }

    public void setHousePlace(String housePlace) {
        this.housePlace = housePlace;
    }

    public String getHouseProvince() {
        return houseProvince;
    }

    public void setHouseProvince(String houseProvince) {
        this.houseProvince = houseProvince;
    }

    public String getHouseCity() {
        return houseCity;
    }

    public void setHouseCity(String houseCity) {
        this.houseCity = houseCity;
    }

    public String getHouseCounty() {
        return houseCounty;
    }

    public void setHouseCounty(String houseCounty) {
        this.houseCounty = houseCounty;
    }

    public String getProvinceShow() {
        return provinceShow;
    }

    public void setProvinceShow(String provinceShow) {
        this.provinceShow = provinceShow;
    }

    public String getCityShow() {
        return cityShow;
    }

    public void setCityShow(String cityShow) {
        this.cityShow = cityShow;
    }

    public String getCountyShow() {
        return countyShow;
    }

    public void setCountyShow(String countyShow) {
        this.countyShow = countyShow;
    }

    public String getPoliticalStatus() {
        return politicalStatus;
    }

    public void setPoliticalStatus(String politicalStatus) {
        this.politicalStatus = politicalStatus;
    }

    public String getHomePhone() {
        return homePhone;
    }

    public void setHomePhone(String homePhone) {
        this.homePhone = homePhone;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }

    public String getNationalityShow() {
        return nationalityShow;
    }

    public void setNationalityShow(String nationalityShow) {
        this.nationalityShow = nationalityShow;
    }

    public String getNationShow() {
        return nationShow;
    }

    public void setNationShow(String nationShow) {
        this.nationShow = nationShow;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassShow() {
        return classShow;
    }

    public void setClassShow(String classShow) {
        this.classShow = classShow;
    }

    public String getStudentStatus() {
        return studentStatus;
    }

    public void setStudentStatus(String studentStatus) {
        this.studentStatus = studentStatus;
    }

    public String getStudentStatusShow() {
        return studentStatusShow;
    }

    public void setStudentStatusShow(String studentStatusShow) {
        this.studentStatusShow = studentStatusShow;
    }

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
    }

    public String getDepartmentShow() {
        return departmentShow;
    }

    public void setDepartmentShow(String departmentShow) {
        this.departmentShow = departmentShow;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getDormFlag() {
        return dormFlag;
    }

    public void setDormFlag(String dormFlag) {
        this.dormFlag = dormFlag;
    }

    public String getJoinYear() {
        return joinYear;
    }

    public void setJoinYear(String joinYear) {
        this.joinYear = joinYear;
    }

    public String getJoinMonth() {
        return joinMonth;
    }

    public void setJoinMonth(String joinMonth) {
        this.joinMonth = joinMonth;
    }

    public String getCutFlag() {
        return cutFlag;
    }

    public void setCutFlag(String cutFlag) {
        this.cutFlag = cutFlag;
    }

    public String getMajorDirection() {
        return majorDirection;
    }

    public void setMajorDirection(String majorDirection) {
        this.majorDirection = majorDirection;
    }

    public String getPoliticalStatusShow() {
        return politicalStatusShow;
    }

    public void setPoliticalStatusShow(String politicalStatusShow) {
        this.politicalStatusShow = politicalStatusShow;
    }

    public String getHouseholdRegisterType() {
        return householdRegisterType;
    }

    public void setHouseholdRegisterType(String householdRegisterType) {
        this.householdRegisterType = householdRegisterType;
    }

    public String getStudentCategory() {
        return studentCategory;
    }

    public void setStudentCategory(String studentCategory) {
        this.studentCategory = studentCategory;
    }

    public String getFinishSchool() {
        return finishSchool;
    }

    public void setFinishSchool(String finishSchool) {
        this.finishSchool = finishSchool;
    }

    public String getMiddleClass() {
        return middleClass;
    }

    public void setMiddleClass(String middleClass) {
        this.middleClass = middleClass;
    }

    public String getMiddleScore() {
        return middleScore;
    }

    public void setMiddleScore(String middleScore) {
        this.middleScore = middleScore;
    }

    public String getStudentKind() {
        return studentKind;
    }

    public void setStudentKind(String studentKind) {
        this.studentKind = studentKind;
    }

    public String getTicketCard() {
        return ticketCard;
    }

    public void setTicketCard(String ticketCard) {
        this.ticketCard = ticketCard;
    }

    public String getFillStatus() {
        return fillStatus;
    }

    public void setFillStatus(String fillStatus) {
        this.fillStatus = fillStatus;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getClothesNumber() {
        return clothesNumber;
    }

    public void setClothesNumber(String clothesNumber) {
        this.clothesNumber = clothesNumber;
    }

    public String getSpecialStatus() {
        return specialStatus;
    }

    public void setSpecialStatus(String specialStatus) {
        this.specialStatus = specialStatus;
    }

    public String getFinishCardStatus() {
        return finishCardStatus;
    }

    public void setFinishCardStatus(String finishCardStatus) {
        this.finishCardStatus = finishCardStatus;
    }

    public String getStayingStatus() {
        return stayingStatus;
    }

    public void setStayingStatus(String stayingStatus) {
        this.stayingStatus = stayingStatus;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getPlanItemShow() {
        return planItemShow;
    }

    public void setPlanItemShow(String planItemShow) {
        this.planItemShow = planItemShow;
    }

    public String getPaymentStandard() {
        return paymentStandard;
    }

    public void setPaymentStandard(String paymentStandard) {
        this.paymentStandard = paymentStandard;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getIdCardPhotoUrl() {
        return idCardPhotoUrl;
    }

    public void setIdCardPhotoUrl(String idCardPhotoUrl) {
        this.idCardPhotoUrl = idCardPhotoUrl;
    }

    public String getProgramDuration() {
        return programDuration;
    }

    public void setProgramDuration(String programDuration) {
        this.programDuration = programDuration;
    }

    public String getGradation() {
        return gradation;
    }

    public void setGradation(String gradation) {
        this.gradation = gradation;
    }

    public String getProgramDurationShow() {
        return programDurationShow;
    }

    public void setProgramDurationShow(String programDurationShow) {
        this.programDurationShow = programDurationShow;
    }

    public String getGradationShow() {
        return gradationShow;
    }

    public void setGradationShow(String gradationShow) {
        this.gradationShow = gradationShow;
    }

    public String getReportStatus() {
        return reportStatus;
    }

    public void setReportStatus(String reportStatus) {
        this.reportStatus = reportStatus;
    }

    public String getEducationalSystem() {
        return educationalSystem;
    }

    public void setEducationalSystem(String educationalSystem) {
        this.educationalSystem = educationalSystem;
    }

    public String getMajorDirectionShow() {
        return majorDirectionShow;
    }

    public void setMajorDirectionShow(String majorDirectionShow) {
        this.majorDirectionShow = majorDirectionShow;
    }

    public String getTrainingLevelShow() {
        return trainingLevelShow;
    }

    public void setTrainingLevelShow(String trainingLevelShow) {
        this.trainingLevelShow = trainingLevelShow;
    }

    public String getStudentSource() {
        return studentSource;
    }

    public void setStudentSource(String studentSource) {
        this.studentSource = studentSource;
    }

    public String getAdmissionsWay() {
        return admissionsWay;
    }

    public void setAdmissionsWay(String admissionsWay) {
        this.admissionsWay = admissionsWay;
    }

    public String getFromArmy() {
        return fromArmy;
    }

    public void setFromArmy(String fromArmy) {
        this.fromArmy = fromArmy;
    }

    public String getRuralHouseholdRegistratio() {
        return ruralHouseholdRegistratio;
    }

    public void setRuralHouseholdRegistratio(String ruralHouseholdRegistratio) {
        this.ruralHouseholdRegistratio = ruralHouseholdRegistratio;
    }

    public String getOrderTraining() {
        return orderTraining;
    }

    public void setOrderTraining(String orderTraining) {
        this.orderTraining = orderTraining;
    }

    public String getDocumentaryLikaPoorFamilie() {
        return documentaryLikaPoorFamilie;
    }

    public void setDocumentaryLikaPoorFamilie(String documentaryLikaPoorFamilie) {
        this.documentaryLikaPoorFamilie = documentaryLikaPoorFamilie;
    }
}
