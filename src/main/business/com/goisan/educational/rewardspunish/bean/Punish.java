package com.goisan.educational.rewardspunish.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
public class Punish extends BaseBean{
    private String id;
    private String punishPersonId;
    private String punishPersonDeptId;
    private String punishName;
    private String punishTime;
    private String punishReason;
    private String punishContent;
    private String punishDocumentNumber;
    private String punishTerm;
    private String punishLevel;
    private String cancelReason;
    private String cancelDocumentNumber;
    private String cancelTime;
    private String punishStatus;
    private String remark;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPunishPersonId() {
        return punishPersonId;
    }

    public void setPunishPersonId(String punishPersonId) {
        this.punishPersonId = punishPersonId;
    }

    public String getPunishPersonDeptId() {
        return punishPersonDeptId;
    }

    public void setPunishPersonDeptId(String punishPersonDeptId) {
        this.punishPersonDeptId = punishPersonDeptId;
    }

    public String getPunishName() {
        return punishName;
    }

    public void setPunishName(String punishName) {
        this.punishName = punishName;
    }

    public String getPunishTime() {
        return punishTime;
    }

    public void setPunishTime(String punishTime) {
        this.punishTime = punishTime;
    }

    public String getPunishReason() {
        return punishReason;
    }

    public void setPunishReason(String punishReason) {
        this.punishReason = punishReason;
    }

    public String getPunishContent() {
        return punishContent;
    }

    public void setPunishContent(String punishContent) {
        this.punishContent = punishContent;
    }

    public String getPunishDocumentNumber() {
        return punishDocumentNumber;
    }

    public void setPunishDocumentNumber(String punishDocumentNumber) {
        this.punishDocumentNumber = punishDocumentNumber;
    }

    public String getPunishTerm() {
        return punishTerm;
    }

    public void setPunishTerm(String punishTerm) {
        this.punishTerm = punishTerm;
    }

    public String getPunishLevel() {
        return punishLevel;
    }

    public void setPunishLevel(String punishLevel) {
        this.punishLevel = punishLevel;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    public String getCancelDocumentNumber() {
        return cancelDocumentNumber;
    }

    public void setCancelDocumentNumber(String cancelDocumentNumber) {
        this.cancelDocumentNumber = cancelDocumentNumber;
    }

    public String getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(String cancelTime) {
        this.cancelTime = cancelTime;
    }

    public String getPunishStatus() {
        return punishStatus;
    }

    public void setPunishStatus(String punishStatus) {
        this.punishStatus = punishStatus;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
