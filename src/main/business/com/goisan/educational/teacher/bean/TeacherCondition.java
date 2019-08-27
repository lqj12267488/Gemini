package com.goisan.educational.teacher.bean;

import com.goisan.system.bean.BaseBean;
/**
 * Created by Administrator on 2018/6/20.
 */
public class TeacherCondition extends BaseBean {
    private String teacherId;
    private String personId;
    private String teacherName;
    private String teacherSex;
    private String birthday;
    private String finalEducation;
    private String degee;
    private String major;
    private String title;//已聘职称
    private String teacherCategory;
    private String departmentId;
    private String majorShow;
    private String departmentIdShow;
    private String teacherCategoryShow;
    private String value;
    private String label;
    private String nativePlace;
    private String nation;
    private String politicalStatusShow;
    private String firstEducation;
    private String firstEducationStatus;
    private String firstEducationSchool;
    private String firstEducationMajor;
    private String licence;//教师资格发证单位
    private String getTime;//教师资格获得日期
    private String finalEducationSchool;
    private String politicalStatus;
    private String nationShow;
    private String teacherNameShow;

    private String teacherNum,xzPosition,firsEndtime,finaleEndtime,majorField,majorSpecialty,workYear,majorYear;
    //教工号,行政职务,第一学历毕业时间,最后学历毕业时间,专业领域,专业特长，一线工作历年，专业技术职务本学年
    private String majorGrade,majorName,majorDept,careerGettime,careerGrade,careerName,careerDept;
    //专业技术职务等级，专业技术职务名称，发证单位，职业资格证获取日期，职业资格证书等级，职业资格证书名称，发证单位
    private String sfzyTeacher,sfssTeacher,sfmsTeacher,sfggTeacher,politicsMajorCode,politicsMajorName,majorDate;
    //是否专业教师,是否双师素质教师,是否教学名师,是否骨干教师,行政所属专业代码,行政所属专业名称,专业技术获取日期
    private String qiyeYear,qiyeDate,expertDept,expertWork,expertDate,trainingName,trainingDay,trainingPlace;
    //企业工作时间(年),企业工作本学年（天）,当前专职单位，当前专职职务，专职任职日期，教学进修项目名称,进修时间(天),进修地点
    private String workDate,signing,sendDept,srPosition,workDept;
    //参加工作日期，签约情况,派出部门,所任职务,工作单位


    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getTeacherNum() {
        return teacherNum;
    }

    public void setTeacherNum(String teacherNum) {
        this.teacherNum = teacherNum;
    }

    public String getXzPosition() {
        return xzPosition;
    }

    public void setXzPosition(String xzPosition) {
        this.xzPosition = xzPosition;
    }

    public String getFirsEndtime() {
        return firsEndtime;
    }

    public void setFirsEndtime(String firsEndtime) {
        this.firsEndtime = firsEndtime;
    }

    public String getFinaleEndtime() {
        return finaleEndtime;
    }

    public void setFinaleEndtime(String finaleEndtime) {
        this.finaleEndtime = finaleEndtime;
    }

    public String getMajorField() {
        return majorField;
    }

    public void setMajorField(String majorField) {
        this.majorField = majorField;
    }

    public String getMajorSpecialty() {
        return majorSpecialty;
    }

    public void setMajorSpecialty(String majorSpecialty) {
        this.majorSpecialty = majorSpecialty;
    }

    public String getWorkYear() {
        return workYear;
    }

    public void setWorkYear(String workYear) {
        this.workYear = workYear;
    }

    public String getMajorYear() {
        return majorYear;
    }

    public void setMajorYear(String majorYear) {
        this.majorYear = majorYear;
    }

    public String getMajorGrade() {
        return majorGrade;
    }

    public void setMajorGrade(String majorGrade) {
        this.majorGrade = majorGrade;
    }

    public String getMajorName() {
        return majorName;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public String getMajorDept() {
        return majorDept;
    }

    public void setMajorDept(String majorDept) {
        this.majorDept = majorDept;
    }

    public String getCareerGettime() {
        return careerGettime;
    }

    public void setCareerGettime(String careerGettime) {
        this.careerGettime = careerGettime;
    }

    public String getCareerGrade() {
        return careerGrade;
    }

    public void setCareerGrade(String careerGrade) {
        this.careerGrade = careerGrade;
    }

    public String getCareerName() {
        return careerName;
    }

    public void setCareerName(String careerName) {
        this.careerName = careerName;
    }

    public String getCareerDept() {
        return careerDept;
    }

    public void setCareerDept(String careerDept) {
        this.careerDept = careerDept;
    }

    public String getSfzyTeacher() {
        return sfzyTeacher;
    }

    public void setSfzyTeacher(String sfzyTeacher) {
        this.sfzyTeacher = sfzyTeacher;
    }

    public String getSfssTeacher() {
        return sfssTeacher;
    }

    public void setSfssTeacher(String sfssTeacher) {
        this.sfssTeacher = sfssTeacher;
    }

    public String getSfmsTeacher() {
        return sfmsTeacher;
    }

    public void setSfmsTeacher(String sfmsTeacher) {
        this.sfmsTeacher = sfmsTeacher;
    }

    public String getPoliticsMajorCode() {
        return politicsMajorCode;
    }

    public void setPoliticsMajorCode(String politicsMajorCode) {
        this.politicsMajorCode = politicsMajorCode;
    }

    public String getPoliticsMajorName() {
        return politicsMajorName;
    }

    public void setPoliticsMajorName(String politicsMajorName) {
        this.politicsMajorName = politicsMajorName;
    }




    public String getNationShow() {
        return nationShow;
    }

    public void setNationShow(String nationShow) {
        this.nationShow = nationShow;
    }

    public String getPoliticalStatus() {
        return politicalStatus;
    }

    public void setPoliticalStatus(String politicalStatus) {
        this.politicalStatus = politicalStatus;
    }

    public String getFinalEducationSchool() {
        return finalEducationSchool;
    }

    public void setFinalEducationSchool(String finalEducationSchool) {
        this.finalEducationSchool = finalEducationSchool;
    }

    public String getNativePlace() {
        return nativePlace;
    }

    public void setNativePlace(String nativePlace) {
        this.nativePlace = nativePlace;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getPoliticalStatusShow() {
        return politicalStatusShow;
    }

    public void setPoliticalStatusShow(String politicalStatusShow) {
        this.politicalStatusShow = politicalStatusShow;
    }

    public String getFirstEducation() {
        return firstEducation;
    }

    public void setFirstEducation(String firstEducation) {
        this.firstEducation = firstEducation;
    }

    public String getFirstEducationStatus() {
        return firstEducationStatus;
    }

    public void setFirstEducationStatus(String firstEducationStatus) {
        this.firstEducationStatus = firstEducationStatus;
    }

    public String getFirstEducationSchool() {
        return firstEducationSchool;
    }

    public void setFirstEducationSchool(String firstEducationSchool) {
        this.firstEducationSchool = firstEducationSchool;
    }

    public String getFirstEducationMajor() {
        return firstEducationMajor;
    }

    public void setFirstEducationMajor(String firstEducationMajor) {
        this.firstEducationMajor = firstEducationMajor;
    }

    public String getLicence() {
        return licence;
    }

    public void setLicence(String licence) {
        this.licence = licence;
    }

    public String getGetTime() {
        return getTime;
    }

    public void setGetTime(String getTime) {
        this.getTime = getTime;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getTeacherCategoryShow() {
        return teacherCategoryShow;
    }

    public void setTeacherCategoryShow(String teacherCategoryShow) {
        this.teacherCategoryShow = teacherCategoryShow;
    }

    public String getDepartmentIdShow() {
        return departmentIdShow;
    }

    public void setDepartmentIdShow(String departmentIdShow) {
        this.departmentIdShow = departmentIdShow;
    }

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getFinalEducation() {
        return finalEducation;
    }

    public void setFinalEducation(String finalEducation) {
        this.finalEducation = finalEducation;
    }

    public String getDegee() {
        return degee;
    }

    public void setDegee(String degee) {
        this.degee = degee;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTeacherCategory() {
        return teacherCategory;
    }

    public void setTeacherCategory(String teacherCategory) {
        this.teacherCategory = teacherCategory;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getTeacherNameShow() {
        return teacherNameShow;
    }

    public void setTeacherNameShow(String teacherNameShow) {
        this.teacherNameShow = teacherNameShow;
    }

    public String getTeacherSex() {
        return teacherSex;
    }

    public void setTeacherSex(String teacherSex) {
        this.teacherSex = teacherSex;
    }

    public String getMajorDate() {
        return majorDate;
    }

    public void setMajorDate(String majorDate) {
        this.majorDate = majorDate;
    }

    public String getQiyeYear() {
        return qiyeYear;
    }

    public void setQiyeYear(String qiyeYear) {
        this.qiyeYear = qiyeYear;
    }

    public String getQiyeDate() {
        return qiyeDate;
    }

    public void setQiyeDate(String qiyeDate) {
        this.qiyeDate = qiyeDate;
    }

    public String getSfggTeacher() {
        return sfggTeacher;
    }

    public void setSfggTeacher(String sfggTeacher) {
        this.sfggTeacher = sfggTeacher;
    }

    public String getExpertDept() {
        return expertDept;
    }

    public void setExpertDept(String expertDept) {
        this.expertDept = expertDept;
    }

    public String getExpertWork() {
        return expertWork;
    }

    public void setExpertWork(String expertWork) {
        this.expertWork = expertWork;
    }

    public String getExpertDate() {
        return expertDate;
    }

    public void setExpertDate(String expertDate) {
        this.expertDate = expertDate;
    }

    public String getTrainingName() {
        return trainingName;
    }

    public void setTrainingName(String trainingName) {
        this.trainingName = trainingName;
    }

    public String getTrainingDay() {
        return trainingDay;
    }

    public void setTrainingDay(String trainingDay) {
        this.trainingDay = trainingDay;
    }

    public String getTrainingPlace() {
        return trainingPlace;
    }

    public void setTrainingPlace(String trainingPlace) {
        this.trainingPlace = trainingPlace;
    }

    public String getWorkDate() {
        return workDate;
    }

    public void setWorkDate(String workDate) {
        this.workDate = workDate;
    }

    public String getSigning() {
        return signing;
    }

    public void setSigning(String signing) {
        this.signing = signing;
    }

    public String getSendDept() {
        return sendDept;
    }

    public void setSendDept(String sendDept) {
        this.sendDept = sendDept;
    }

    public String getSrPosition() {
        return srPosition;
    }

    public void setSrPosition(String srPosition) {
        this.srPosition = srPosition;
    }

    public String getWorkDept() {
        return workDept;
    }

    public void setWorkDept(String workDept) {
        this.workDept = workDept;
    }
}
