package com.goisan.system.bean;

import java.sql.Date;

/**
 * Created by admin on 2017/5/20.
 */
public class Student extends BaseBean {
    private String studentId;
    private String name;
    private String sex;
    private String idcard;
    private String userAccount;
    private String studentNumber;
    private Date birthday;
    private String nationality;
    private String nation;
    private String householdRegisterPlace;//----户籍详细住址
    private String houseProvince;
    private String houseCity;
    private String houseCounty;
    private String houseProvinceShow;
    private String houseCityShow;
    private String houseCountyShow;
    private String politicalStatus;
    private String politicalStatusShow;
    private String homePhone;
    private String tel;
    private String photo;
    private String sexShow;
    private String nationalityShow;
    private String nationShow;
    private String classId;
    private String classShow;
    private String studentStatus;
    private String studentStatusShow;
    private String majorShow;
    private String departmentShow;
    private String departmentsId;
    private String majorCode;
    private String trainingLevel;
    private String trainingLevelShow;
    private String dormFlag;
    private String joinYear;
    private String joinMonth;
    private String householdRegisterType;//户籍性质
    private String householdRegisterTypeShow;//户籍性质
    private String address;//现住址
    private String addressProvince;//现家庭所在省
    private String addressProvinceShow;//现家庭所在省
    private String addressCity;//现家庭所在市
    private String addressCityShow;//现家庭所在市
    private String addressCounty;//现家庭所在县区
    private String addressCountyShow;//现家庭所在县区
    private String overseasChinese;//港澳台侨胞
    private String overseasChineseShow;//港澳台侨胞
    private String allowancesFlag;//是否低保
    private String allowancesFlagShow;//是否低保
    private String grantsFlag;//是否享受国家助学金
    private String grantsFlagShow;//是否享受国家助学金
    private String studentType;//学生类型
    private String studentTypeShow;//学生类型
    private String studentSource;//生源类别
    private String studentSourceShow;//生源类别
    private String teachingPlace;//教学点名称
    private String graduatedSchool;//毕业学校
    private String remark;//备注
    private String majorDirection;
    private String itemId;
    private String planItemShow;
    private String paymentStandard;
    private String paymentAmount;
    private String refundAmount;
    private String planId;
    private String idCardPhotoUrl;
    private String candidateNumberDz;//大专考生号
    private String studentCount;
    private String month;
    private String year;
    private String from;
    private String nameOfMember;
    private String memberRelationship;
    private String isGuardian;
    private String MemberTelephoneNumber;
    private String graduationSchool;
    private String stuSourceAddr;
    private String fromArmy;//来自军队
    private String fromArmyShow;
    private String ruralHouseholdRegistratio; //是否常住户口在农村
    private String orderTraining; //是否订单（定向）培养
    private String documentaryLikaPoorFamilie;//是否建档立卡贫困家庭
    private String studyModeDz; //大专就业形式
    private String totalPoints;//大专总分
    private String idCardType; //身份证件类型
    private String spellName;  //姓名拼音
    private String className;  //班级名称
    private String learnMode;  //学习形式
    private String enrollmentType; //入学方式
    private String studyingWay;    //就读方式
    private String maritalStatus;  //婚姻状况
    private String trainInterval;  //乘火车区间
    private String trailingChildrenFlag;   //是否随迁子女
    private String sourcePlaceDivisionCode;    //生源地行政区划码
    private String birthPlaceDivisionCode;     //出生地行政区划码
    private String nativePlaceDivisionCode;    //籍贯地行政区划码
    private String subordinateStation;     //所属派出所
    private String residenceDivisionCode;    //户口所在地行政区划码
    private String studentResidenceType;   //学生居住地类型
    private String professionalExpertise;  //专业简称
    private String eductionalSystem;   //学制
    private String healthCondition;    //健康状况
    private String enrollmentTarget;   //招生对象
    private String admissionsWay;  //招生方式
    private String cooperationType;    //联招合作类型
    private String examinationCardNumber;  //准考证号
    private String candidateNumber;        //考生号
    private String testScores;           //考试总分
    private String formCooperativeEducation; //联招合作办学形式
    private String codeCooperativeEducation;  //联招合作学校代码
    private String externalTeachingPoint;  //校外教学点
    private String subsectionCulture; //分段培养方式

    public String getFromArmy() {
        return fromArmy;
    }

    public void setFromArmy(String fromArmy) {
        this.fromArmy = fromArmy;
    }

    public String getFromArmyShow() {
        return fromArmyShow;
    }

    public void setFromArmyShow(String fromArmyShow) {
        this.fromArmyShow = fromArmyShow;
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
    public String getStuSourceAddr() {
        return stuSourceAddr;
    }

    public void setStuSourceAddr(String stuSourceAddr) {
        this.stuSourceAddr = stuSourceAddr;
    }

    public String getNameOfMember() {
        return nameOfMember;
    }

    public void setNameOfMember(String nameOfMember) {
        this.nameOfMember = nameOfMember;
    }

    public String getMemberRelationship() {
        return memberRelationship;
    }

    public void setMemberRelationship(String memberRelationship) {
        this.memberRelationship = memberRelationship;
    }

    public String getIsGuardian() {
        return isGuardian;
    }

    public void setIsGuardian(String isGuardian) {
        this.isGuardian = isGuardian;
    }

    public String getMemberTelephoneNumber() {
        return MemberTelephoneNumber;
    }

    public void setMemberTelephoneNumber(String memberTelephoneNumber) {
        MemberTelephoneNumber = memberTelephoneNumber;
    }

    public String getGraduationSchool() {
        return graduationSchool;
    }

    public void setGraduationSchool(String graduationSchool) {
        this.graduationSchool = graduationSchool;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getStudyModeDz() {
        return studyModeDz;
    }

    public void setStudyModeDz(String studyModeDz) {
        this.studyModeDz = studyModeDz;
    }




    public String getFormCooperativeEducation() {
        return formCooperativeEducation;
    }

    public void setFormCooperativeEducation(String formCooperativeEducation) {
        this.formCooperativeEducation = formCooperativeEducation;
    }

    public String getCodeCooperativeEducation() {
        return codeCooperativeEducation;
    }

    public void setCodeCooperativeEducation(String codeCooperativeEducation) {
        this.codeCooperativeEducation = codeCooperativeEducation;
    }

    public String getExternalTeachingPoint() {
        return externalTeachingPoint;
    }

    public void setExternalTeachingPoint(String externalTeachingPoint) {
        this.externalTeachingPoint = externalTeachingPoint;
    }

    public String getSubsectionCulture() {
        return subsectionCulture;
    }

    public void setSubsectionCulture(String subsectionCulture) {
        this.subsectionCulture = subsectionCulture;
    }

    public String getCandidateNumberDz() {
        return candidateNumberDz;
    }

    public void setCandidateNumberDz(String candidateNumberDz) {
        this.candidateNumberDz = candidateNumberDz;
    }


    public String getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(String totalPoints) {
        this.totalPoints = totalPoints;
    }

    public String getIdCardType() {
        return idCardType;
    }

    public void setIdCardType(String idCardType) {
        this.idCardType = idCardType;
    }

    public String getSpellName() {
        return spellName;
    }

    public void setSpellName(String spellName) {
        this.spellName = spellName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getLearnMode() {
        return learnMode;
    }

    public void setLearnMode(String learnMode) {
        this.learnMode = learnMode;
    }

    public String getEnrollmentType() {
        return enrollmentType;
    }

    public void setEnrollmentType(String enrollmentType) {
        this.enrollmentType = enrollmentType;
    }

    public String getStudyingWay() {
        return studyingWay;
    }

    public void setStudyingWay(String studyingWay) {
        this.studyingWay = studyingWay;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public String getTrainInterval() {
        return trainInterval;
    }

    public void setTrainInterval(String trainInterval) {
        this.trainInterval = trainInterval;
    }

    public String getTrailingChildrenFlag() {
        return trailingChildrenFlag;
    }

    public void setTrailingChildrenFlag(String trailingChildrenFlag) {
        this.trailingChildrenFlag = trailingChildrenFlag;
    }

    public String getSourcePlaceDivisionCode() {
        return sourcePlaceDivisionCode;
    }

    public void setSourcePlaceDivisionCode(String sourcePlaceDivisionCode) {
        this.sourcePlaceDivisionCode = sourcePlaceDivisionCode;
    }

    public String getBirthPlaceDivisionCode() {
        return birthPlaceDivisionCode;
    }

    public void setBirthPlaceDivisionCode(String birthPlaceDivisionCode) {
        this.birthPlaceDivisionCode = birthPlaceDivisionCode;
    }

    public String getNativePlaceDivisionCode() {
        return nativePlaceDivisionCode;
    }

    public void setNativePlaceDivisionCode(String nativePlaceDivisionCode) {
        this.nativePlaceDivisionCode = nativePlaceDivisionCode;
    }

    public String getSubordinateStation() {
        return subordinateStation;
    }

    public void setSubordinateStation(String subordinateStation) {
        this.subordinateStation = subordinateStation;
    }

    public String getResidenceDivisionCode() {
        return residenceDivisionCode;
    }

    public void setResidenceDivisionCode(String residenceDivisionCode) {
        this.residenceDivisionCode = residenceDivisionCode;
    }

    public String getStudentResidenceType() {
        return studentResidenceType;
    }

    public void setStudentResidenceType(String studentResidenceType) {
        this.studentResidenceType = studentResidenceType;
    }

    public String getProfessionalExpertise() {
        return professionalExpertise;
    }

    public void setProfessionalExpertise(String professionalExpertise) {
        this.professionalExpertise = professionalExpertise;
    }

    public String getEductionalSystem() {
        return eductionalSystem;
    }

    public void setEductionalSystem(String eductionalSystem) {
        this.eductionalSystem = eductionalSystem;
    }

    public String getHealthCondition() {
        return healthCondition;
    }

    public void setHealthCondition(String healthCondition) {
        this.healthCondition = healthCondition;
    }

    public String getEnrollmentTarget() {
        return enrollmentTarget;
    }

    public void setEnrollmentTarget(String enrollmentTarget) {
        this.enrollmentTarget = enrollmentTarget;
    }

    public String getAdmissionsWay() {
        return admissionsWay;
    }

    public void setAdmissionsWay(String admissionsWay) {
        this.admissionsWay = admissionsWay;
    }

    public String getCooperationType() {
        return cooperationType;
    }

    public void setCooperationType(String cooperationType) {
        this.cooperationType = cooperationType;
    }

    public String getExaminationCardNumber() {
        return examinationCardNumber;
    }

    public void setExaminationCardNumber(String examinationCardNumber) {
        this.examinationCardNumber = examinationCardNumber;
    }

    public String getCandidateNumber() {
        return candidateNumber;
    }

    public void setCandidateNumber(String candidateNumber) {
        this.candidateNumber = candidateNumber;
    }

    public String getTestScores() {
        return testScores;
    }

    public void setTestScores(String testScores) {
        this.testScores = testScores;
    }

    public String getIdCardPhotoUrl() {
        return idCardPhotoUrl;
    }

    public void setIdCardPhotoUrl(String idCardPhotoUrl) {
        this.idCardPhotoUrl = idCardPhotoUrl;
    }

    public String getPoliticalStatusShow() {
        return politicalStatusShow;
    }

    public void setPoliticalStatusShow(String politicalStatusShow) {
        this.politicalStatusShow = politicalStatusShow;
    }

    public String getHouseholdRegisterTypeShow() {
        return householdRegisterTypeShow;
    }

    public void setHouseholdRegisterTypeShow(String householdRegisterTypeShow) {
        this.householdRegisterTypeShow = householdRegisterTypeShow;
    }

    public String getAddressProvinceShow() {
        return addressProvinceShow;
    }

    public void setAddressProvinceShow(String addressProvinceShow) {
        this.addressProvinceShow = addressProvinceShow;
    }

    public String getAddressCityShow() {
        return addressCityShow;
    }

    public void setAddressCityShow(String addressCityShow) {
        this.addressCityShow = addressCityShow;
    }

    public String getAddressCountyShow() {
        return addressCountyShow;
    }

    public void setAddressCountyShow(String addressCountyShow) {
        this.addressCountyShow = addressCountyShow;
    }

    public String getOverseasChineseShow() {
        return overseasChineseShow;
    }

    public void setOverseasChineseShow(String overseasChineseShow) {
        this.overseasChineseShow = overseasChineseShow;
    }

    public String getAllowancesFlagShow() {
        return allowancesFlagShow;
    }

    public void setAllowancesFlagShow(String allowancesFlagShow) {
        this.allowancesFlagShow = allowancesFlagShow;
    }

    public String getGrantsFlagShow() {
        return grantsFlagShow;
    }

    public void setGrantsFlagShow(String grantsFlagShow) {
        this.grantsFlagShow = grantsFlagShow;
    }

    public String getStudentTypeShow() {
        return studentTypeShow;
    }

    public void setStudentTypeShow(String studentTypeShow) {
        this.studentTypeShow = studentTypeShow;
    }

    public String getStudentSourceShow() {
        return studentSourceShow;
    }

    public void setStudentSourceShow(String studentSourceShow) {
        this.studentSourceShow = studentSourceShow;
    }

    public String getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(String userAccount) {
        this.userAccount = userAccount;
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

    public String getHouseProvinceShow() {
        return houseProvinceShow;
    }

    public void setHouseProvinceShow(String houseProvinceShow) {
        this.houseProvinceShow = houseProvinceShow;
    }

    public String getHouseCityShow() {
        return houseCityShow;
    }

    public void setHouseCityShow(String houseCityShow) {
        this.houseCityShow = houseCityShow;
    }

    public String getHouseCountyShow() {
        return houseCountyShow;
    }

    public void setHouseCountyShow(String houseCountyShow) {
        this.houseCountyShow = houseCountyShow;
    }

    public String getHouseholdRegisterPlace() {
        return householdRegisterPlace;
    }

    public void setHouseholdRegisterPlace(String householdRegisterPlace) {
        this.householdRegisterPlace = householdRegisterPlace;
    }

    public String getAddressProvince() {
        return addressProvince;
    }

    public void setAddressProvince(String addressProvince) {
        this.addressProvince = addressProvince;
    }

    public String getAddressCity() {
        return addressCity;
    }

    public void setAddressCity(String addressCity) {
        this.addressCity = addressCity;
    }

    public String getAddressCounty() {
        return addressCounty;
    }

    public void setAddressCounty(String addressCounty) {
        this.addressCounty = addressCounty;
    }

    public String getOverseasChinese() {
        return overseasChinese;
    }

    public void setOverseasChinese(String overseasChinese) {
        this.overseasChinese = overseasChinese;
    }

    public String getAllowancesFlag() {
        return allowancesFlag;
    }

    public void setAllowancesFlag(String allowancesFlag) {
        this.allowancesFlag = allowancesFlag;
    }

    public String getGrantsFlag() {
        return grantsFlag;
    }

    public void setGrantsFlag(String grantsFlag) {
        this.grantsFlag = grantsFlag;
    }

    public String getStudentType() {
        return studentType;
    }

    public void setStudentType(String studentType) {
        this.studentType = studentType;
    }

    public String getStudentSource() {
        return studentSource;
    }

    public void setStudentSource(String studentSource) {
        this.studentSource = studentSource;
    }

    public String getTeachingPlace() {
        return teachingPlace;
    }

    public void setTeachingPlace(String teachingPlace) {
        this.teachingPlace = teachingPlace;
    }

    public String getGraduatedSchool() {
        return graduatedSchool;
    }

    public void setGraduatedSchool(String graduatedSchool) {
        this.graduatedSchool = graduatedSchool;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getHouseholdRegisterType() {
        return householdRegisterType;
    }

    public void setHouseholdRegisterType(String householdRegisterType) {
        this.householdRegisterType = householdRegisterType;
    }

    public String getMajorDirection() {
        return majorDirection;
    }

    public void setMajorDirection(String majorDirection) {
        this.majorDirection = majorDirection;
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

    public String getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(String paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(String refundAmount) {
        this.refundAmount = refundAmount;
    }

    public String getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(String studentCount) {
        this.studentCount = studentCount;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }


    public String getTrainingLevelShow() {
        return trainingLevelShow;
    }

    public void setTrainingLevelShow(String trainingLevelShow) {
        this.trainingLevelShow = trainingLevelShow;
    }
}
