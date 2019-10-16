package com.goisan.table.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class RedCross extends BaseBean {

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

    /**总数*/
    private String moneynum;

    /**上交*/
    private String handin;

    /**留存自用*/
    private String self;

    /**姓名*/
    private String name;

    /**单位职务*/
    private String job;

    /**总数*/
    private String fundssum;

    /**会费*/
    private String membershipdues;

    /**学校拨款*/
    private String appropriatefunds;

    /**留存自用的捐款*/
    private String contributemoney;

    /**其他*/
    private String other;

    /**总数*/
    private String contributesum;

    /**上交业务主管单位*/
    private String governingbody;

    /**留存自用*/
    private String selfpreservation;

    /**主要活动内容*/
    private String activitycontent;

    /**总数*/
    private String personsum;

    /**获得证书数*/
    private String certificatenumber;

    /**采集数 */
    private String collectionnumber;

    /**配对数 */
    private String pairingnumber;

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

    public String getMoneynum() {
        return moneynum;
    }

    public void setMoneynum(String moneynum) {
        this.moneynum = moneynum;
    }

    public String getHandin() {
        return handin;
    }

    public void setHandin(String handin) {
        this.handin = handin;
    }

    public String getSelf() {
        return self;
    }

    public void setSelf(String self) {
        this.self = self;
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

    public String getFundssum() {
        return fundssum;
    }

    public void setFundssum(String fundssum) {
        this.fundssum = fundssum;
    }

    public String getMembershipdues() {
        return membershipdues;
    }

    public void setMembershipdues(String membershipdues) {
        this.membershipdues = membershipdues;
    }

    public String getAppropriatefunds() {
        return appropriatefunds;
    }

    public void setAppropriatefunds(String appropriatefunds) {
        this.appropriatefunds = appropriatefunds;
    }

    public String getContributemoney() {
        return contributemoney;
    }

    public void setContributemoney(String contributemoney) {
        this.contributemoney = contributemoney;
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other;
    }

    public String getContributesum() {
        return contributesum;
    }

    public void setContributesum(String contributesum) {
        this.contributesum = contributesum;
    }

    public String getGoverningbody() {
        return governingbody;
    }

    public void setGoverningbody(String governingbody) {
        this.governingbody = governingbody;
    }

    public String getSelfpreservation() {
        return selfpreservation;
    }

    public void setSelfpreservation(String selfpreservation) {
        this.selfpreservation = selfpreservation;
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

    public String getCollectionnumber() {
        return collectionnumber;
    }

    public void setCollectionnumber(String collectionnumber) {
        this.collectionnumber = collectionnumber;
    }

    public String getPairingnumber() {
        return pairingnumber;
    }

    public void setPairingnumber(String pairingnumber) {
        this.pairingnumber = pairingnumber;
    }

}
