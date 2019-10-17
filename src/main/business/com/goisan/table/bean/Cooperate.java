package com.goisan.table.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Cooperate extends BaseBean {

    /**主键使用uuid*/
    private String id;

    /* 专业名称 */
    private String  MAJORNAME;

    /**共同开发课程数（门）*/
    private String developmentcoursenum;

    /**共同开发教材数（种）*/
    private String developmentteachingnum;

    /**支持学校兼职教师数（人）*/
    private String parttimeteachernum;

    /**接受顶岗实习学生数（人）*/
    private String traineenum;

    /**对学校捐赠设备总值（万元）*/
    private String equipmentmoney;

    /**对学校准捐赠设备总值(万元)*/
    private String quasidonationmoney;

    /**接受毕业生就业数（人）*/
    private String employmentnumber;

    /**学校为企业技术服务年收入（万元）*/
    private String annualincome;

    /**学校为企业年培训员工数（人天28）*/
    private String employeesnum;

    /**企业1合作开始日期（年月）*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date business1starttime;

    private String business1starttimeStr;

    /**企业2合作开始日期（年月）*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date business2starttime;

    private String business2starttimeStr;

    /**企业3合作开始日期（年月）*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date business3starttime;

    private String business3starttimeStr;

    /**企业4合作开始日期（年月）*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date business4starttime;

    private String business4starttimeStr;

    /**企业5合作开始日期（年月）*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date business5starttime;

    private String business5starttimeStr;

    /**是否合作开展学徒制专业*/
    private String apprenticeship;

    private String groupNameSel;

    public String getMojorName() {
        return MAJORNAME;
    }

    public String getMAJORNAME() {
        return MAJORNAME;
    }

    public void setMAJORNAME(String MAJORNAME) {
        this.MAJORNAME = MAJORNAME;
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

    public String getDevelopmentcoursenum() {
        return developmentcoursenum;
    }

    public void setDevelopmentcoursenum(String developmentcoursenum) {
        this.developmentcoursenum = developmentcoursenum;
    }

    public String getDevelopmentteachingnum() {
        return developmentteachingnum;
    }

    public void setDevelopmentteachingnum(String developmentteachingnum) {
        this.developmentteachingnum = developmentteachingnum;
    }

    public String getParttimeteachernum() {
        return parttimeteachernum;
    }

    public void setParttimeteachernum(String parttimeteachernum) {
        this.parttimeteachernum = parttimeteachernum;
    }

    public String getTraineenum() {
        return traineenum;
    }

    public void setTraineenum(String traineenum) {
        this.traineenum = traineenum;
    }

    public String getEquipmentmoney() {
        return equipmentmoney;
    }

    public void setEquipmentmoney(String equipmentmoney) {
        this.equipmentmoney = equipmentmoney;
    }

    public String getQuasidonationmoney() {
        return quasidonationmoney;
    }

    public void setQuasidonationmoney(String quasidonationmoney) {
        this.quasidonationmoney = quasidonationmoney;
    }

    public String getEmploymentnumber() {
        return employmentnumber;
    }

    public void setEmploymentnumber(String employmentnumber) {
        this.employmentnumber = employmentnumber;
    }

    public String getAnnualincome() {
        return annualincome;
    }

    public void setAnnualincome(String annualincome) {
        this.annualincome = annualincome;
    }

    public String getEmployeesnum() {
        return employeesnum;
    }

    public void setEmployeesnum(String employeesnum) {
        this.employeesnum = employeesnum;
    }

    public Date getBusiness1starttime() {
        return business1starttime;
    }

    public void setBusiness1starttime(Date business1starttime) {
        this.business1starttime = business1starttime;
    }

    public String getBusiness1starttimeStr() {
        return business1starttimeStr;
    }

    public void setBusiness1starttimeStr(String business1starttimeStr) {
        this.business1starttimeStr = business1starttimeStr;
    }

    public Date getBusiness2starttime() {
        return business2starttime;
    }

    public void setBusiness2starttime(Date business2starttime) {
        this.business2starttime = business2starttime;
    }

    public String getBusiness2starttimeStr() {
        return business2starttimeStr;
    }

    public void setBusiness2starttimeStr(String business2starttimeStr) {
        this.business2starttimeStr = business2starttimeStr;
    }

    public Date getBusiness3starttime() {
        return business3starttime;
    }

    public void setBusiness3starttime(Date business3starttime) {
        this.business3starttime = business3starttime;
    }

    public String getBusiness3starttimeStr() {
        return business3starttimeStr;
    }

    public void setBusiness3starttimeStr(String business3starttimeStr) {
        this.business3starttimeStr = business3starttimeStr;
    }

    public Date getBusiness4starttime() {
        return business4starttime;
    }

    public void setBusiness4starttime(Date business4starttime) {
        this.business4starttime = business4starttime;
    }

    public String getBusiness4starttimeStr() {
        return business4starttimeStr;
    }

    public void setBusiness4starttimeStr(String business4starttimeStr) {
        this.business4starttimeStr = business4starttimeStr;
    }

    public Date getBusiness5starttime() {
        return business5starttime;
    }

    public void setBusiness5starttime(Date business5starttime) {
        this.business5starttime = business5starttime;
    }

    public String getBusiness5starttimeStr() {
        return business5starttimeStr;
    }

    public void setBusiness5starttimeStr(String business5starttimeStr) {
        this.business5starttimeStr = business5starttimeStr;
    }

    public String getApprenticeship() {
        return apprenticeship;
    }

    public void setApprenticeship(String apprenticeship) {
        this.apprenticeship = apprenticeship;
    }

}
