package com.goisan.educational.teachingresult.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/27.
 */
public class TeachingResultWriting extends BaseBean{
    private String id;
    private String personId;
    private String deptId;
    private String typicalFlag;
    private String role;
    private String writingType;
    private String writingName;
    private String subject;
    private String publishDate;
    private String pressName;
    private String publishNum;
    private String totalCount;
    private String wordCount;
    private String remark;
    private String resultType;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getTypicalFlag() {
        return typicalFlag;
    }

    public void setTypicalFlag(String typicalFlag) {
        this.typicalFlag = typicalFlag;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getWritingType() {
        return writingType;
    }

    public void setWritingType(String writingType) {
        this.writingType = writingType;
    }

    public String getWritingName() {
        return writingName;
    }

    public void setWritingName(String writingName) {
        this.writingName = writingName;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public String getPressName() {
        return pressName;
    }

    public void setPressName(String pressName) {
        this.pressName = pressName;
    }

    public String getPublishNum() {
        return publishNum;
    }

    public void setPublishNum(String publishNum) {
        this.publishNum = publishNum;
    }

    public String getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(String totalCount) {
        this.totalCount = totalCount;
    }

    public String getWordCount() {
        return wordCount;
    }

    public void setWordCount(String wordCount) {
        this.wordCount = wordCount;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
