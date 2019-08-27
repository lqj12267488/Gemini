package com.goisan.studentwork.employments.bean;

/**
 * Created by hanyu on 2017/8/11.
 */
public class EmploymentManage extends Employments{
    private String employmentId;//就业id
    private String studentId;//学生id
    private String classId;//班级id
    private String sex;//性别，使用XB字典
    private String idcard;//身份证号
    private String tel;//手机
    private String departmentsId;//系部ID
    private String majorCode;//专业代码
    private String trainingLevel;//培养层次
    private String employmentUnitId;//就业单位ID
    private String employmentPositions;//就业岗位
    private String employmentYear;//上岗时间
    private String area;//地区
    private String employmentType;//就业形式，使用SXXS字典,，1校方安排，2自谋
    private String majorMatchFlag;//是否专业对口，使用SF字典，0否，1是
    private String salary;//工资收入水平，使用GZSRSP字典
    private String signContract;//是否签订合同
    private String employmentInsuranceType;//就业保险类型，使用字典JYBXXZ
    private String employmentSatisfaction;//就业满意度，使用字典JYMYD
    private String studentNumber;//学籍号
    private String studentIdShow;
    private String classIdShow;
    private String sexShow;
    private String departmentsIdShow;
    private String majorCodeShow;
    private String trainingLevelShow;
    private String employmentUnitIdShow;
    private String employmentTypeShow;
    private String majorMatchFlagShow;
    private String salaryShow;
    private String employmentEvaluationShow;
    private String signContractShow;
    private String employmentInsuranceTypeShow;
    private String employmentSatisfactionShow;
    private String departmentsIdPersonNumber;
    private String majorCodePersonNumber;
    private String employmentPersonNumber;
    private String salaryPersonNumber;
    private String departmentsIdShow3;

    public String getDepartmentsIdPersonNumber() {
        return departmentsIdPersonNumber;
    }

    public void setDepartmentsIdPersonNumber(String departmentsIdPersonNumber) {
        this.departmentsIdPersonNumber = departmentsIdPersonNumber;
    }

    public String getMajorCodePersonNumber() {
        return majorCodePersonNumber;
    }

    public void setMajorCodePersonNumber(String majorCodePersonNumber) {
        this.majorCodePersonNumber = majorCodePersonNumber;
    }

    public String getEmploymentPersonNumber() {
        return employmentPersonNumber;
    }

    public void setEmploymentPersonNumber(String employmentPersonNumber) {
        this.employmentPersonNumber = employmentPersonNumber;
    }

    public String getSalaryPersonNumber() {
        return salaryPersonNumber;
    }

    public void setSalaryPersonNumber(String salaryPersonNumber) {
        this.salaryPersonNumber = salaryPersonNumber;
    }

    public String getEmploymentId() {
        return employmentId;
    }

    public void setEmploymentId(String employmentId) {
        this.employmentId = employmentId;
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

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
    }

    public String getSignContract() {
        return signContract;
    }

    public void setSignContract(String signContract) {
        this.signContract = signContract;
    }

    public String getEmploymentInsuranceType() {
        return employmentInsuranceType;
    }

    public void setEmploymentInsuranceType(String employmentInsuranceType) {
        this.employmentInsuranceType = employmentInsuranceType;
    }

    public String getEmploymentSatisfaction() {
        return employmentSatisfaction;
    }

    public void setEmploymentSatisfaction(String employmentSatisfaction) {
        this.employmentSatisfaction = employmentSatisfaction;
    }

    public String getEmploymentPositions() {
        return employmentPositions;
    }

    public void setEmploymentPositions(String employmentPositions) {
        this.employmentPositions = employmentPositions;
    }

    public String getEmploymentYear() {
        return employmentYear;
    }

    public void setEmploymentYear(String employmentYear) {
        this.employmentYear = employmentYear;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getEmploymentType() {
        return employmentType;
    }

    public void setEmploymentType(String employmentType) {
        this.employmentType = employmentType;
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

    @Override
    public String getEmploymentUnitId() {
        return employmentUnitId;
    }

    @Override
    public void setEmploymentUnitId(String employmentUnitId) {
        this.employmentUnitId = employmentUnitId;
    }

    @Override
    public String getEmploymentUnitIdShow() {
        return employmentUnitIdShow;
    }

    @Override
    public void setEmploymentUnitIdShow(String employmentUnitIdShow) {
        this.employmentUnitIdShow = employmentUnitIdShow;
    }

    public String getEmploymentTypeShow() {
        return employmentTypeShow;
    }

    public void setEmploymentTypeShow(String employmentTypeShow) {
        this.employmentTypeShow = employmentTypeShow;
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

    public String getEmploymentEvaluationShow() {
        return employmentEvaluationShow;
    }

    public void setEmploymentEvaluationShow(String employmentEvaluationShow) {
        this.employmentEvaluationShow = employmentEvaluationShow;
    }

    public String getSignContractShow() {
        return signContractShow;
    }

    public void setSignContractShow(String signContractShow) {
        this.signContractShow = signContractShow;
    }

    public String getEmploymentInsuranceTypeShow() {
        return employmentInsuranceTypeShow;
    }

    public void setEmploymentInsuranceTypeShow(String employmentInsuranceTypeShow) {
        this.employmentInsuranceTypeShow = employmentInsuranceTypeShow;
    }

    public String getEmploymentSatisfactionShow() {
        return employmentSatisfactionShow;
    }

    public void setEmploymentSatisfactionShow(String employmentSatisfactionShow) {
        this.employmentSatisfactionShow = employmentSatisfactionShow;
    }

    public String getDepartmentsIdShow3() {
        return departmentsIdShow3;
    }

    public void setDepartmentsIdShow3(String departmentsIdShow3) {
        this.departmentsIdShow3 = departmentsIdShow3;
    }
}
