package com.goisan.studentwork.internships.bean;

/**
 * Created by hanyu on 2017/8/1.
 */
public class InternshipManage extends InternshipChangeLog{
    private String internshipId;//实习id
    private String studentId;//学生id
    private String classId;//班级id
    private String sex;//性别，使用XB字典
    private String idcard;//身份证号
    private String tel;//手机
    private String departmentsId;//系部ID
    private String majorCode;//专业代码
    private String trainingLevel;//培养层次
    private String internshipUnitId;//实习单位ID
    private String internshipPositions;//实习岗位
    private String postsTime;//上岗时间
    private String area;//地区
    private String internshipType;//实习形式，使用SXXS字典,，1校方安排，2自谋
    private String majorMatchFlag;//是否专业对口，使用SF字典，0否，1是
    private String salary;//工资收入水平，使用GZSRSP字典
    private String internshipChangeFlag;//实习变动情况，使用SXBDQK字典
    private String internshipScore;//实习评分
    private String internshipEvaluation;//实习评价，使用SXPJ字典
    private String studentNumber;//学籍号
    private String parentTel;//家长电话
    private String studentIdShow;
    private String classIdShow;
    private String sexShow;
    private String departmentsIdShow;
    private String majorCodeShow;
    private String trainingLevelShow;
    private String internshipUnitIdShow;
    private String internshipTypeShow;
    private String majorMatchFlagShow;
    private String salaryShow;
    private String internshipChangeFlagShow;
    private String internshipEvaluationShow;

    public String getParentTel() {
        return parentTel;
    }

    public void setParentTel(String parentTel) {
        this.parentTel = parentTel;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
    }

    public String getStudentIdShow() {
        return studentIdShow;
    }

    public void setStudentIdShow(String studentIdShow) {
        this.studentIdShow = studentIdShow;
    }

    public String getClassIdShow() {
        return classIdShow;
    }

    public void setClassIdShow(String classIdShow) {
        this.classIdShow = classIdShow;
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }

    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getMajorCodeShow() {
        return majorCodeShow;
    }

    public void setMajorCodeShow(String majorCodeShow) {
        this.majorCodeShow = majorCodeShow;
    }

    public String getTrainingLevelShow() {
        return trainingLevelShow;
    }

    public void setTrainingLevelShow(String trainingLevelShow) {
        this.trainingLevelShow = trainingLevelShow;
    }

    public String getInternshipUnitIdShow() {
        return internshipUnitIdShow;
    }

    public void setInternshipUnitIdShow(String internshipUnitIdShow) {
        this.internshipUnitIdShow = internshipUnitIdShow;
    }

    public String getInternshipTypeShow() {
        return internshipTypeShow;
    }

    public void setInternshipTypeShow(String internshipTypeShow) {
        this.internshipTypeShow = internshipTypeShow;
    }

    public String getMajorMatchFlagShow() {
        return majorMatchFlagShow;
    }

    public void setMajorMatchFlagShow(String majorMatchFlagShow) {
        this.majorMatchFlagShow = majorMatchFlagShow;
    }

    public String getSalaryShow() {
        return salaryShow;
    }

    public void setSalaryShow(String salaryShow) {
        this.salaryShow = salaryShow;
    }

    public String getInternshipChangeFlagShow() {
        return internshipChangeFlagShow;
    }

    public void setInternshipChangeFlagShow(String internshipChangeFlagShow) {
        this.internshipChangeFlagShow = internshipChangeFlagShow;
    }



    public String getInternshipUnitId() {
        return internshipUnitId;
    }

    public void setInternshipUnitId(String internshipUnitId) {
        this.internshipUnitId = internshipUnitId;
    }

    public String getInternshipId() {
        return internshipId;
    }

    public void setInternshipId(String internshipId) {
        this.internshipId = internshipId;
    }

    public String getInternshipPositions() {
        return internshipPositions;
    }

    public void setInternshipPositions(String internshipPositions) {
        this.internshipPositions = internshipPositions;
    }

    public String getPostsTime() {
        return postsTime;
    }

    public void setPostsTime(String postsTime) {
        this.postsTime = postsTime;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getInternshipType() {
        return internshipType;
    }

    public void setInternshipType(String internshipType) {
        this.internshipType = internshipType;
    }

    public String getMajorMatchFlag() {
        return majorMatchFlag;
    }

    public void setMajorMatchFlag(String majorMatchFlag) {
        this.majorMatchFlag = majorMatchFlag;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public String getInternshipChangeFlag() {
        return internshipChangeFlag;
    }

    public void setInternshipChangeFlag(String internshipChangeFlag) {
        this.internshipChangeFlag = internshipChangeFlag;
    }

    public String getInternshipScore() {
        return internshipScore;
    }

    public void setInternshipScore(String internshipScore) {
        this.internshipScore = internshipScore;
    }

    public String getInternshipEvaluation() {
        return internshipEvaluation;
    }

    public void setInternshipEvaluation(String internshipEvaluation) {
        this.internshipEvaluation = internshipEvaluation;
    }

    public String getInternshipEvaluationShow() {
        return internshipEvaluationShow;
    }

    public void setInternshipEvaluationShow(String internshipEvaluationShow) {
        this.internshipEvaluationShow = internshipEvaluationShow;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
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

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
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
}
