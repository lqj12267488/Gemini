package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class ClubReward extends BaseBean {

    /***/
    private String id;

    /**社团名称*/
    private String name;

    /**获奖级别{hjjb}*/
    private String rewardLevel;

   private String rewardLevelShow;

    /**获奖日期（年月）*/
    private String rewardDate;

    /**颁奖单位*/
    private String awardUnit;

    /**指导教师名单*/
    private String guidanceTeacher;

    /**项目名称*/
    private String projectName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRewardLevel() {
        return rewardLevel;
    }

    public void setRewardLevel(String rewardLevel) {
        this.rewardLevel = rewardLevel;
    }

    public String getRewardLevelShow() {
        return rewardLevelShow;
    }

    public void setRewardLevelShow(String rewardLevelShow) {
        this.rewardLevelShow = rewardLevelShow;
    }

    public String getRewardDate() {
        return rewardDate;
    }

    public void setRewardDate(String rewardDate) {
        this.rewardDate = rewardDate;
    }

    public String getAwardUnit() {
        return awardUnit;
    }

    public void setAwardUnit(String awardUnit) {
        this.awardUnit = awardUnit;
    }

    public String getGuidanceTeacher() {
        return guidanceTeacher;
    }

    public void setGuidanceTeacher(String guidanceTeacher) {
        this.guidanceTeacher = guidanceTeacher;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
}
