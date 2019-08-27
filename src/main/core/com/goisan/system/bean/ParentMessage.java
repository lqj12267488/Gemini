package com.goisan.system.bean;

import com.goisan.system.bean.BaseBean;

public class ParentMessage extends BaseBean {
    private String messageId;
    private String title;
    private String message;
    private String type;
    private String messageParentId;
    private String personId;
    private String personIdShow;
    private String deptId;
    private String typeShow;
    private String creatorShow;
    private String readeFlag;
    private String readeFlagShow;
    private String photoUrl;
    private String classView;

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMessageParentId() {
        return messageParentId;
    }

    public void setMessageParentId(String messageParentId) {
        this.messageParentId = messageParentId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getTypeShow() {
        return typeShow;
    }

    public void setTypeShow(String typeShow) {
        this.typeShow = typeShow;
    }

    public String getCreatorShow() {
        return creatorShow;
    }

    public void setCreatorShow(String creatorShow) {
        this.creatorShow = creatorShow;
    }

    public String getReadeFlag() {
        return readeFlag;
    }

    public void setReadeFlag(String readeFlag) {
        this.readeFlag = readeFlag;
    }

    public String getReadeFlagShow() {
        return readeFlagShow;
    }

    public void setReadeFlagShow(String readeFlagShow) {
        this.readeFlagShow = readeFlagShow;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getClassView() {
        return classView;
    }

    public void setClassView(String classView) {
        this.classView = classView;
    }
}
