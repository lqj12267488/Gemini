package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class InformationPersonnel extends BaseBean {

    /**主键id*/
    private String id;

    /**机构代码*/
    private String organizationCode;

    /**机构名称(全称)*/
    private String organizationName;

    /**负责人教工号*/
    private String personStaff;

    /**负责人姓名*/
    private String personName;

    /**专职人员数（个）*/
    private String staffNumber;

    /**兼职人员数（个）*/
    private String employeNumber;

    /*年度 使用ND字典*/
    private String year ;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrganizationCode() {
        return organizationCode;
    }

    public void setOrganizationCode(String organizationCode) {
        this.organizationCode = organizationCode;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public String getPersonStaff() {
        return personStaff;
    }

    public void setPersonStaff(String personStaff) {
        this.personStaff = personStaff;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getStaffNumber() {
        return staffNumber;
    }

    public void setStaffNumber(String staffNumber) {
        this.staffNumber = staffNumber;
    }

    public String getEmployeNumber() {
        return employeNumber;
    }

    public void setEmployeNumber(String employeNumber) {
        this.employeNumber = employeNumber;
    }

}
