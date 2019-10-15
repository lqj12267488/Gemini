package com.goisan.table.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class TeacherSchool extends BaseBean {

    /**主键使用uuid*/
    private String id;

    /**教职工id*/
    private String personid;

    /**是否主持 1是0否*/
    private String whetherhost;

    /**技术专利(发明)编号*/
    private String inventnumber;

    /**课题性质*/
    private String topicnature;

    /**课题分类*/
    private String subjectclassification;

    /**课题名称*/
    private String subjectname;

    /**是否横向课题 1是0否*/
    private String horizontaltopic;

    /**课题级别*/
    private String subjectgrade;

    /**立项日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date projectdate;

    /**经费来源*/
    private String sourceoffunding;

    /**到款金额 */
    private String money;

    /**完成人顺序 */
    private String completororder;

    /**著作与论文分类 */
    private String classification;

    /**作者顺序 */
    private String authororder;

    /**类型 1专任教师其他情况  2兼课人员其他情况 */
    private String type;

    private String personidvalue;

    private String person;

    private String projectdateStr;

    private String groupNameSel;

    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGroupNameSel() {
        return groupNameSel;
    }

    public void setGroupNameSel(String groupNameSel) {
        this.groupNameSel = groupNameSel;
    }

    public String getProjectdateStr() {
        return projectdateStr;
    }

    public void setProjectdateStr(String projectdateStr) {
        this.projectdateStr = projectdateStr;
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

    public String getWhetherhost() {
        return whetherhost;
    }

    public void setWhetherhost(String whetherhost) {
        this.whetherhost = whetherhost;
    }

    public String getInventnumber() {
        return inventnumber;
    }

    public void setInventnumber(String inventnumber) {
        this.inventnumber = inventnumber;
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


    public Date getProjectdate() {
        return projectdate;
    }

    public void setProjectdate(Date projectdate) {
        this.projectdate = projectdate;
    }

    public String getSourceoffunding() {
        return sourceoffunding;
    }

    public void setSourceoffunding(String sourceoffunding) {
        this.sourceoffunding = sourceoffunding;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getCompletororder() {
        return completororder;
    }

    public void setCompletororder(String completororder) {
        this.completororder = completororder;
    }

    public String getClassification() {
        return classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    public String getAuthororder() {
        return authororder;
    }

    public void setAuthororder(String authororder) {
        this.authororder = authororder;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

}
