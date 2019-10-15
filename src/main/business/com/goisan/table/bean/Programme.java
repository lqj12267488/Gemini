package com.goisan.table.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Programme extends BaseBean {

    /**主键使用uuid*/
    private String id;

    /**序号*/
    private String ordernumber;

    /**项目名称*/
    private String projectname;

    /**项目类别*/
    private String projectprogramme;

    /**级别*/
    private String grade;

    private String ratifydateStr;


    /**批准日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date ratifydate;

    /**人员名单*/
    private String staff;

    /**备注*/
    private String remarks;

    private String groupNameSel;

    public String getGroupNameSel() {
        return groupNameSel;
    }

    public void setGroupNameSel(String groupNameSel) {
        this.groupNameSel = groupNameSel;
    }

    public String getRatifydateStr() {
        return ratifydateStr;
    }

    public void setRatifydateStr(String ratifydateStr) {
        this.ratifydateStr = ratifydateStr;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(String ordernumber) {
        this.ordernumber = ordernumber;
    }

    public String getProjectname() {
        return projectname;
    }

    public void setProjectname(String projectname) {
        this.projectname = projectname;
    }

    public String getProjectprogramme() {
        return projectprogramme;
    }

    public void setProjectprogramme(String projectprogramme) {
        this.projectprogramme = projectprogramme;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public Date getRatifydate() {
        return ratifydate;
    }

    public void setRatifydate(Date ratifydate) {
        this.ratifydate = ratifydate;
    }

    public String getStaff() {
        return staff;
    }

    public void setStaff(String staff) {
        this.staff = staff;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

}
