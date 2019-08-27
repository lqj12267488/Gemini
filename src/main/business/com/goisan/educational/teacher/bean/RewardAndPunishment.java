package com.goisan.educational.teacher.bean;

import com.goisan.system.bean.BaseBean;

/**
 * 奖励与处罚
 */
public class RewardAndPunishment extends BaseBean {

    private String rewardId;
    private String rewardName; //名称
    private String rewardLevel;//级别
    private String cognizanceUnit;//认定单位
    private String cognizanceProcess;//认定过程
    private String cognizanceConclusion;//认定结论
    private String cognizanceDate;//认定时间
    private String termValidity;//有效期

    public String getRewardId() {
        return rewardId;
    }

    public void setRewardId(String rewardId) {
        this.rewardId = rewardId;
    }

    public String getRewardName() {
        return rewardName;
    }

    public void setRewardName(String rewardName) {
        this.rewardName = rewardName;
    }

    public String getRewardLevel() {
        return rewardLevel;
    }

    public void setRewardLevel(String rewardLevel) {
        this.rewardLevel = rewardLevel;
    }

    public String getCognizanceUnit() {
        return cognizanceUnit;
    }

    public void setCognizanceUnit(String cognizanceUnit) {
        this.cognizanceUnit = cognizanceUnit;
    }

    public String getCognizanceProcess() {
        return cognizanceProcess;
    }

    public void setCognizanceProcess(String cognizanceProcess) {
        this.cognizanceProcess = cognizanceProcess;
    }

    public String getCognizanceConclusion() {
        return cognizanceConclusion;
    }

    public void setCognizanceConclusion(String cognizanceConclusion) {
        this.cognizanceConclusion = cognizanceConclusion;
    }

    public String getCognizanceDate() {
        return cognizanceDate;
    }

    public void setCognizanceDate(String cognizanceDate) {
        this.cognizanceDate = cognizanceDate;
    }

    public String getTermValidity() {
        return termValidity;
    }

    public void setTermValidity(String termValidity) {
        this.termValidity = termValidity;
    }
}
