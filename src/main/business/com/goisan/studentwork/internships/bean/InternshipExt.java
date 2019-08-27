package com.goisan.studentwork.internships.bean;


import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/8/1.
 */
public class InternshipExt extends BaseBean{
    private String id;//主键id
    private String internshipUnitId;//实习单位ID
    private String departmentsId;//系部ID
    private String receiveNumber;//接收实习生数量
    private String salary;//补贴工资，使用GZSRSP字典
    private String internshipUnitIdShow;
    private String departmentsIdShow;
    private String salaryShow;

    public String getSalaryShow() {
        return salaryShow;
    }

    public void setSalaryShow(String salaryShow) {
        this.salaryShow = salaryShow;
    }

    public String getInternshipUnitIdShow() {
        return internshipUnitIdShow;
    }

    public void setInternshipUnitIdShow(String internshipUnitIdShow) {
        this.internshipUnitIdShow = internshipUnitIdShow;
    }

    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getInternshipUnitId() {
        return internshipUnitId;
    }

    public void setInternshipUnitId(String internshipUnitId) {
        this.internshipUnitId = internshipUnitId;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getReceiveNumber() {
        return receiveNumber;
    }

    public void setReceiveNumber(String receiveNumber) {
        this.receiveNumber = receiveNumber;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }
}
