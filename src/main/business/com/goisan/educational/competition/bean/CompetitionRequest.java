package com.goisan.educational.competition.bean;

import com.goisan.system.bean.BaseBean;

public class CompetitionRequest extends BaseBean{

    private String id;
    private String competitionName;
    private String branchMatch;
    private String department;
    private String major;
    private String instructor;
    private String competitionNature;
    private String time;
    private String organizationUnit;
    private String score;
    private String grade;
    private String competitionNameShow;
    private String count;
    private String studentId;
    private String studentName;
    private String sendDept;//发证机关

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompetitionName() {
        return competitionName;
    }

    public void setCompetitionName(String competitionName) {
        this.competitionName = competitionName;
    }

    public String getBranchMatch() {
        return branchMatch;
    }

    public void setBranchMatch(String branchMatch) {
        this.branchMatch = branchMatch;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getInstructor() {
        return instructor;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public String getCompetitionNature() {
        return competitionNature;
    }

    public void setCompetitionNature(String competitionNature) {
        this.competitionNature = competitionNature;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getOrganizationUnit() {
        return organizationUnit;
    }

    public void setOrganizationUnit(String organizationUnit) {
        this.organizationUnit = organizationUnit;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getCompetitionNameShow() {
        return competitionNameShow;
    }

    public void setCompetitionNameShow(String competitionNameShow) {
        this.competitionNameShow = competitionNameShow;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
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

    public String getSendDept() {
        return sendDept;
    }

    public void setSendDept(String sendDept) {
        this.sendDept = sendDept;
    }
}
