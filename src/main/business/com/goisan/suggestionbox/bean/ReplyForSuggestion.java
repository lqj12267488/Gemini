package com.goisan.suggestionbox.bean;

import com.goisan.system.bean.BaseBean;

/**
 * @descroption 意见回复
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/26 14:03
 */
public class ReplyForSuggestion extends BaseBean {
// Field ----------------------------------------
    private String id;          // 主键
    private String suggestionId;// 意见id
    private String replierName; // 回复人姓名
    private String deptId;      // 部门id
    private String deptName;    // 部门名称
    private String reply;       // 回复内容
    private String suggestDate; // 回显回复时间
    // 父类字段对应关系
    /*
        creator ----- 回复人id
        createDept -- 所属部门
        createTime -- 回复意见的时间
    */
// Method ----------------------------------------
    // Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSuggestionId() {
        return suggestionId;
    }

    public void setSuggestionId(String suggestionId) {
        this.suggestionId = suggestionId;
    }

    public String getReplierName() {
        return replierName;
    }

    public void setReplierName(String replierName) {
        this.replierName = replierName;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public String getSuggestDate() {
        return suggestDate;
    }

    public void setSuggestDate(String suggestDate) {
        this.suggestDate = suggestDate;
    }
}
