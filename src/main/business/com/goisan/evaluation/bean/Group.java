package com.goisan.evaluation.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Admin on 2017/5/23.
 */
public class Group extends BaseBean {
    private String groupId;
    private String groupName;
    private Integer membersNum;
    private String evaluationType;
    private String groupType;

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public Integer getMembersNum() {
        return membersNum;
    }

    public void setMembersNum(Integer membersNum) {
        this.membersNum = membersNum;
    }

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }

    public String getGroupType() {
        return groupType;
    }

    public void setGroupType(String groupType) {
        this.groupType = groupType;
    }
}
