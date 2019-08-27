package com.goisan.educational.major.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/5/18.
 */
public class MajorLeader extends BaseBean {
    private String id;
    private String personId;//人员ID
    private String personIdShow;
    private String departmentsId;//系部
    private String departmentsIdShow;
    private String majorId;//专业ID
    private String majorIdShow;
    private String majorCode;//专业代码
    private String sex;//性别
    private String sexShow;
    private String birthday;//生日
    private String politicalStatus;//政治面貌
    private String education;//学历
    private String educationShow;
    private String degree;//学位
    private String degreeShow;
    private String teacherSchool;//毕业院校
    private String teacherMajor;//所学专业
    private String position;//职务
    private String positionName;//专业技术职务名称
    private String positionLeave;//专业技术等级
    private String office;//发证单位
    private String positionDate;//专业技术职务名称获得时间
    private String email;//邮箱
    /*private String researchResult;//科研成果名称
    private String researchLeave;//科研成果等级
    private String researchDate,researchInfo;//科研成果获得时间,科研成果简介
    private String remark;//合作情况*/
    private String personType;//人员类型:1专业带头人 2专业负责人 3专业骨干教师
    private String teacherNum,workDept,guHua,zyWorkDate;//教工号,工作单位名称,区号单位电话, 担任专业带头人工作年限（年）
    private String teacherCategory,teacherCategoryShow;//教师性质
    private String birthdayShow;

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
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

    public String getPoliticalStatus() {
        return politicalStatus;
    }

    public void setPoliticalStatus(String politicalStatus) {
        this.politicalStatus = politicalStatus;
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

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getDegreeShow() {
        return degreeShow;
    }

    public void setDegreeShow(String degreeShow) {
        this.degreeShow = degreeShow;
    }

    public String getTeacherSchool() {
        return teacherSchool;
    }

    public void setTeacherSchool(String teacherSchool) {
        this.teacherSchool = teacherSchool;
    }

    public String getTeacherMajor() {
        return teacherMajor;
    }

    public void setTeacherMajor(String teacherMajor) {
        this.teacherMajor = teacherMajor;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getPositionLeave() {
        return positionLeave;
    }

    public void setPositionLeave(String positionLeave) {
        this.positionLeave = positionLeave;
    }

    public String getOffice() {
        return office;
    }

    public void setOffice(String office) {
        this.office = office;
    }

    public String getPositionDate() {
        return positionDate;
    }

    public void setPositionDate(String positionDate) {
        this.positionDate = positionDate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

   /* public String getResearchResult() {
        return researchResult;
    }

    public void setResearchResult(String researchResult) {
        this.researchResult = researchResult;
    }

    public String getResearchLeave() {
        return researchLeave;
    }

    public void setResearchLeave(String researchLeave) {
        this.researchLeave = researchLeave;
    }

    public String getResearchDate() {
        return researchDate;
    }

    public void setResearchDate(String researchDate) {
        this.researchDate = researchDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }*/

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }

    public String getMajorIdShow() {
        return majorIdShow;
    }

    public void setMajorIdShow(String majorIdShow) {
        this.majorIdShow = majorIdShow;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
    }

    public String getTeacherNum() {
        return teacherNum;
    }

    public void setTeacherNum(String teacherNum) {
        this.teacherNum = teacherNum;
    }

    public String getWorkDept() {
        return workDept;
    }

    public void setWorkDept(String workDept) {
        this.workDept = workDept;
    }

    public String getGuHua() {
        return guHua;
    }

    public void setGuHua(String guHua) {
        this.guHua = guHua;
    }

    public String getZyWorkDate() {
        return zyWorkDate;
    }

    public void setZyWorkDate(String zyWorkDate) {
        this.zyWorkDate = zyWorkDate;
    }

    /*public String getResearchInfo() {
        return researchInfo;
    }

    public void setResearchInfo(String researchInfo) {
        this.researchInfo = researchInfo;
    }*/

    public String getTeacherCategory() {
        return teacherCategory;
    }

    public void setTeacherCategory(String teacherCategory) {
        this.teacherCategory = teacherCategory;
    }

    public String getTeacherCategoryShow() {
        return teacherCategoryShow;
    }

    public void setTeacherCategoryShow(String teacherCategoryShow) {
        this.teacherCategoryShow = teacherCategoryShow;
    }

    public String getBirthdayShow() {
        return birthdayShow;
    }

    public void setBirthdayShow(String birthdayShow) {
        this.birthdayShow = birthdayShow;
    }
}
