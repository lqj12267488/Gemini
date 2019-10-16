package com.goisan.table.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Volunteers extends BaseBean {

    /**主键使用uuid*/
    private String id;

    /**学校分管部门*/
    private String department;

    /**社团代码*/
    private String communitycode;

    /**社团名称*/
    private String communityname;

    /**成立日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date founddate;

    private String founddateStr;
    /**总数*/
    private String sum;

    /**教工数*/
    private String teachingstaffnumber;

    /**学生数*/
    private String studentnumber;

    /**姓名*/
    private String name;

    /**单位职务*/
    private String job;

    /**主要活动内容*/
    private String activitycontent;

    /**总数(人次)*/
    private String personsum;

    /**获得证书数*/
    private String certificatenumber;

    private String groupNameSel;

    public String getGroupNameSel() {
        return groupNameSel;
    }

    public void setGroupNameSel(String groupNameSel) {
        this.groupNameSel = groupNameSel;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getCommunitycode() {
        return communitycode;
    }

    public void setCommunitycode(String communitycode) {
        this.communitycode = communitycode;
    }

    public String getCommunityname() {
        return communityname;
    }

    public void setCommunityname(String communityname) {
        this.communityname = communityname;
    }

    public Date getFounddate() {
        return founddate;
    }

    public void setFounddate(Date founddate) {
        this.founddate = founddate;
    }

    public String getFounddateStr() {
        return founddateStr;
    }

    public void setFounddateStr(String founddateStr) {
        this.founddateStr = founddateStr;
    }

    public String getSum() {
        return sum;
    }

    public void setSum(String sum) {
        this.sum = sum;
    }

    public String getTeachingstaffnumber() {
        return teachingstaffnumber;
    }

    public void setTeachingstaffnumber(String teachingstaffnumber) {
        this.teachingstaffnumber = teachingstaffnumber;
    }

    public String getStudentnumber() {
        return studentnumber;
    }

    public void setStudentnumber(String studentnumber) {
        this.studentnumber = studentnumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getActivitycontent() {
        return activitycontent;
    }

    public void setActivitycontent(String activitycontent) {
        this.activitycontent = activitycontent;
    }

    public String getPersonsum() {
        return personsum;
    }

    public void setPersonsum(String personsum) {
        this.personsum = personsum;
    }

    public String getCertificatenumber() {
        return certificatenumber;
    }

    public void setCertificatenumber(String certificatenumber) {
        this.certificatenumber = certificatenumber;
    }

}
