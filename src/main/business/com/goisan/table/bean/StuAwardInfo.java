package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class StuAwardInfo extends BaseBean {

    /**主键id，使用uuid*/
    private String id;

    /**项目名称（全称）*/
    private String saiProName;

    /**项目类别{	xshjxmlb}*/
    private String saiProType;

   private String saiProTypeShow;

    /**级别{jb}*/
    private String saiLevel;

   private String saiLevelShow;

    /**获奖日期*/
    private String awardTime;

    /**学生名单*/
    private String studentList;

    /**指导老师名单*/
    private String coach;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSaiProName() {
        return saiProName;
    }

    public void setSaiProName(String saiProName) {
        this.saiProName = saiProName;
    }

    public String getSaiProType() {
        return saiProType;
    }

    public void setSaiProType(String saiProType) {
        this.saiProType = saiProType;
    }

    public String getSaiProTypeShow() {
        return saiProTypeShow;
    }

    public void setSaiProTypeShow(String saiProTypeShow) {
        this.saiProTypeShow = saiProTypeShow;
    }

    public String getSaiLevel() {
        return saiLevel;
    }

    public void setSaiLevel(String saiLevel) {
        this.saiLevel = saiLevel;
    }

    public String getSaiLevelShow() {
        return saiLevelShow;
    }

    public void setSaiLevelShow(String saiLevelShow) {
        this.saiLevelShow = saiLevelShow;
    }

    public String getAwardTime() {
        return awardTime;
    }

    public void setAwardTime(String awardTime) {
        this.awardTime = awardTime;
    }

    public String getStudentList() {
        return studentList;
    }

    public void setStudentList(String studentList) {
        this.studentList = studentList;
    }

    public String getCoach() {
        return coach;
    }

    public void setCoach(String coach) {
        this.coach = coach;
    }

}
