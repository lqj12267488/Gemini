package com.goisan.suggestionbox.bean;

import com.goisan.system.bean.BaseBean;

import java.util.List;

/**
 * @descroption 教师意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/26 13:45
 */
public class TeacherSuggestion extends BaseBean {
// Field ----------------------------------------
    private String id;                          // 主键
    private String deptName;                    // 部门名称
    private String teacherName;                 // 教师姓名
    private String title;                       // 主题
    private String suggestion;                  // 内容(即意见)
    private List<ReplyForSuggestion> replyList; // 回复列表
    private String replyFlag;                   // 回复标记(1-待处理;2-已回复;3-不回复)
    private String replyFlagShow;               // 回复标记显示
    private String suggestDate;                 // 回显提建议时间
    private String viewFlag;

    public String getViewFlag() {
        return viewFlag;
    }

    public void setViewFlag(String viewFlag) {
        this.viewFlag = viewFlag;
    }

    // 父类字段对应关系
    /*
        creator ----- 教师id
        createDept -- 所属部门
        createTime -- 提出意见的时间
    */
// Method ----------------------------------------
    // Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSuggestion() {
        return suggestion;
    }

    public void setSuggestion(String suggestion) {
        this.suggestion = suggestion;
    }

    public List<ReplyForSuggestion> getReplyList() {
        return replyList;
    }

    public void setReplyList(List<ReplyForSuggestion> replyList) {
        this.replyList = replyList;
    }

    public String getReplyFlag() {
        return replyFlag;
    }

    public void setReplyFlag(String replyFlag) {
        this.replyFlag = replyFlag;
    }

    public String getReplyFlagShow() {
        return replyFlagShow;
    }

    public void setReplyFlagShow(String replyFlagShow) {
        this.replyFlagShow = replyFlagShow;
    }

    public String getSuggestDate() {
        return suggestDate;
    }

    public void setSuggestDate(String suggestDate) {
        this.suggestDate = suggestDate;
    }
}
