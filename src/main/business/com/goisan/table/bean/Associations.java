package com.goisan.table.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Associations extends BaseBean {

    /**主键使用uuid*/
    private String id;

    /**序号*/
    private String ordernumber;

    /**社团代码*/
    private String communitycode;

    /**社团名称*/
    private String communityname;

    /**社团类别*/
    private String communitycategory;

    /**登记日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date registrationdate;

    /**批准单位*/
    private String approvaldepartment;

    /**注册单位*/
    private String registrantorganization;

    /**现有成员*/
    private String existingmember;

    /**姓名*/
    private String name;

    /**所在年级*/
    private String grade;

    /**活动经费*/
    private String money;

    /**是否设有学分(学时)*/
    private String credit;

    /**是否有获奖项目*/
    private String awards;

    /**学校指导部门*/
    private String guidancedepartment;

    /**指导教师名单*/
    private String instructors;

    private String registrationdateStr;

    private String groupNameSel;

    public String getRegistrationdateStr() {
        return registrationdateStr;
    }

    public void setRegistrationdateStr(String registrationdateStr) {
        this.registrationdateStr = registrationdateStr;
    }

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

    public String getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(String ordernumber) {
        this.ordernumber = ordernumber;
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

    public String getCommunitycategory() {
        return communitycategory;
    }

    public void setCommunitycategory(String communitycategory) {
        this.communitycategory = communitycategory;
    }

    public Date getRegistrationdate() {
        return registrationdate;
    }

    public void setRegistrationdate(Date registrationdate) {
        this.registrationdate = registrationdate;
    }

    public String getApprovaldepartment() {
        return approvaldepartment;
    }

    public void setApprovaldepartment(String approvaldepartment) {
        this.approvaldepartment = approvaldepartment;
    }

    public String getRegistrantorganization() {
        return registrantorganization;
    }

    public void setRegistrantorganization(String registrantorganization) {
        this.registrantorganization = registrantorganization;
    }

    public String getExistingmember() {
        return existingmember;
    }

    public void setExistingmember(String existingmember) {
        this.existingmember = existingmember;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }

    public String getAwards() {
        return awards;
    }

    public void setAwards(String awards) {
        this.awards = awards;
    }

    public String getGuidancedepartment() {
        return guidancedepartment;
    }

    public void setGuidancedepartment(String guidancedepartment) {
        this.guidancedepartment = guidancedepartment;
    }

    public String getInstructors() {
        return instructors;
    }

    public void setInstructors(String instructors) {
        this.instructors = instructors;
    }

}
