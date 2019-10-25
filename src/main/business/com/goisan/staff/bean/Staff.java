package com.goisan.staff.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Staff extends BaseBean {

    private String id;

    /**教职工id*/
    private String personid;

    /**等级*/
    private String grade;
    private String gradeShow;
    /**名称*/
    private String givenname;

    /**发证单位*/
    private String issuer;

    /**获取日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date getdate;

    public Date getGetdate() {
        return getdate;
    }

    /**从事教学管理年限*/
    private String teachingmanagement;

    /**从事学生管理年限*/
    private String studentmanagement;

    /**是否专职政治辅导员  1是 0否*/
    private String politicalcounselor;

    /**是否专职心理咨询师  1是  0否*/
    private String psychologicalconsultant;

    /**从事招生就业工作年限*/
    private String employmentoffice;

    /**专业领域*/
    private String expertise;

    /**周工作小时数*/
    private String workinghours;

    /**岗位职能*/
    private String postfunction;

    /**本岗位工作年限*/
    private String workingyears;

    public String getPostfunction() {
        return postfunction;
    }

    public void setPostfunction(String postfunction) {
        this.postfunction = postfunction;
    }

    public String getWorkingyears() {
        return workingyears;
    }

    public void setWorkingyears(String workingyears) {
        this.workingyears = workingyears;
    }

    private String personidvalue;

    private String person;

    private String getDateStr;

    private String type;

    private String name;

    private String post;

    private String deptName;

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }


    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    private String groupNameSel;

    public String getGroupNameSel() {
        return groupNameSel;
    }

    public void setGroupNameSel(String groupNameSel) {
        this.groupNameSel = groupNameSel;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getGetDateStr() {
        return getDateStr;
    }

    public void setGetDateStr(String getDateStr) {
        this.getDateStr = getDateStr;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public void setGetdate(Date getdate) {
        this.getdate = getdate;
    }

    public String getPersonidvalue() {
        return personidvalue;
    }

    public void setPersonidvalue(String personidvalue) {
        this.personidvalue = personidvalue;
    }

    public String getPersonid() {
        return personid;
    }

    public void setPersonid(String personid) {
        this.personid = personid;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getGivenname() {
        return givenname;
    }

    public void setGivenname(String givenname) {
        this.givenname = givenname;
    }

    public String getIssuer() {
        return issuer;
    }

    public void setIssuer(String issuer) {
        this.issuer = issuer;
    }



    public String getTeachingmanagement() {
        return teachingmanagement;
    }

    public void setTeachingmanagement(String teachingmanagement) {
        this.teachingmanagement = teachingmanagement;
    }

    public String getStudentmanagement() {
        return studentmanagement;
    }

    public void setStudentmanagement(String studentmanagement) {
        this.studentmanagement = studentmanagement;
    }

    public String getPoliticalcounselor() {
        return politicalcounselor;
    }

    public void setPoliticalcounselor(String politicalcounselor) {
        this.politicalcounselor = politicalcounselor;
    }

    public String getPsychologicalconsultant() {
        return psychologicalconsultant;
    }

    public void setPsychologicalconsultant(String psychologicalconsultant) {
        this.psychologicalconsultant = psychologicalconsultant;
    }

    public String getEmploymentoffice() {
        return employmentoffice;
    }

    public void setEmploymentoffice(String employmentoffice) {
        this.employmentoffice = employmentoffice;
    }

    public String getExpertise() {
        return expertise;
    }

    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    public String getWorkinghours() {
        return workinghours;
    }

    public void setWorkinghours(String workinghours) {
        this.workinghours = workinghours;
    }
    public String getGradeShow() {
        return gradeShow;
    }

    public void setGradeShow(String gradeShow) {
        this.gradeShow = gradeShow;
    }

}
