package com.goisan.research.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Research extends BaseBean {

    /**主键使用uuid*/
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

    /**课题性质*/
    private String topicnature;

    /**课题分类*/
    private String subjectclassification;

    /**课题名称*/
    private String subjectname;

    /**是否横向课题  1是  0否*/
    private String horizontaltopic;

    /**课题级别*/
    private String subjectgrade;

    /**立项日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date projectdate;

    /**经费来源*/
    private String sourceoffunding;

    /**完成人顺序 */
    private String completororder;

    /**到款金额 */
    private String money;

    /**数量 */
    private String num;

    /**最高等级 */
    private String highestgrade;

    /**合作情况 */
    private String cooperation;

    /**专业领域 */
    private String expertise;

    private String personidvalue;

    private String person;

    private String getDateStr;

    private String projectDateStr;

    private String name;

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


    public String getGetDateStr() {
        return getDateStr;
    }

    public void setGetDateStr(String getDateStr) {
        this.getDateStr = getDateStr;
    }

    public String getProjectDateStr() {
        return projectDateStr;
    }

    public void setProjectDateStr(String projectDateStr) {
        this.projectDateStr = projectDateStr;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getPersonidvalue() {
        return personidvalue;
    }

    public void setPersonidvalue(String personidvalue) {
        this.personidvalue = personidvalue;
    }

    public Date getGetdate() {
        return getdate;
    }

    public void setGetdate(Date getdate) {
        this.getdate = getdate;
    }

    public Date getProjectdate() {
        return projectdate;
    }

    public void setProjectdate(Date projectdate) {
        this.projectdate = projectdate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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



    public String getTopicnature() {
        return topicnature;
    }

    public void setTopicnature(String topicnature) {
        this.topicnature = topicnature;
    }

    public String getSubjectclassification() {
        return subjectclassification;
    }

    public void setSubjectclassification(String subjectclassification) {
        this.subjectclassification = subjectclassification;
    }

    public String getSubjectname() {
        return subjectname;
    }

    public void setSubjectname(String subjectname) {
        this.subjectname = subjectname;
    }

    public String getHorizontaltopic() {
        return horizontaltopic;
    }

    public void setHorizontaltopic(String horizontaltopic) {
        this.horizontaltopic = horizontaltopic;
    }

    public String getSubjectgrade() {
        return subjectgrade;
    }

    public void setSubjectgrade(String subjectgrade) {
        this.subjectgrade = subjectgrade;
    }



    public String getSourceoffunding() {
        return sourceoffunding;
    }

    public void setSourceoffunding(String sourceoffunding) {
        this.sourceoffunding = sourceoffunding;
    }

    public String getCompletororder() {
        return completororder;
    }

    public void setCompletororder(String completororder) {
        this.completororder = completororder;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getHighestgrade() {
        return highestgrade;
    }

    public void setHighestgrade(String highestgrade) {
        this.highestgrade = highestgrade;
    }

    public String getCooperation() {
        return cooperation;
    }

    public void setCooperation(String cooperation) {
        this.cooperation = cooperation;
    }

    public String getExpertise() {
        return expertise;
    }

    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    public String getGradeShow() {
        return gradeShow;
    }

    public void setGradeShow(String gradeShow) {
        this.gradeShow = gradeShow;
    }

}
