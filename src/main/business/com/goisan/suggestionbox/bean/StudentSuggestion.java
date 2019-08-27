package com.goisan.suggestionbox.bean;

import com.goisan.system.bean.BaseBean;

import java.util.List;

/**
 * @descroption 学生意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/26 13:45
 */
public class StudentSuggestion extends BaseBean {
// Field ----------------------------------------
    private String id;                          // 主键
    private String majorSchool;                 // 所属学院id
    private String majorSchoolShow;             // 所属学院名称
    private String majorCode;                   // 专业代码
    private String majorCodeShow;               // 专业名称
    private String classId;                     // 班级id
    private String classShow;                   // 班级名称
    private String studentName;                 // 学生姓名
    private String title;                       // 主题
    private String suggestion;                  // 内容(即意见)
    private List<ReplyForSuggestion> replyList; // 回复列表
    private String replyFlag;                   // 回复标记(1-待处理;2-已回复;3-不回复)
    private String replyFlagShow;               // 回复标记回显
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
        creator ----- 学生id
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

    public String getMajorSchool() {
        return majorSchool;
    }

    public void setMajorSchool(String majorSchool) {
        this.majorSchool = majorSchool;
    }

    public String getMajorSchoolShow() {
        return majorSchoolShow;
    }

    public void setMajorSchoolShow(String majorSchoolShow) {
        this.majorSchoolShow = majorSchoolShow;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getMajorCodeShow() {
        return majorCodeShow;
    }

    public void setMajorCodeShow(String majorCodeShow) {
        this.majorCodeShow = majorCodeShow;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassShow() {
        return classShow;
    }

    public void setClassShow(String classShow) {
        this.classShow = classShow;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
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
