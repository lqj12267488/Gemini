package com.goisan.educational.major.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/5/18.
 */
public class Major extends BaseBean {
    private String majorId;//专业ID
    private String majorName;//专业名称
    private String majorCode;//专业代码
    private String majorSchool;//所属学院
    private String majorDirection;//专业方向名称
    private String majorDirectionCode;//专业方向代码
    private String ordersStudentnum;//订单培养学生数
    private String schoolSystem;//学制
    private String departmentsId;//系部
    private String trainingLevel;//培养层次
    private String classNum;//班级总数
    private String ordersClassnum;//订单培养班级数
    private String springAutumnFlag;//春秋招生标识，0否 1是
    private String majorPrincipal;//
    private String majorNow;//现在学徒制试点专业
    private String approvalTime;//批准设置时间
    private String firstRecruitTime;//首次招生时间
    private String departmentsIdShow;
    private String StudentnumShow;
    private String schoolSystemShow;
    private String majorDirectionShow;
    private String trainingLevelShow;
    private String classNumShow;
    private String ordersClassnumShow;
    private String springAutumnFlagShow;
    private String validFlagShow;
    private String directionCodeShow;
    private String majorNowShow;
    private String majorGlobalShow;
    private String majorPrincipalDept;
    private String majorPrincipalDeptShow;
    private String majorSchoolShow;
    private String focusTypeShow;
    private String uniqueTypeShow;
    private String remark;
    private String majorGlobal;//国际合作专业
    private String majorLeaderDeptShow;
    private String focusCourseType;//专业重点专业类别
    private String uniqueCourseType;//特色专业类别
    private String maxYear;//修业年限
    private String endRecruittime;//停止招生时间
    private String professionCharact;  //  专业特点
    private String fileUrl;
    private String studentNumber;//在校学生数
    private String sourceNumberOne;//生源类型 普通高中生人数
    private String sourceNumberTwo;//生源类型 中职起点人数
    private String sourceNumberThree;//生源类型 其他人数
    private String majorNumber;//专业人数
    private String classNumber;//年级数
    private String maxYearShow;

    private String planNumber;//计划招生数
    private String realNumber;//报道人数

    private String graduationNumber;//毕业人数
    private String employmentNumber;//就业人数

    public String getGraduationNumber() {
        return graduationNumber;
    }

    public void setGraduationNumber(String graduationNumber) {
        this.graduationNumber = graduationNumber;
    }

    public String getEmploymentNumber() {
        return employmentNumber;
    }

    public void setEmploymentNumber(String employmentNumber) {
        this.employmentNumber = employmentNumber;
    }

    public String getRealNumber() {
        return realNumber;
    }

    public void setRealNumber(String realNumber) {
        this.realNumber = realNumber;
    }

    public String getPlanNumber() {
        return planNumber;
    }

    public void setPlanNumber(String planNumber) {
        this.planNumber = planNumber;
    }







    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getMajorLeaderDeptShow() {
        return majorLeaderDeptShow;
    }

    public void setMajorLeaderDeptShow(String majorLeaderDeptShow) {
        this.majorLeaderDeptShow = majorLeaderDeptShow;
    }

    public String getMajorPrincipalDept() {
        return majorPrincipalDept;
    }

    public void setMajorPrincipalDept(String majorPrincipalDept) {
        this.majorPrincipalDept = majorPrincipalDept;
    }

    public String getMajorPrincipalDeptShow() {
        return majorPrincipalDeptShow;
    }

    public void setMajorPrincipalDeptShow(String majorPrincipalDeptShow) {
        this.majorPrincipalDeptShow = majorPrincipalDeptShow;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getSchoolSystemShow() {
        return schoolSystemShow;
    }

    public void setSchoolSystemShow(String schoolSystemShow) {
        this.schoolSystemShow = schoolSystemShow;
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

    public String getSpringAutumnFlagShow() {
        return springAutumnFlagShow;
    }

    public void setSpringAutumnFlagShow(String springAutumnFlagShow) {
        this.springAutumnFlagShow = springAutumnFlagShow;
    }

    public String getValidFlagShow() {
        return validFlagShow;
    }

    public void setValidFlagShow(String validFlagShow) {
        this.validFlagShow = validFlagShow;
    }

    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }

    public String getMajorName() {
        return majorName;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getMajorDirection() {
        return majorDirection;
    }

    public void setMajorDirection(String majorDirection) {
        this.majorDirection = majorDirection;
    }

    public String getSchoolSystem() {
        return schoolSystem;
    }

    public void setSchoolSystem(String schoolSystem) {
        this.schoolSystem = schoolSystem;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getSpringAutumnFlag() {
        return springAutumnFlag;
    }

    public void setSpringAutumnFlag(String springAutumnFlag) {
        this.springAutumnFlag = springAutumnFlag;
    }

    public String getMajorPrincipal() {
        return majorPrincipal;
    }

    public void setMajorPrincipal(String majorPrincipal) {
        this.majorPrincipal = majorPrincipal;
    }

    public String getApprovalTime() {
        return approvalTime;
    }

    public void setApprovalTime(String approvalTime) {
        this.approvalTime = approvalTime;
    }

    public String getFirstRecruitTime() {
        return firstRecruitTime;
    }

    public void setFirstRecruitTime(String firstRecruitTime) {
        this.firstRecruitTime = firstRecruitTime;
    }


    public String getFocusCourseType() {
        return focusCourseType;
    }

    public void setFocusCourseType(String focusCourseType) {
        this.focusCourseType = focusCourseType;
    }

    public String getUniqueCourseType() {
        return uniqueCourseType;
    }

    public void setUniqueCourseType(String uniqueCourseType) {
        this.uniqueCourseType = uniqueCourseType;
    }

    public String getMajorDirectionCode() {
        return majorDirectionCode;
    }

    public void setMajorDirectionCode(String majorDirectionCode) {
        this.majorDirectionCode = majorDirectionCode;
    }

    public String getMaxYear() {
        return maxYear;
    }

    public void setMaxYear(String maxYear) {
        this.maxYear = maxYear;
    }

    public String getMajorSchool() {
        return majorSchool;
    }

    public void setMajorSchool(String majorSchool) {
        this.majorSchool = majorSchool;
    }

    public String getOrdersStudentnum() {
        return ordersStudentnum;
    }

    public void setOrdersStudentnum(String ordersStudentnum) {
        this.ordersStudentnum = ordersStudentnum;
    }

    public String getClassNum() {
        return classNum;
    }

    public void setClassNum(String classNum) {
        this.classNum = classNum;
    }

    public String getOrdersClassnum() {
        return ordersClassnum;
    }

    public void setOrdersClassnum(String ordersClassnum) {
        this.ordersClassnum = ordersClassnum;
    }

    public String getMajorNow() {
        return majorNow;
    }

    public void setMajorNow(String majorNow) {
        this.majorNow = majorNow;
    }

    public String getMajorGlobal() {
        return majorGlobal;
    }

    public void setMajorGlobal(String majorGlobal) {
        this.majorGlobal = majorGlobal;
    }

    public String getEndRecruittime() {
        return endRecruittime;
    }

    public void setEndRecruittime(String endRecruittime) {
        this.endRecruittime = endRecruittime;
    }

    public String getStudentnumShow() {
        return StudentnumShow;
    }

    public void setStudentnumShow(String studentnumShow) {
        StudentnumShow = studentnumShow;
    }

    public String getClassNumShow() {
        return classNumShow;
    }

    public void setClassNumShow(String classNumShow) {
        this.classNumShow = classNumShow;
    }

    public String getOrdersClassnumShow() {
        return ordersClassnumShow;
    }

    public void setOrdersClassnumShow(String ordersClassnumShow) {
        this.ordersClassnumShow = ordersClassnumShow;
    }

    public String getDirectionCodeShow() {
        return directionCodeShow;
    }

    public void setDirectionCodeShow(String directionCodeShow) {
        this.directionCodeShow = directionCodeShow;
    }

    public String getMajorNowShow() {
        return majorNowShow;
    }

    public void setMajorNowShow(String majorNowShow) {
        this.majorNowShow = majorNowShow;
    }

    public String getMajorSchoolShow() {
        return majorSchoolShow;
    }

    public void setMajorSchoolShow(String majorSchoolShow) {
        this.majorSchoolShow = majorSchoolShow;
    }

    public String getMajorGlobalShow() {
        return majorGlobalShow;
    }

    public void setMajorGlobalShow(String majorGlobalShow) {
        this.majorGlobalShow = majorGlobalShow;
    }

    public String getFocusTypeShow() {
        return focusTypeShow;
    }

    public void setFocusTypeShow(String focusTypeShow) {
        this.focusTypeShow = focusTypeShow;
    }

    public String getUniqueTypeShow() {
        return uniqueTypeShow;
    }

    public void setUniqueTypeShow(String uniqueTypeShow) {
        this.uniqueTypeShow = uniqueTypeShow;
    }

    public String getProfessionCharact() {
        return professionCharact;
    }

    public void setProfessionCharact(String professionCharact) {
        this.professionCharact = professionCharact;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
    }

    public String getSourceNumberOne() {
        return sourceNumberOne;
    }

    public void setSourceNumberOne(String sourceNumberOne) {
        this.sourceNumberOne = sourceNumberOne;
    }

    public String getSourceNumberTwo() {
        return sourceNumberTwo;
    }

    public void setSourceNumberTwo(String sourceNumberTwo) {
        this.sourceNumberTwo = sourceNumberTwo;
    }

    public String getSourceNumberThree() {
        return sourceNumberThree;
    }

    public void setSourceNumberThree(String sourceNumberThree) {
        this.sourceNumberThree = sourceNumberThree;
    }

    public String getMajorNumber() {
        return majorNumber;
    }

    public void setMajorNumber(String majorNumber) {
        this.majorNumber = majorNumber;
    }

    public String getClassNumber() {
        return classNumber;
    }

    public void setClassNumber(String classNumber) {
        this.classNumber = classNumber;
    }

    public String getMaxYearShow() {
        return maxYearShow;
    }

    public void setMaxYearShow(String maxYearShow) {
        this.maxYearShow = maxYearShow;
    }
}
