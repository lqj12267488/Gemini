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
    private String internshipUnitId;//实习单位ID
    private String internshipPositions;//实习岗位
    private String internshipUnitIdShow;
    private String postsTime;//实习时间
    private String normalMajor;//是否师范专业
    private String normalMajorShow;
    private String studentsNum;//新生总人数
    private String eduform;//教育形式



    private String majornums;//设置全日制专业总数
    private String majornum;//全日制高职专业总数
    private String studentnums;//招生总数
    private String ptnum;//普通高中招生数
    private String tsnum;//三校生招生数
    private String tenum;//3+2招生数
    private String ffnum;//五年制前四学年招生数
    private String othernum;//其他招生数

    public String getPtnum() {
        return ptnum;
    }

    public void setPtnum(String ptnum) {
        this.ptnum = ptnum;
    }

    public String getTsnum() {
        return tsnum;
    }

    public void setTsnum(String tsnum) {
        this.tsnum = tsnum;
    }

    public String getTenum() {
        return tenum;
    }

    public void setTenum(String tenum) {
        this.tenum = tenum;
    }

    public String getFfnum() {
        return ffnum;
    }

    public void setFfnum(String ffnum) {
        this.ffnum = ffnum;
    }

    public String getOthernum() {
        return othernum;
    }

    public void setOthernum(String othernum) {
        this.othernum = othernum;
    }

    public String getMajornums() {
        return majornums;
    }

    public void setMajornums(String majornums) {
        this.majornums = majornums;
    }

    public String getMajornum() {
        return majornum;
    }

    public void setMajornum(String majornum) {
        this.majornum = majornum;
    }

    public String getStudentnums() {
        return studentnums;
    }

    public void setStudentnums(String studentnums) {
        this.studentnums = studentnums;
    }

    public String getEduform() {
        return eduform;
    }

    public void setEduform(String eduform) {
        this.eduform = eduform;
    }
    private String yjgraduationNumber;//应届毕业生人数
    private String area;//本省市就业人数
    private String darea;//本地市就业人数
    private String salary;//起薪线
    private String dkNumber;//对口就业人数
    private String ptgNumber;//普通高中生毕业人数
    private String ptjNumber;//普通高中生就业人数
    private String sxgNumber;//三校生毕业人数
    private String sxjNumber;//三校生就业人数
    private String wngNumber;//五年制高职毕业人数
    private String wnjNumber;//五年制高职就业人数

    private String oneNumber;//基于高考直接招生毕业人数
    private String onejNumber;//就业人数
    private String twoNumber;//基于高考就业加技能毕业人数
    private String twojNumber;//就业人数
    private String threeNumber;//对口招生毕业人数
    private String threejNumber;//就业人数
    private String fourNumber;//单独考试招生毕业人数
    private String fourjNumber;//就业人数
    private String fiveNumber;//综合评价招生毕业人数
    private String fivejNumber;//就业人数
    private String sixNumber;//中高职贯通毕业人数
    private String sixjNumber;//就业人数
    private String sevenNumber;//技能拔尖人才毕业人数
    private String sevenjNumber;//就业人数
    private String eightNumber;//补充方式毕业人数
    private String eightjNumber;//就业人数

    private String tyArmy;//当年退役军人
    private String fzArmy;//当年复转军人
    private String sumArmy;//当年合计人数
    private String tyZArmy;//在校生退役军人
    private String fzZArmy;//在校生复转军人
    private String sumZArmy;//在校生合计军人人数

    private String wsStudentNum;//外省在校生合计人数
    private String ncStudentNum;//农村在校生合计人数
    private String mzStudentNum;//民族在校生合计人数

    private String provinceNumber;//本省招生人数
    private String cityNumber;//本地市招生人数

    public String getProvinceNumber() {
        return provinceNumber;
    }

    public void setProvinceNumber(String provinceNumber) {
        this.provinceNumber = provinceNumber;
    }

    public String getCityNumber() {
        return cityNumber;
    }

    public void setCityNumber(String cityNumber) {
        this.cityNumber = cityNumber;
    }

    public String getWsStudentNum() {
        return wsStudentNum;
    }

    public void setWsStudentNum(String wsStudentNum) {
        this.wsStudentNum = wsStudentNum;
    }

    public String getNcStudentNum() {
        return ncStudentNum;
    }

    public void setNcStudentNum(String ncStudentNum) {
        this.ncStudentNum = ncStudentNum;
    }

    public String getMzStudentNum() {
        return mzStudentNum;
    }

    public void setMzStudentNum(String mzStudentNum) {
        this.mzStudentNum = mzStudentNum;
    }

    public String getSumArmy() {
        return sumArmy;
    }

    public void setSumArmy(String sumArmy) {
        this.sumArmy = sumArmy;
    }

    public String getSumZArmy() {
        return sumZArmy;
    }

    public void setSumZArmy(String sumZArmy) {
        this.sumZArmy = sumZArmy;
    }

    public String getTyArmy() {
        return tyArmy;
    }

    public void setTyArmy(String tyArmy) {
        this.tyArmy = tyArmy;
    }

    public String getFzArmy() {
        return fzArmy;
    }

    public void setFzArmy(String fzArmy) {
        this.fzArmy = fzArmy;
    }

    public String getTyZArmy() {
        return tyZArmy;
    }

    public void setTyZArmy(String tyZArmy) {
        this.tyZArmy = tyZArmy;
    }

    public String getFzZArmy() {
        return fzZArmy;
    }

    public void setFzZArmy(String fzZArmy) {
        this.fzZArmy = fzZArmy;
    }

    public String getPtgNumber() {
        return ptgNumber;
    }

    public void setPtgNumber(String ptgNumber) {
        this.ptgNumber = ptgNumber;
    }

    public String getPtjNumber() {
        return ptjNumber;
    }

    public void setPtjNumber(String ptjNumber) {
        this.ptjNumber = ptjNumber;
    }

    public String getSxgNumber() {
        return sxgNumber;
    }

    public void setSxgNumber(String sxgNumber) {
        this.sxgNumber = sxgNumber;
    }

    public String getSxjNumber() {
        return sxjNumber;
    }

    public void setSxjNumber(String sxjNumber) {
        this.sxjNumber = sxjNumber;
    }

    public String getWngNumber() {
        return wngNumber;
    }

    public void setWngNumber(String wngNumber) {
        this.wngNumber = wngNumber;
    }

    public String getWnjNumber() {
        return wnjNumber;
    }

    public void setWnjNumber(String wnjNumber) {
        this.wnjNumber = wnjNumber;
    }

    public String getOneNumber() {
        return oneNumber;
    }

    public void setOneNumber(String oneNumber) {
        this.oneNumber = oneNumber;
    }

    public String getOnejNumber() {
        return onejNumber;
    }

    public void setOnejNumber(String onejNumber) {
        this.onejNumber = onejNumber;
    }

    public String getTwoNumber() {
        return twoNumber;
    }

    public void setTwoNumber(String twoNumber) {
        this.twoNumber = twoNumber;
    }

    public String getTwojNumber() {
        return twojNumber;
    }

    public void setTwojNumber(String twojNumber) {
        this.twojNumber = twojNumber;
    }

    public String getThreeNumber() {
        return threeNumber;
    }

    public void setThreeNumber(String threeNumber) {
        this.threeNumber = threeNumber;
    }

    public String getThreejNumber() {
        return threejNumber;
    }

    public void setThreejNumber(String threejNumber) {
        this.threejNumber = threejNumber;
    }

    public String getFourNumber() {
        return fourNumber;
    }

    public void setFourNumber(String fourNumber) {
        this.fourNumber = fourNumber;
    }

    public String getFourjNumber() {
        return fourjNumber;
    }

    public void setFourjNumber(String fourjNumber) {
        this.fourjNumber = fourjNumber;
    }

    public String getFiveNumber() {
        return fiveNumber;
    }

    public void setFiveNumber(String fiveNumber) {
        this.fiveNumber = fiveNumber;
    }

    public String getFivejNumber() {
        return fivejNumber;
    }

    public void setFivejNumber(String fivejNumber) {
        this.fivejNumber = fivejNumber;
    }

    public String getSixNumber() {
        return sixNumber;
    }

    public void setSixNumber(String sixNumber) {
        this.sixNumber = sixNumber;
    }

    public String getSixjNumber() {
        return sixjNumber;
    }

    public void setSixjNumber(String sixjNumber) {
        this.sixjNumber = sixjNumber;
    }

    public String getSevenNumber() {
        return sevenNumber;
    }

    public void setSevenNumber(String sevenNumber) {
        this.sevenNumber = sevenNumber;
    }

    public String getSevenjNumber() {
        return sevenjNumber;
    }

    public void setSevenjNumber(String sevenjNumber) {
        this.sevenjNumber = sevenjNumber;
    }

    public String getEightNumber() {
        return eightNumber;
    }

    public void setEightNumber(String eightNumber) {
        this.eightNumber = eightNumber;
    }

    public String getEightjNumber() {
        return eightjNumber;
    }

    public void setEightjNumber(String eightjNumber) {
        this.eightjNumber = eightjNumber;
    }

    public String getYjgraduationNumber() {
        return yjgraduationNumber;
    }

    public void setYjgraduationNumber(String yjgraduationNumber) {
        this.yjgraduationNumber = yjgraduationNumber;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getDarea() {
        return darea;
    }

    public void setDarea(String darea) {
        this.darea = darea;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public String getDkNumber() {
        return dkNumber;
    }

    public void setDkNumber(String dkNumber) {
        this.dkNumber = dkNumber;
    }

    public String getStudentsNum() {
        return studentsNum;
    }

    public void setStudentsNum(String studentsNum) {
        this.studentsNum = studentsNum;
    }

    public String getNormalMajor() {
        return normalMajor;
    }

    public void setNormalMajor(String normalMajor) {
        this.normalMajor = normalMajor;
    }

    public String getNormalMajorShow() {
        return normalMajorShow;
    }

    public void setNormalMajorShow(String normalMajorShow) {
        this.normalMajorShow = normalMajorShow;
    }

    private String planNumber;//计划招生数
    private String realNumber;//报道人数

    private String graduationNumber;//毕业人数
    private String employmentNumber;//就业人数

    private String numberGraduates;//毕业生总人数
    private String postPractice;//顶岗实习毕业生总人数
    private String enterpriseHiring;//企业录用人数
    private String numberTrainees;//实习对口人数
    private String numberInternships;//实习单位总数
    private String numberInterns;//实习学生总数
    private String insuranceNumber;//参加保险学生数
    private String totalNumber;//实习总人数

    public String getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(String totalNumber) {
        this.totalNumber = totalNumber;
    }

    public String getInsuranceNumber() {
        return insuranceNumber;
    }

    public void setInsuranceNumber(String insuranceNumber) {
        this.insuranceNumber = insuranceNumber;
    }

    public String getNumberInterns() {
        return numberInterns;
    }

    public void setNumberInterns(String numberInterns) {
        this.numberInterns = numberInterns;
    }

    public String getNumberInternships() {
        return numberInternships;
    }

    public void setNumberInternships(String numberInternships) {
        this.numberInternships = numberInternships;
    }

    public String getNumberTrainees() {
        return numberTrainees;
    }

    public void setNumberTrainees(String numberTrainees) {
        this.numberTrainees = numberTrainees;
    }

    public String getEnterpriseHiring() {
        return enterpriseHiring;
    }

    public void setEnterpriseHiring(String enterpriseHiring) {
        this.enterpriseHiring = enterpriseHiring;
    }

    public String getPostPractice() {
        return postPractice;
    }

    public void setPostPractice(String postPractice) {
        this.postPractice = postPractice;
    }

    public String getNumberGraduates() {
        return numberGraduates;
    }

    public void setNumberGraduates(String numberGraduates) {
        this.numberGraduates = numberGraduates;
    }

    public void setInternshipUnitId(String internshipUnitId) {
        this.internshipUnitId = internshipUnitId;
    }

    public String getInternshipPositions() {
        return internshipPositions;
    }

    public void setInternshipPositions(String internshipPositions) {
        this.internshipPositions = internshipPositions;
    }

    public String getInternshipUnitIdShow() {
        return internshipUnitIdShow;
    }

    public void setInternshipUnitIdShow(String internshipUnitIdShow) {
        this.internshipUnitIdShow = internshipUnitIdShow;
    }

    public String getPostsTime() {
        return postsTime;
    }

    public void setPostsTime(String postsTime) {
        this.postsTime = postsTime;
    }

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

    public String getInternshipUnitId() {
        return internshipUnitId;
    }


}
