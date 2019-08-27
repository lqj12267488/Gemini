package com.goisan.educational.otherAchievements.bean;

import com.goisan.system.bean.BaseBean;

public class OtherAchievementsDetails extends BaseBean {

//其他成绩详情实体

    private String id;

    private String studentId;

    private String studentName;
    private String studentNum;

   private  String A;

   private String B;

   private String C;

   private String D;

   private String scoreA;

   private String scoreB;

   private String scoreC;

   private String scoreD;


   private String peacetimeTotal;



    private String generalComment;

    private String openFlag;

    private String otherAchievementsId;

    private String commentStates;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }


    public String getScoreA() {
        return scoreA;
    }

    public void setScoreA(String scoreA) {
        this.scoreA = scoreA;
    }

    public String getScoreB() {
        return scoreB;
    }

    public void setScoreB(String scoreB) {
        this.scoreB = scoreB;
    }

    public String getScoreC() {
        return scoreC;
    }

    public void setScoreC(String scoreC) {
        this.scoreC = scoreC;
    }

    public String getScoreD() {
        return scoreD;
    }

    public void setScoreD(String scoreD) {
        this.scoreD = scoreD;
    }

    public String getA() {
        return A;
    }

    public void setA(String a) {
        A = a;
    }

    public String getB() {
        return B;
    }

    public void setB(String b) {
        B = b;
    }

    public String getC() {
        return C;
    }

    public void setC(String c) {
        C = c;
    }

    public String getD() {
        return D;
    }

    public void setD(String d) {
        D = d;
    }

    public String getPeacetimeTotal() {
        return peacetimeTotal;
    }

    public void setPeacetimeTotal(String peacetimeTotal) {
        this.peacetimeTotal = peacetimeTotal;
    }

    public String getGeneralComment() {
        return generalComment;
    }

    public void setGeneralComment(String generalComment) {
        this.generalComment = generalComment;
    }

    public String getOpenFlag() {
        return openFlag;
    }

    public void setOpenFlag(String openFlag) {
        this.openFlag = openFlag;
    }

    public String getOtherAchievementsId() {
        return otherAchievementsId;
    }

    public void setOtherAchievementsId(String otherAchievementsId) {
        this.otherAchievementsId = otherAchievementsId;
    }

    public String getCommentStates() {
        return commentStates;
    }

    public void setCommentStates(String commentStates) {
        this.commentStates = commentStates;
    }

    public String getStudentNum() {
        return studentNum;
    }

    public void setStudentNum(String studentNum) {
        this.studentNum = studentNum;
    }
}
